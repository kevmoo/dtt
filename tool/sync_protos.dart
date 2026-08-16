// Copyright 2026 Google LLC
import 'dart:convert';
import 'dart:io';
import 'package:yaml/yaml.dart';

const _upstreamOrgRepo = 'googleapis/google-cloudevents';
const _upstreamUrl = 'https://github.com/$_upstreamOrgRepo';
const _upstreamApiUrl = 'https://api.github.com/repos/$_upstreamOrgRepo';

const _eventsLibDir = 'packages/google_cloud_events/lib';
const _dartOutFlag = '--dart_out=$_eventsLibDir';

Future<String> _ensureProtoc(Directory tempDir) async {
  final whichRes = await Process.run('which', ['protoc']);
  if (whichRes.exitCode == 0 && (whichRes.stdout as String).trim().isNotEmpty) {
    return (whichRes.stdout as String).trim();
  }

  print(
    '⚡ Local protoc binary not found on PATH. Downloading hermetic protoc binary...',
  );
  final isMac = Platform.isMacOS;
  final isArm =
      Platform.version.contains('arm64') ||
      Platform.version.contains('aarch64');

  String osArch;
  if (isMac) {
    osArch = isArm ? 'osx-aarch_64' : 'osx-x86_64';
  } else {
    osArch = isArm ? 'linux-aarch_64' : 'linux-x86_64';
  }

  final protocZipUrl =
      'https://github.com/protocolbuffers/protobuf/releases/download/v28.3/protoc-28.3-$osArch.zip';
  final zipPath = '${tempDir.path}/protoc.zip';
  final extractDir = '${tempDir.path}/protoc_bin';

  final curlRes = await Process.run('curl', [
    '-fL',
    protocZipUrl,
    '-o',
    zipPath,
  ]);
  if (curlRes.exitCode != 0) {
    throw ProcessException('curl', [
      '-fL',
      protocZipUrl,
    ], 'Failed to download protoc binary.');
  }

  await Process.run('unzip', ['-q', zipPath, '-d', extractDir]);
  final protocBin = '$extractDir/bin/protoc';
  await Process.run('chmod', ['+x', protocBin]);
  return protocBin;
}

Future<void> main() async {
  final configFile = File('catalog/catalog.yaml');
  if (!configFile.existsSync()) {
    stderr.writeln('Missing catalog/catalog.yaml');
    exitCode = 1;
    return;
  }

  final doc = loadYaml(configFile.readAsStringSync()) as YamlMap;
  final pinnedSha = doc['pinned_sha'] as String?;
  final services = doc['services'] as YamlMap?;

  if (pinnedSha == null || services == null) {
    throw const FormatException('Invalid catalog/catalog.yaml');
  }

  final targets = <String>{};
  for (final entry in services.entries) {
    final svcMap = entry.value as YamlMap;
    final target = svcMap['proto_target'] as String?;
    if (target != null && target.isNotEmpty) {
      targets.add(target);
    }
  }

  final tempDir = Directory.systemTemp.createTempSync('proto_sync_');
  print('📡 Created staging directory: ${tempDir.path}');

  try {
    print('🌐 Upstream Repo: $_upstreamUrl');
    const headApiUrl = '$_upstreamApiUrl/commits/main';
    try {
      final headRes = await Process.run('curl', [
        '-s',
        '-H',
        'User-Agent: dart_terraform_triggers',
        headApiUrl,
      ]);
      if (headRes.exitCode == 0) {
        final headJson =
            jsonDecode(headRes.stdout.toString()) as Map<String, dynamic>;
        final headSha = headJson['sha'] as String?;
        if (headSha != null) {
          print('📌 Pinned SHA : $pinnedSha');
          print('🎯 Latest HEAD: $headSha');

          if (headSha == pinnedSha) {
            print('✨ Pinned commit is up-to-date with upstream HEAD!');
          }
        }
      }
    } catch (_) {
      // Non-fatal if offline or GitHub rate-limited
    }

    final protocExecutable = await _ensureProtoc(tempDir);

    print('📥 Fetching pinned upstream SHA $pinnedSha...');
    final repoUrl = '$_upstreamUrl/archive/$pinnedSha.tar.gz';

    final curlRes = await Process.run('curl', [
      '-fL',
      repoUrl,
      '-o',
      '${tempDir.path}/protos.tar.gz',
    ]);
    if (curlRes.exitCode != 0) {
      throw ProcessException('curl', ['-fL'], curlRes.stderr.toString());
    }

    final tarRes = await Process.run('tar', [
      '-xzf',
      '${tempDir.path}/protos.tar.gz',
      '-C',
      tempDir.path,
    ]);
    if (tarRes.exitCode != 0) {
      throw ProcessException('tar', ['-xzf'], tarRes.stderr.toString());
    }

    final extractedDirs = tempDir.listSync().whereType<Directory>().toList();
    if (extractedDirs.isEmpty) {
      throw StateError('Tarball extracted no root folder');
    }
    final extractedDir = extractedDirs.first;

    final protoRoot = Directory('${extractedDir.path}/proto');
    final thirdPartyGoogleApis = Directory(
      '${extractedDir.path}/third_party/googleapis',
    );
    final thirdPartyRoot = Directory('${extractedDir.path}/third_party');
    final protocInclude = Directory('${tempDir.path}/protoc_bin/include');

    final home = Platform.environment['HOME'] ?? '';
    final pubCacheBin = '$home/.pub-cache/bin';
    final existingPath = Platform.environment['PATH'] ?? '';
    final env = {...Platform.environment, 'PATH': '$pubCacheBin:$existingPath'};

    // Common googleapis helper protos needed by audit logs and other services
    final helperProtos = [
      'google/api/monitored_resource.proto',
      'google/api/launch_stage.proto',
      'google/rpc/status.proto',
      'google/rpc/context/attribute_context.proto',
    ];

    for (final helper in helperProtos) {
      final helperFile = File('${thirdPartyGoogleApis.path}/$helper');
      if (helperFile.existsSync()) {
        print('🔨 Compiling third-party dependency $helper...');
        final res = await Process.run(protocExecutable, [
          '--proto_path=${thirdPartyGoogleApis.path}',
          if (protocInclude.existsSync()) '--proto_path=${protocInclude.path}',
          _dartOutFlag,
          helperFile.path,
        ], environment: env);
        if (res.exitCode != 0) {
          stderr.writeln('HELPER PROTOC STDERR ($helper):\n${res.stderr}');
        }
      }
    }

    for (final target in targets) {
      final targetStr = target.toString();
      print('🔨 Compiling $targetStr...');
      final protoRes = await Process.run(protocExecutable, [
        '--proto_path=${protoRoot.path}',
        if (thirdPartyGoogleApis.existsSync())
          '--proto_path=${thirdPartyGoogleApis.path}',
        if (thirdPartyRoot.existsSync()) '--proto_path=${thirdPartyRoot.path}',
        if (protocInclude.existsSync()) '--proto_path=${protocInclude.path}',
        _dartOutFlag,
        '${protoRoot.path}/$targetStr',
      ], environment: env);
      if (protoRes.exitCode != 0) {
        stderr.writeln('PROTOC STDERR:\n${protoRes.stderr}');
        throw ProcessException(protocExecutable, [
          targetStr,
        ], protoRes.stderr.toString());
      }
    }

    print('📦 Formatting generated Protobuf models...');
    await Process.run('dart', ['format', '$_eventsLibDir/google']);
    print('✅ Protobuf models synced hermetically!');
  } finally {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
      print('🧹 Cleaned temporary staging directory.');
    }
  }
}
