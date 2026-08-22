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

import '../../codegen/trigger_config.dart';
import '../../util/gcp.dart';
import '../../util/workspace.dart';

import 'build.dart';

class DeployCommand extends Command<void> {
  @override
  final String name = 'deploy';

  @override
  final String description =
      'Provision declarative GCP infrastructure with Terraform for the serverless Cloud Run service.';

  DeployCommand() {
    argParser
      ..addOption(
        'package-dir',
        abbr: 'p',
        defaultsTo: '.',
        help: 'Path to target package directory containing dtt.yaml.',
      )
      ..addOption(
        'image',
        abbr: 'i',
        help:
            'Target container image digest/URL. Auto-derived from build state if omitted.',
      )
      ..addFlag(
        'build',
        abbr: 'b',
        defaultsTo: true,
        help:
            'Triggers container build (dtt build) prior to deployment if image is omitted.',
      );
  }

  @override
  Future<void> run() async {
    final packageDirParam = argResults?['package-dir'] as String? ?? '.';
    final packageDir = p.canonicalize(packageDirParam);

    final config = await DttConfig.load(packageDir);
    final projectId = config.projectId;
    final region = config.region;

    String? containerImage = argResults?['image'] as String?;

    final stateFile = File(p.join(packageDir, '.dtt', 'build_state.json'));

    if (containerImage == null || containerImage.isEmpty) {
      final shouldBuild = argResults?['build'] as bool? ?? true;
      if (shouldBuild && !await stateFile.exists()) {
        print('💡 No container image supplied. Running dtt build...');
        final buildCmd = BuildCommand();
        await buildCmd.run();
      }

      if (await stateFile.exists()) {
        final stateContent = await stateFile.readAsString();
        final stateJson = jsonDecode(stateContent) as Map<String, dynamic>;
        containerImage =
            stateJson['full_image_digest'] as String? ??
            stateJson['image_url'] as String?;
      }
    }

    if (containerImage == null || containerImage.isEmpty) {
      throw StateError(
        'No container image found! Specify --image=<url> or run dtt build first.',
      );
    }

    print('🚀 Deploying infrastructure using container image: $containerImage');

    final workspaceRoot =
        findWorkspaceRoot(packageDir) ?? p.dirname(packageDir);
    var tfDir = Directory(p.join(workspaceRoot, 'terraform'));
    if (!await tfDir.exists()) {
      tfDir = Directory(p.join(packageDir, 'terraform'));
    }
    if (!await tfDir.exists()) {
      throw FileSystemException(
        'Terraform manifests directory not found. Run dtt generate first.',
        tfDir.path,
      );
    }

    final env = Map<String, String>.from(Platform.environment);
    final token = await resolveGcloudAuthToken();
    if (token != null) {
      env['CLOUDSDK_AUTH_ACCESS_TOKEN'] = token;
      env['GOOGLE_OAUTH_ACCESS_TOKEN'] = token;
    }

    print('⚙️ Initializing Terraform in ${tfDir.path}...');
    final initRes = await Process.run(
      'terraform',
      ['init'],
      workingDirectory: tfDir.path,
      environment: env,
    );

    if (initRes.exitCode != 0) {
      stderr.write(initRes.stderr);
      throw ProcessException(
        'terraform',
        ['init'],
        'Terraform init failed',
        initRes.exitCode,
      );
    }

    print('🏗️ Applying Terraform configuration...');
    final applyRes = await Process.run(
      'terraform',
      [
        'apply',
        '-auto-approve',
        '-var=project_id=$projectId',
        '-var=region=$region',
        '-var=container_image=$containerImage',
      ],
      workingDirectory: tfDir.path,
      environment: env,
    );

    if (applyRes.exitCode != 0) {
      stderr.write(applyRes.stderr);
      throw ProcessException(
        'terraform',
        ['apply'],
        'Terraform apply failed',
        applyRes.exitCode,
      );
    }

    print(applyRes.stdout);
    print('✅ Declarative Terraform deployment complete!');
  }
}
