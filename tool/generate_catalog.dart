// Copyright 2026 Google LLC

import 'dart:io';
import 'package:yaml/yaml.dart';

final class ServiceFamily {
  final String enumPrefix;
  final String protoClass;
  final String eventsImport;
  final String dttImport;
  final String basePath;
  final String? baselineAction;
  final bool isGlobal;
  final String? triggerLocation;
  final String? contentType;
  final List<String> triggers;

  const ServiceFamily({
    required this.enumPrefix,
    required this.protoClass,
    required this.eventsImport,
    required this.dttImport,
    required this.basePath,
    this.baselineAction,
    this.isGlobal = false,
    this.triggerLocation,
    this.contentType,
    required this.triggers,
  });

  factory ServiceFamily.fromYaml(String key, YamlMap map) {
    final triggersNode = map['triggers'] as YamlList?;
    if (triggersNode == null || triggersNode.isEmpty) {
      throw FormatException('Service [$key] missing required [triggers] list.');
    }
    final triggers = triggersNode.map((t) => t.toString().trim()).toList();

    final eventsImport =
        map['events_import'] as String? ??
        (throw FormatException('Service [$key] missing [events_import].'));

    final explicitDttImport = map['dtt_import'] as String?;
    final dttImport =
        explicitDttImport ??
        (eventsImport.startsWith('package:')
            ? eventsImport
            : 'package:google_cloud_events/$eventsImport');

    final explicitBaselineAction = map['baseline_action'] as String?;
    final baselineAction =
        explicitBaselineAction ??
        (triggers.length == 1 ? triggers.first.split('.').last : null);

    return ServiceFamily(
      enumPrefix:
          map['enum_prefix'] as String? ??
          (throw FormatException('Service [$key] missing [enum_prefix].')),
      protoClass:
          map['proto_class'] as String? ??
          (throw FormatException('Service [$key] missing [proto_class].')),
      eventsImport: eventsImport,
      dttImport: dttImport,
      basePath:
          map['base_path'] as String? ??
          (throw FormatException('Service [$key] missing [base_path].')),
      baselineAction: baselineAction,
      isGlobal: map['is_global'] as bool? ?? false,
      triggerLocation: map['trigger_location'] as String?,
      contentType: map['content_type'] as String?,
      triggers: triggers,
    );
  }
}

String _capitalize(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

Future<void> main() async {
  final catalogFile = File('catalog/catalog.yaml');
  if (!catalogFile.existsSync()) {
    stderr.writeln('Missing catalog/catalog.yaml');
    exitCode = 1;
    return;
  }

  final doc = loadYaml(catalogFile.readAsStringSync()) as YamlMap;
  final pinnedSha = doc['pinned_sha'] as String?;
  final servicesMap = doc['services'] as YamlMap?;

  if (pinnedSha == null || servicesMap == null) {
    throw const FormatException('Invalid catalog/catalog.yaml');
  }

  final families = <String, ServiceFamily>{};
  final allTriggers = <({String trigger, ServiceFamily family})>[];

  for (final entry in servicesMap.entries) {
    final key = entry.key.toString();
    final value = entry.value as YamlMap;
    final family = ServiceFamily.fromYaml(key, value);
    families[key] = family;

    for (final trigger in family.triggers) {
      if (!trigger.startsWith(key)) {
        throw FormatException(
          'Trigger [$trigger] does not match service prefix [$key].',
        );
      }
      allTriggers.add((trigger: trigger, family: family));
    }
  }

  allTriggers.sort((a, b) => a.trigger.compareTo(b.trigger));

  final eventsEntries = <String>[];
  final dttEntries = <String>[];
  final readmeRows = <String>[];

  for (final (:trigger, :family) in allTriggers) {
    final parts = trigger.split('.');
    final action = parts.last;
    final camelName = family.enumPrefix + _capitalize(action);
    final pathSuffix = action == family.baselineAction
        ? ''
        : '/${action == 'metadataUpdated' ? 'metadata' : action}';
    final routePath = family.basePath + pathSuffix;

    readmeRows.add('| `$trigger` | `${family.protoClass}` | `$routePath` |');

    eventsEntries.add('''
  /// Triggered on event: $trigger
  $camelName<${family.protoClass}>(
    eventType: '$trigger',
    defaultPath: '$routePath',
    create: ${family.protoClass}.create,
  )''');

    final metaArgs = <String>[
      "importPath: '${family.dttImport}'",
      "className: '${family.protoClass}'",
      "enumName: 'CloudEventTrigger.$camelName'",
      "defaultPath: '$routePath'",
      if (family.isGlobal) 'isGlobal: true',
      if (family.triggerLocation != null)
        "triggerLocation: '${family.triggerLocation}'",
      if (family.contentType != null)
        "eventDataContentType: '${family.contentType}'",
    ];

    dttEntries.add('''
  $camelName(
    identifier: '$trigger',
    meta: TriggerTypeMeta._(
${metaArgs.map((a) => '      $a,').join('\n')}
    ),
  )''');
  }

  final uniqueImports =
      families.values
          .map((f) => f.eventsImport)
          .where((i) => !i.startsWith('package:protobuf/'))
          .toSet()
          .toList()
        ..sort();

  final eventsFile = File(
    'packages/google_cloud_events/lib/google_cloud_triggers.dart',
  );
  await eventsFile.writeAsString('''
// Generated by tool/generate_catalog.dart. Do not edit.
import 'package:protobuf/protobuf.dart';
import 'package:protobuf/well_known_types/google/protobuf/struct.pb.dart';

${uniqueImports.map((i) => "import '$i';").join('\n')}

/// Centralized, strongly-typed Enum catalog resolving GCP and Firebase
/// triggers.
/// Conforms to official Eventarc and CloudEvents specifications.
enum CloudEventTrigger<T extends GeneratedMessage> {
${eventsEntries.join(',\n')};

  /// Unique Eventarc GCP/Firebase trigger event type.
  final String eventType;

  /// Default HTTP webhook request endpoint path route.
  final String defaultPath;

  /// Target Protobuf constructor factory template creator.
  final T Function() create;

  const CloudEventTrigger({
    required this.eventType,
    required this.defaultPath,
    required this.create,
  });
}
''');

  final dttFile = File('packages/dtt/lib/src/codegen/trigger_config.g.dart');
  await dttFile.writeAsString('''
// Generated by tool/generate_catalog.dart. Do not edit.
part of 'trigger_config.dart';

/// Supported Eventarc trigger event types and their associated schema metadata.
enum TriggerType {
${dttEntries.join(',\n')};

  const TriggerType({required this.identifier, required this.meta});

  final String identifier;
  final TriggerTypeMeta meta;

  static TriggerType fromIdentifier(String id) {
    for (final val in values) {
      if (val.identifier == id) return val;
    }
    throw UnsupportedError(
      'Target Eventarc trigger type [\$id] is not registered in schemas '
      'catalog.',
    );
  }
}
''');

  final readmeFile = File('packages/google_cloud_events/README.md');
  if (readmeFile.existsSync()) {
    const startMarker = '<!-- CATALOG_TABLE_START -->';
    const endMarker = '<!-- CATALOG_TABLE_END -->';
    final content = readmeFile.readAsStringSync();
    final sIdx = content.indexOf(startMarker);
    final eIdx = content.indexOf(endMarker);
    if (sIdx != -1 && eIdx != -1) {
      final table = [
        '| Eventarc Event Type | Protobuf Payload Class | Default Path |',
        '| :--- | :--- | :--- |',
        ...readmeRows,
      ].join('\n');
      final updated =
          '''
${content.substring(0, sIdx + startMarker.length)}
$table
${content.substring(eIdx)}''';
      readmeFile.writeAsStringSync(updated);
      print('📝 Updated packages/google_cloud_events/README.md catalog table.');
    }
  }

  print('📦 Running dart format...');
  await Process.run('dart', ['format', eventsFile.path, dttFile.path]);
  print('✅ Catalogs generated successfully!');
}
