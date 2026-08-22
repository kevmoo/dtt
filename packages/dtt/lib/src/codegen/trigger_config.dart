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

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

part 'trigger_config.g.dart';

/// Mapping metadata tracking trigger types, import URIs, and class definitions.
final class TriggerTypeMeta {
  final String importPath;
  final String className;
  final String enumName;
  final String defaultPath;
  final bool isGlobal;
  final String? triggerLocation;
  final String? eventDataContentType;

  const TriggerTypeMeta._({
    required this.importPath,
    required this.className,
    required this.enumName,
    required this.defaultPath,
    this.isGlobal = false,
    this.triggerLocation,
    this.eventDataContentType,
  });
}

/// Strongly typed representation of a declared Eventarc trigger in dtt.yaml.
base class TriggerConfig {
  const TriggerConfig._({
    required this.name,
    required this.type,
    required this.path,
    required this.handler,
    this.resourceRef,
    this.deadLetterTopic,
    this.retryPolicy,
  });

  final String name;
  final TriggerType type;
  final String path;
  final String handler;
  final String? resourceRef;
  final String? deadLetterTopic;
  final String? retryPolicy;

  TriggerTypeMeta get meta => type.meta;

  factory TriggerConfig.fromYaml(YamlMap node) {
    final paramsNode = node['parameters'] as YamlMap?;
    final name = node['name'] as String? ?? 'trigger';
    final typeStr =
        (node['type'] as String?) ?? (paramsNode?['type'] as String?);
    final path =
        (node['path'] as String?) ??
        (paramsNode?['path'] as String?) ??
        '/events';
    final handler =
        (node['handler'] as String?) ??
        (paramsNode?['handler'] as String?) ??
        'onEvent';
    final resourceRef =
        (node['resource_ref'] as String?) ??
        (paramsNode?['resource_ref'] as String?);
    final deadLetterTopic =
        (node['dead_letter_topic'] as String?) ??
        (paramsNode?['dead_letter_topic'] as String?);
    final retryPolicy =
        (node['retry_policy'] as String?) ??
        (paramsNode?['retry_policy'] as String?);

    if (typeStr == null) {
      throw const FormatException(
        'Trigger declaration missing required [type] attribute.',
      );
    }

    final type = TriggerType.fromIdentifier(typeStr);
    final bucket =
        (node['bucket'] as String?) ?? (paramsNode?['bucket'] as String?);
    final document =
        (node['document'] as String?) ?? (paramsNode?['document'] as String?);
    final database =
        (node['database'] as String?) ??
        (paramsNode?['database'] as String?) ??
        '(default)';

    return switch (type) {
      TriggerType.gcsObjectFinalized ||
      TriggerType.gcsObjectDeleted ||
      TriggerType.gcsObjectArchived ||
      TriggerType.gcsObjectMetadataUpdated => StorageTriggerConfig._(
        name: name,
        type: type,
        path: path,
        handler: handler,
        resourceRef: resourceRef,
        deadLetterTopic: deadLetterTopic,
        retryPolicy: retryPolicy,
        bucket:
            bucket ??
            (throw FormatException(
              'Cloud Storage trigger [$name] missing required [bucket] '
              'declaration.',
            )),
      ),
      TriggerType.firestoreDocumentWritten ||
      TriggerType.firestoreDocumentCreated ||
      TriggerType.firestoreDocumentUpdated ||
      TriggerType.firestoreDocumentDeleted => FirestoreTriggerConfig._(
        name: name,
        type: type,
        path: path,
        handler: handler,
        resourceRef: resourceRef,
        deadLetterTopic: deadLetterTopic,
        retryPolicy: retryPolicy,
        document:
            document ??
            (throw FormatException(
              'Firestore trigger [$name] missing required [document] '
              'declaration.',
            )),
        database: database,
      ),
      _ => TriggerConfig._(
        name: name,
        type: type,
        path: path,
        handler: handler,
        resourceRef: resourceRef,
        deadLetterTopic: deadLetterTopic,
        retryPolicy: retryPolicy,
      ),
    };
  }
}

final class StorageTriggerConfig extends TriggerConfig {
  const StorageTriggerConfig._({
    required super.name,
    required super.type,
    required super.path,
    required super.handler,
    super.resourceRef,
    super.deadLetterTopic,
    super.retryPolicy,
    required this.bucket,
  }) : super._();

  final String bucket;
}

final class FirestoreTriggerConfig extends TriggerConfig {
  const FirestoreTriggerConfig._({
    required super.name,
    required super.type,
    required super.path,
    required super.handler,
    super.resourceRef,
    super.deadLetterTopic,
    super.retryPolicy,
    required this.document,
    this.database = '(default)',
  }) : super._();

  final String document;
  final String database;
}

class DttConfig {
  final String serviceName;
  final String projectId;
  final String region;
  final YamlMap doc;

  DttConfig({
    required this.serviceName,
    required this.projectId,
    required this.region,
    required this.doc,
  });

  static Future<DttConfig> load(String packageDir) async {
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

    return DttConfig(
      serviceName: serviceName,
      projectId: projectId,
      region: region,
      doc: doc,
    );
  }
}
