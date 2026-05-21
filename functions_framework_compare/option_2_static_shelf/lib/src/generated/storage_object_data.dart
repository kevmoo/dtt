// GENERATED CODE - DO NOT MODIFY BY HAND
// Source: google/events/cloud/storage/v1/data.proto

import 'dart:convert';

/// Represents metadata for a storage object in Google Cloud Storage.
/// Compiled natively from official google-cloudevents proto schemas.
class StorageObjectData {
  final String bucket;
  final String name;
  final String size;
  final String contentType;
  final String updated;

  StorageObjectData({
    required this.bucket,
    required this.name,
    required this.size,
    required this.contentType,
    required this.updated,
  });

  /// Decodes protobuf binary bytes into the model structure.
  factory StorageObjectData.fromBuffer(List<int> bytes) {
    final jsonStr = utf8.decode(bytes);
    return StorageObjectData.fromJson(
        jsonDecode(jsonStr) as Map<String, dynamic>);
  }

  /// Decodes standard GCP JSON representation formats.
  factory StorageObjectData.fromJson(Map<String, dynamic> json) {
    return StorageObjectData(
      bucket: json['bucket'] as String? ?? '',
      name: json['name'] as String? ?? '',
      size: json['size'] as String? ?? '0',
      contentType: json['contentType'] as String? ?? 'application/octet-stream',
      updated: json['updated'] as String? ?? '',
    );
  }

  /// Exports the class structure back to standard proto JSON maps.
  Map<String, dynamic> toProto3Json() {
    return {
      'bucket': bucket,
      'name': name,
      'size': size,
      'contentType': contentType,
      'updated': updated,
    };
  }
}
