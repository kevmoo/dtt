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

import 'package:yaml/yaml.dart';

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

/// Supported Eventarc trigger event types and their associated schema metadata.
enum TriggerType {
  gcsObjectFinalized(
    identifier: 'google.cloud.storage.object.v1.finalized',
    meta: TriggerTypeMeta._(
      importPath:
          'package:google_cloud_events/google/events/'
          'cloud/storage/v1/data.pb.dart',
      className: 'StorageObjectData',
      enumName: 'CloudEventTrigger.gcsObjectFinalized',
      defaultPath: '/events/uploads',
    ),
  ),
  gcsObjectDeleted(
    identifier: 'google.cloud.storage.object.v1.deleted',
    meta: TriggerTypeMeta._(
      importPath:
          'package:google_cloud_events/google/events/'
          'cloud/storage/v1/data.pb.dart',
      className: 'StorageObjectData',
      enumName: 'CloudEventTrigger.gcsObjectDeleted',
      defaultPath: '/events/uploads/deleted',
    ),
  ),
  gcsObjectArchived(
    identifier: 'google.cloud.storage.object.v1.archived',
    meta: TriggerTypeMeta._(
      importPath:
          'package:google_cloud_events/google/events/'
          'cloud/storage/v1/data.pb.dart',
      className: 'StorageObjectData',
      enumName: 'CloudEventTrigger.gcsObjectArchived',
      defaultPath: '/events/uploads/archived',
    ),
  ),
  gcsObjectMetadataUpdated(
    identifier: 'google.cloud.storage.object.v1.metadataUpdated',
    meta: TriggerTypeMeta._(
      importPath:
          'package:google_cloud_events/google/events/'
          'cloud/storage/v1/data.pb.dart',
      className: 'StorageObjectData',
      enumName: 'CloudEventTrigger.gcsObjectMetadataUpdated',
      defaultPath: '/events/uploads/metadata',
    ),
  ),
  firebaseAuthUserCreated(
    identifier: 'google.firebase.auth.user.v2.created',
    meta: TriggerTypeMeta._(
      importPath:
          'package:google_cloud_events/google/events/'
          'firebase/auth/v1/data.pb.dart',
      className: 'AuthEventData',
      enumName: 'CloudEventTrigger.firebaseAuthUserCreated',
      defaultPath: '/events/auth',
      isGlobal: true,
      triggerLocation: 'global',
    ),
  ),
  firebaseAuthUserDeleted(
    identifier: 'google.firebase.auth.user.v2.deleted',
    meta: TriggerTypeMeta._(
      importPath:
          'package:google_cloud_events/google/events/'
          'firebase/auth/v1/data.pb.dart',
      className: 'AuthEventData',
      enumName: 'CloudEventTrigger.firebaseAuthUserDeleted',
      defaultPath: '/events/auth/deleted',
      isGlobal: true,
      triggerLocation: 'global',
    ),
  ),
  firestoreDocumentWritten(
    identifier: 'google.cloud.firestore.document.v1.written',
    meta: TriggerTypeMeta._(
      importPath:
          'package:protobuf/well_known_types/google/protobuf/'
          'struct.pb.dart',
      className: 'Struct',
      enumName: 'CloudEventTrigger.firestoreDocumentWritten',
      defaultPath: '/events/firestore',
      triggerLocation: 'nam5',
      eventDataContentType: 'application/protobuf',
    ),
  ),
  firestoreDocumentCreated(
    identifier: 'google.cloud.firestore.document.v1.created',
    meta: TriggerTypeMeta._(
      importPath:
          'package:protobuf/well_known_types/google/protobuf/'
          'struct.pb.dart',
      className: 'Struct',
      enumName: 'CloudEventTrigger.firestoreDocumentCreated',
      defaultPath: '/events/firestore/created',
      triggerLocation: 'nam5',
      eventDataContentType: 'application/protobuf',
    ),
  ),
  firestoreDocumentUpdated(
    identifier: 'google.cloud.firestore.document.v1.updated',
    meta: TriggerTypeMeta._(
      importPath:
          'package:protobuf/well_known_types/google/protobuf/'
          'struct.pb.dart',
      className: 'Struct',
      enumName: 'CloudEventTrigger.firestoreDocumentUpdated',
      defaultPath: '/events/firestore/updated',
      triggerLocation: 'nam5',
      eventDataContentType: 'application/protobuf',
    ),
  ),
  firestoreDocumentDeleted(
    identifier: 'google.cloud.firestore.document.v1.deleted',
    meta: TriggerTypeMeta._(
      importPath:
          'package:protobuf/well_known_types/google/protobuf/'
          'struct.pb.dart',
      className: 'Struct',
      enumName: 'CloudEventTrigger.firestoreDocumentDeleted',
      defaultPath: '/events/firestore/deleted',
      triggerLocation: 'nam5',
      eventDataContentType: 'application/protobuf',
    ),
  );

  const TriggerType({required this.identifier, required this.meta});

  final String identifier;
  final TriggerTypeMeta meta;

  static TriggerType fromIdentifier(String id) {
    for (final val in values) {
      if (val.identifier == id) return val;
    }
    throw UnsupportedError(
      'Target Eventarc trigger type [$id] is not registered in schemas '
      'catalog.',
    );
  }
}

/// Strongly typed representation of a declared Eventarc trigger in dtt.yaml.
base class TriggerConfig {
  const TriggerConfig._({
    required this.name,
    required this.type,
    required this.path,
    required this.handler,
  });

  final String name;
  final TriggerType type;
  final String path;
  final String handler;

  TriggerTypeMeta get meta => type.meta;

  factory TriggerConfig.fromYaml(YamlMap node) {
    if (node case {
      'name': final String name,
      'type': final String typeStr,
      'path': final String path,
      'handler': final String handler,
    }) {
      final type = TriggerType.fromIdentifier(typeStr);
      return switch (type) {
        TriggerType.gcsObjectFinalized ||
        TriggerType.gcsObjectDeleted ||
        TriggerType.gcsObjectArchived ||
        TriggerType.gcsObjectMetadataUpdated => StorageTriggerConfig._(
          name: name,
          type: type,
          path: path,
          handler: handler,
          bucket:
              node['bucket'] as String? ??
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
          document:
              node['document'] as String? ??
              (throw FormatException(
                'Firestore trigger [$name] missing required [document] '
                'declaration.',
              )),
          database: node['database'] as String? ?? '(default)',
        ),
        TriggerType.firebaseAuthUserCreated ||
        TriggerType.firebaseAuthUserDeleted => TriggerConfig._(
          name: name,
          type: type,
          path: path,
          handler: handler,
        ),
      };
    }
    throw const FormatException(
      'Trigger mappings must specify name, type, path, and handler '
      'callbacks.',
    );
  }
}

final class StorageTriggerConfig extends TriggerConfig {
  const StorageTriggerConfig._({
    required super.name,
    required super.type,
    required super.path,
    required super.handler,
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
    required this.document,
    this.database = '(default)',
  }) : super._();

  final String document;
  final String database;
}
