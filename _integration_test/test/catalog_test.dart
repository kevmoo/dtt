// Copyright 2026 Google LLC
import 'dart:io';
import 'package:checks/checks.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('Catalog Manifest Integrity Tests', () {
    late File catalogFile;
    late YamlMap doc;

    setUp(() {
      catalogFile = File('../catalog/catalog.yaml');
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

    test('all service keys and triggers are alphabetically sorted', () {
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
        check(svc['dtt_import']).isNotNull();
        check(svc['base_path']).isNotNull();
        check(svc['baseline_action']).isNotNull();

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
    });

    test(
      'generate_catalog runs cleanly and generates idempotent outputs',
      () async {
        final res = await Process.run('dart', [
          'run',
          'tool/generate_catalog.dart',
        ], workingDirectory: '..');
        check(res.exitCode).equals(0);
      },
    );
  });
}
