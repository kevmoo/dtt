// Copyright 2026 Google LLC
import 'dart:convert';
import 'dart:io';
import 'package:yaml/yaml.dart';

const _upstreamOrgRepo = 'googleapis/google-cloudevents';
const _upstreamUrl = 'https://github.com/$_upstreamOrgRepo';
const _upstreamApiUrl = 'https://api.github.com/repos/$_upstreamOrgRepo';

const _eventsLibDir = 'packages/google_cloud_events/lib';
const _dartOutFlag = '--dart_out=$_eventsLibDir';

Future<void> main() async {
  final configFile = File('catalog/protobuf_source.yaml');
  if (!configFile.existsSync()) {
    stderr.writeln('Missing catalog/protobuf_source.yaml');
    exitCode = 1;
    return;
  }

  final doc = loadYaml(configFile.readAsStringSync()) as YamlMap;
  final pinnedSha = doc['pinned_sha'] as String?;
  final targets = doc['proto_targets'] as YamlList?;

  if (pinnedSha == null || targets == null) {
    throw const FormatException('Invalid protobuf_source.yaml');
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
          } else {
            final cmpApiUrl =
                '$_upstreamApiUrl/compare/'
                '$pinnedSha...$headSha';
            final cmpRes = await Process.run('curl', [
              '-s',
              '-H',
              'User-Agent: dart_terraform_triggers',
              cmpApiUrl,
            ]);
            if (cmpRes.exitCode == 0) {
              final cmpJson =
                  jsonDecode(cmpRes.stdout.toString()) as Map<String, dynamic>;
              final behindBy = cmpJson['ahead_by'] as int?;
              if (behindBy != null) {
                print(
                  '⚠️ Pinned commit is $behindBy commits behind upstream HEAD.',
                );
              }
            }
          }
        }
      }
    } catch (_) {
      // Non-fatal if offline or GitHub rate-limited
    }

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
    final thirdPartyRoot = Directory('${extractedDir.path}/third_party');

    for (final target in targets) {
      final targetStr = target.toString();
      print('🔨 Compiling $targetStr...');
      final protoRes = await Process.run('protoc', [
        '--proto_path=${protoRoot.path}',
        if (thirdPartyRoot.existsSync()) '--proto_path=${thirdPartyRoot.path}',
        _dartOutFlag,
        '${protoRoot.path}/$targetStr',
      ]);
      if (protoRes.exitCode != 0) {
        stderr.writeln('PROTOC STDERR:\n${protoRes.stderr}');
        throw ProcessException('protoc', [
          targetStr,
        ], protoRes.stderr.toString());
      }
    }

    print('📦 Formatting generated Protobuf models...');
    await Process.run('dart', ['format', '$_eventsLibDir/google/events']);
    print('✅ Protobuf models synced hermetically!');
  } finally {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  }
}
