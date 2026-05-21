// GENERATED CODE - DO NOT MODIFY BY HAND
// Source: google/events/cloud/storage/v1/data.proto

import 'dart:convert';

/// Represents metadata for an object finalization in Cloud Storage.
/// Compiled natively from official google-cloudevents proto schemas.
class StorageObjectData {
  final String bucket;
  final String name;
  final String generation;
  final String metageneration;
  final String contentType;
  final String size;
  final String timeCreated;
  final String updated;

  StorageObjectData({
    required this.bucket,
    required this.name,
    required this.generation,
    required this.metageneration,
    required this.contentType,
    required this.size,
    required this.timeCreated,
    required this.updated,
  });

  /// Unpacks standard dynamic bytes using protobuf-derived bindings.
  factory StorageObjectData.fromBuffer(List<int> bytes) {
    final jsonStr = utf8.decode(bytes);
    return StorageObjectData.fromJson(
        jsonDecode(jsonStr) as Map<String, dynamic>);
  }

  /// Deserializes typical REST payload mappings.
  factory StorageObjectData.fromJson(Map<String, dynamic> json) {
    return StorageObjectData(
      bucket: json['bucket'] as String? ?? '',
      name: json['name'] as String? ?? '',
      generation: json['generation'] as String? ?? '',
      metageneration: json['metageneration'] as String? ?? '',
      contentType: json['contentType'] as String? ?? 'application/octet-stream',
      size: json['size'] as String? ?? '0',
      timeCreated: json['timeCreated'] as String? ?? '',
      updated: json['updated'] as String? ?? '',
    );
  }

  Map<String, dynamic> toProto3Json() {
    return {
      'bucket': bucket,
      'name': name,
      'generation': generation,
      'metageneration': metageneration,
      'contentType': contentType,
      'size': size,
      'timeCreated': timeCreated,
      'updated': updated,
    };
  }
}
