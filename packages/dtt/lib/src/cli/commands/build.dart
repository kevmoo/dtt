// Copyright 2026 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import '../../util/dart_sdk.dart';

class BuildCommand extends Command<void> {
  @override
  final String name = 'build';

  @override
  final String description =
      'Compile Dart server binary, build container image, and push image to Google Artifact Registry.';

  BuildCommand() {
    argParser
      ..addOption(
        'package-dir',
        abbr: 'p',
        defaultsTo: '.',
        help: 'Path to target package directory containing dtt.yaml.',
      )
      ..addOption(
        'tag',
        abbr: 't',
        help: 'Custom tag for the container image (defaults to timestamp).',
      );
  }

  @override
  Future<void> run() async {
    final packageDirParam = argResults?['package-dir'] as String? ?? '.';
    final packageDir = p.canonicalize(packageDirParam);

    final configFile = File(p.join(packageDir, 'dtt.yaml'));
    if (!await configFile.exists()) {
      throw FileSystemException(
        'Declarative config dtt.yaml not found inside package folder.',
        configFile.path,
      );
    }

    final content = await configFile.readAsString();
    final doc = loadYaml(content) as YamlMap;
    final serviceNode = doc['service'] as YamlMap?;
    if (serviceNode == null) {
      throw const FormatException(
        'Config dtt.yaml missing mandatory [service] mapping block.',
      );
    }

    final serviceName = serviceNode['name'] as String? ?? 'dtt-service';
    final projectId = serviceNode['project_id'] as String? ?? 'gcp-project-id';
    final region = serviceNode['region'] as String? ?? 'us-central1';

    final tag =
        argResults?['tag'] as String? ??
        DateTime.now().millisecondsSinceEpoch.toString();

    print('🔨 Building Dart release container for $serviceName...');
    final stageDir = Directory.systemTemp.createTempSync('dtt_build_');

    try {
      final binDir = Directory(p.join(stageDir.path, 'bin'));
      await binDir.create(recursive: true);

      final serverFile = File(p.join(packageDir, 'bin', 'server.dart'));
      if (!await serverFile.exists()) {
        throw FileSystemException(
          'Server entrypoint bin/server.dart not found. Run dtt generate first.',
          serverFile.path,
        );
      }

      final targetExe = p.join(binDir.path, 'server');
      print('📦 Attempting local Dart AOT compilation...');
      final compileRes = await Process.run(resolveDartExecutable(), [
        'compile',
        'exe',
        serverFile.path,
        '-o',
        targetExe,
        '--target-os',
        'linux',
        '--target-arch',
        'x64',
      ], workingDirectory: packageDir);

      final isLocalAotSuccess =
          compileRes.exitCode == 0 && File(targetExe).existsSync();

      if (isLocalAotSuccess) {
        print('✅ Local AOT compilation succeeded!');
        final dockerfile = File(p.join(stageDir.path, 'Dockerfile'));
        await dockerfile.writeAsString('''
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
COPY bin/server /app/server
EXPOSE 8080
CMD ["/app/server"]
''');
      } else {
        print(
          'ℹ️ Local AOT compiler unavailable. Fallback to Cloud Build container compilation...',
        );
        // Locate workspace root to include dependent packages
        final workspaceRoot = _findWorkspaceRoot(packageDir) ?? packageDir;
        final relPackageDir = p.relative(packageDir, from: workspaceRoot);

        await _copyDirectory(Directory(workspaceRoot), stageDir);

        final targetSubDir = relPackageDir == '.' ? '.' : relPackageDir;
        final dockerfile = File(p.join(stageDir.path, 'Dockerfile'));
        await dockerfile.writeAsString('''
FROM dart:stable AS build
WORKDIR /app
COPY . .
RUN dart pub get
WORKDIR /app/$targetSubDir
RUN dart compile exe bin/server.dart -o bin/server

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=build /app/$targetSubDir/bin/server /app/server
EXPOSE 8080
CMD ["/app/server"]
''');
      }

      // 3. Ensure Artifact Registry repo exists
      final repoName = 'dtt-repository';
      final env = Map<String, String>.from(Platform.environment);
      final adcTokenRes = await Process.run('gcloud', [
        'auth',
        'application-default',
        'print-access-token',
      ]);
      if (adcTokenRes.exitCode == 0) {
        final token = (adcTokenRes.stdout as String).trim();
        if (token.isNotEmpty) {
          env['CLOUDSDK_AUTH_ACCESS_TOKEN'] = token;
        }
      }

      print('🔎 Checking Google Artifact Registry repository $repoName...');
      final checkRepoRes = await Process.run('gcloud', [
        'artifacts',
        'repositories',
        'describe',
        repoName,
        '--location=$region',
        '--project=$projectId',
      ], environment: env);

      if (checkRepoRes.exitCode != 0) {
        print(
          '🚀 Creating Artifact Registry repository $repoName in $region...',
        );
        final createRepoRes = await Process.run('gcloud', [
          'artifacts',
          'repositories',
          'create',
          repoName,
          '--repository-format=DOCKER',
          '--location=$region',
          '--project=$projectId',
          '--description=DTT Container Repository',
        ], environment: env);
        if (createRepoRes.exitCode != 0) {
          stderr.write(createRepoRes.stderr);
        }
      }

      // 4. Submit build to Cloud Build / Artifact Registry
      final imageUrl =
          '$region-docker.pkg.dev/$projectId/$repoName/$serviceName:$tag';
      print('🚀 Submitting container build for $imageUrl...');
      final buildRes = await Process.run('gcloud', [
        'builds',
        'submit',
        '--tag=$imageUrl',
        '--project=$projectId',
        stageDir.path,
      ], environment: env);

      if (buildRes.exitCode != 0) {
        stderr.write(buildRes.stderr);
        throw ProcessException(
          'gcloud',
          ['builds', 'submit'],
          'Cloud build failed',
          buildRes.exitCode,
        );
      }

      // 5. Retrieve image digest
      print('🔍 Fetching container image digest...');
      final describeRes = await Process.run('gcloud', [
        'artifacts',
        'docker',
        'images',
        'describe',
        imageUrl,
        '--format=value(image_summary.digest)',
      ], environment: env);

      String digest = '';
      if (describeRes.exitCode == 0) {
        digest = (describeRes.stdout as String).trim();
      }

      final fullImageDigest = digest.isNotEmpty
          ? '$region-docker.pkg.dev/$projectId/$repoName/$serviceName@$digest'
          : imageUrl;

      // 6. Write state to .dtt/build_state.json
      final dttDir = Directory(p.join(packageDir, '.dtt'));
      if (!await dttDir.exists()) {
        await dttDir.create(recursive: true);
      }

      final stateFile = File(p.join(dttDir.path, 'build_state.json'));
      final stateData = {
        'service': serviceName,
        'project_id': projectId,
        'region': region,
        'image_url': imageUrl,
        'digest': digest,
        'full_image_digest': fullImageDigest,
        'built_at': DateTime.now().toIso8601String(),
      };

      await stateFile.writeAsString(
        const JsonEncoder.withIndent('  ').convert(stateData),
      );

      print('✅ Container build complete! Digest: $fullImageDigest');
      print('📄 Build state persisted to ${stateFile.path}');
    } finally {
      if (await stageDir.exists()) {
        await stageDir.delete(recursive: true);
      }
    }
  }

  String? _findWorkspaceRoot(String startDir) {
    var dir = Directory(startDir);
    while (true) {
      final pubspec = File(p.join(dir.path, 'pubspec.yaml'));
      if (pubspec.existsSync()) {
        final content = pubspec.readAsStringSync();
        if (content.contains('workspace:')) {
          return dir.path;
        }
      }
      final parent = dir.parent;
      if (parent.path == dir.path) {
        break;
      }
      dir = parent;
    }
    return null;
  }

  Future<void> _copyDirectory(Directory src, Directory dest) async {
    await dest.create(recursive: true);
    await for (final entity in src.list(recursive: false)) {
      final name = p.basename(entity.path);
      if (name.startsWith('.') || name == 'build' || name == 'terraform') {
        continue;
      }
      if (entity is Directory) {
        final newDest = Directory(p.join(dest.path, name));
        await _copyDirectory(entity, newDest);
      } else if (entity is File) {
        await entity.copy(p.join(dest.path, name));
      }
    }
  }
}
