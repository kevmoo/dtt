// Copyright 2026 Google LLC

import 'dart:io';

import 'package:checks/checks.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('Catalog Manifest Integrity & Schema Tests', () {
    late File catalogFile;
    late YamlMap doc;
    late String rootDir;

    setUp(() {
      rootDir = p.canonicalize(p.join(Directory.current.path, '..'));
      catalogFile = File(p.join(rootDir, 'catalog', 'catalog.yaml'));
      check(catalogFile.existsSync()).isTrue();
      doc = loadYaml(catalogFile.readAsStringSync()) as YamlMap;
    });

    test('catalog.yaml has valid pinned_sha and services map', () {
      final pinnedSha = doc['pinned_sha'] as String?;
      check(pinnedSha).isNotNull();
      check(pinnedSha!.length).equals(40);

      final services = doc['services'] as YamlMap?;
      check(services).isNotNull();
      check(services!).isNotEmpty();
    });

    test(
      'all service keys and triggers are alphabetically sorted and unique',
      () {
        final services = doc['services'] as YamlMap;
        final serviceKeys = services.keys.map((k) => k.toString()).toList();
        final sortedServiceKeys = List<String>.from(serviceKeys)..sort();
        check(serviceKeys).deepEquals(sortedServiceKeys);

        final allTriggers = <String>[];

        for (final entry in services.entries) {
          final key = entry.key.toString();
          final svc = entry.value as YamlMap;

          check(svc['enum_prefix']).isNotNull();
          check(svc['proto_class']).isNotNull();
          check(svc['events_import']).isNotNull();
          check(svc['base_path']).isNotNull();

          final triggers = (svc['triggers'] as YamlList)
              .map((t) => t.toString())
              .toList();
          check(triggers).isNotEmpty();

          final sortedTriggers = List<String>.from(triggers)..sort();
          check(triggers).deepEquals(sortedTriggers);

          for (final trigger in triggers) {
            check(trigger.startsWith(key)).isTrue();
            check(allTriggers.contains(trigger)).isFalse();
            allTriggers.add(trigger);
          }
        }
      },
    );

    test('physical models and proto classes exist on disk for all services', () {
      final services = doc['services'] as YamlMap;
      final eventsLibDir = p.join(
        rootDir,
        'packages',
        'google_cloud_events',
        'lib',
      );

      for (final entry in services.entries) {
        final key = entry.key.toString();
        final svc = entry.value as YamlMap;
        final eventsImport = svc['events_import'] as String;
        final protoClass = svc['proto_class'] as String;

        if (eventsImport.startsWith('package:')) {
          // External well-known package type (e.g. package:protobuf/...)
          check(protoClass).isNotEmpty();
          continue;
        }

        final targetDartFile = File(p.join(eventsLibDir, eventsImport));
        check(
          targetDartFile.existsSync(),
          because:
              'Service [$key] events_import [$eventsImport] must exist on disk.',
        ).isTrue();

        final fileContent = targetDartFile.readAsStringSync();
        final classPattern = RegExp('class\\s+$protoClass\\s+extends\\s+');
        check(
          classPattern.hasMatch(fileContent),
          because:
              'File [$eventsImport] must declare generated class [$protoClass].',
        ).isTrue();
      }
    });

    test('single-trigger services auto-derive baseline action correctly', () {
      final services = doc['services'] as YamlMap;

      for (final entry in services.entries) {
        final svc = entry.value as YamlMap;
        final triggers = (svc['triggers'] as YamlList)
            .map((t) => t.toString())
            .toList();

        if (triggers.length == 1) {
          // Single-trigger services should omit baseline_action in YAML
          check(svc['baseline_action']).isNull();
        } else {
          // Multi-trigger services should explicitly declare their baseline action
          check(svc['baseline_action']).isNotNull();
        }
      }
    });

    test(
      'generate_catalog runs cleanly and generates idempotent outputs',
      () async {
        final targetFiles = [
          File(
            p.join(
              rootDir,
              'packages',
              'google_cloud_events',
              'lib',
              'google_cloud_triggers.dart',
            ),
          ),
          File(
            p.join(
              rootDir,
              'packages',
              'dtt',
              'lib',
              'src',
              'codegen',
              'trigger_config.g.dart',
            ),
          ),
          File(p.join(rootDir, 'packages', 'google_cloud_events', 'README.md')),
        ];

        final beforeContents = {
          for (final f in targetFiles) f.path: f.readAsStringSync(),
        };

        final res = await Process.run('dart', [
          'run',
          'tool/generate_catalog.dart',
        ], workingDirectory: rootDir);
        check(res.exitCode).equals(0);

        for (final f in targetFiles) {
          check(f.readAsStringSync()).equals(beforeContents[f.path]!);
        }
      },
    );
  });
}
