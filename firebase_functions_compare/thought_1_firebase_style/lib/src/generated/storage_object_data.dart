// Copyright 2026 Google LLC
// Hand-crafted representation model mirroring Firebase Functions SDK standards.

/// Custom hand-coded data model representing Cloud Storage object updates.
/// Leverages native JSON-mapping maps and string-to-DateTime parsing helpers.
class StorageObjectData {
  final String bucket;
  final String name;
  final String generation;
  final String metageneration;
  final String? contentType;
  final String? size;
  final DateTime? timeCreated;
  final DateTime? updated;

  const StorageObjectData({
    required this.bucket,
    required this.name,
    required this.generation,
    required this.metageneration,
    this.contentType,
    this.size,
    this.timeCreated,
    this.updated,
  });

  /// Manual JSON mapping routine
  factory StorageObjectData.fromJson(Map<String, dynamic> json) {
    return StorageObjectData(
      bucket: json['bucket'] as String? ?? '',
      name: json['name'] as String? ?? '',
      generation: json['generation'] as String? ?? '',
      metageneration: json['metageneration'] as String? ?? '',
      contentType: json['contentType'] as String?,
      size: json['size'] as String?,
      timeCreated: json['timeCreated'] != null
          ? DateTime.parse(json['timeCreated'] as String)
          : null,
      updated: json['updated'] != null
          ? DateTime.parse(json['updated'] as String)
          : null,
    );
  }

  /// Converts variables back to Map descriptors
  Map<String, dynamic> toJson() => <String, dynamic>{
        'bucket': bucket,
        'name': name,
        'generation': generation,
        'metageneration': metageneration,
        if (contentType != null) 'contentType': contentType,
        if (size != null) 'size': size,
        if (timeCreated != null) 'timeCreated': timeCreated!.toIso8601String(),
        if (updated != null) 'updated': updated!.toIso8601String(),
      };
}
