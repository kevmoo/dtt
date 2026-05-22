// This is a generated file - do not edit.
//
// Generated from google/events/cloud/storage/v1/data.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use storageObjectDataDescriptor instead')
const StorageObjectData$json = {
  '1': 'StorageObjectData',
  '2': [
    {'1': 'content_encoding', '3': 1, '4': 1, '5': 9, '10': 'contentEncoding'},
    {
      '1': 'content_disposition',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'contentDisposition'
    },
    {'1': 'cache_control', '3': 3, '4': 1, '5': 9, '10': 'cacheControl'},
    {'1': 'content_language', '3': 5, '4': 1, '5': 9, '10': 'contentLanguage'},
    {'1': 'metageneration', '3': 6, '4': 1, '5': 3, '10': 'metageneration'},
    {
      '1': 'time_deleted',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'timeDeleted'
    },
    {'1': 'content_type', '3': 8, '4': 1, '5': 9, '10': 'contentType'},
    {'1': 'size', '3': 9, '4': 1, '5': 3, '10': 'size'},
    {
      '1': 'time_created',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'timeCreated'
    },
    {'1': 'crc32c', '3': 11, '4': 1, '5': 9, '10': 'crc32c'},
    {'1': 'component_count', '3': 12, '4': 1, '5': 5, '10': 'componentCount'},
    {'1': 'md5_hash', '3': 13, '4': 1, '5': 9, '10': 'md5Hash'},
    {'1': 'etag', '3': 14, '4': 1, '5': 9, '10': 'etag'},
    {
      '1': 'updated',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updated'
    },
    {'1': 'storage_class', '3': 16, '4': 1, '5': 9, '10': 'storageClass'},
    {'1': 'kms_key_name', '3': 17, '4': 1, '5': 9, '10': 'kmsKeyName'},
    {
      '1': 'time_storage_class_updated',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'timeStorageClassUpdated'
    },
    {'1': 'temporary_hold', '3': 19, '4': 1, '5': 8, '10': 'temporaryHold'},
    {
      '1': 'retention_expiration_time',
      '3': 20,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'retentionExpirationTime'
    },
    {
      '1': 'metadata',
      '3': 21,
      '4': 3,
      '5': 11,
      '6': '.google.events.cloud.storage.v1.StorageObjectData.MetadataEntry',
      '10': 'metadata'
    },
    {'1': 'event_based_hold', '3': 29, '4': 1, '5': 8, '10': 'eventBasedHold'},
    {'1': 'name', '3': 23, '4': 1, '5': 9, '10': 'name'},
    {'1': 'id', '3': 24, '4': 1, '5': 9, '10': 'id'},
    {'1': 'bucket', '3': 25, '4': 1, '5': 9, '10': 'bucket'},
    {'1': 'generation', '3': 26, '4': 1, '5': 3, '10': 'generation'},
    {
      '1': 'customer_encryption',
      '3': 28,
      '4': 1,
      '5': 11,
      '6':
          '.google.events.cloud.storage.v1.StorageObjectData.CustomerEncryption',
      '10': 'customerEncryption'
    },
    {'1': 'media_link', '3': 100, '4': 1, '5': 9, '10': 'mediaLink'},
    {'1': 'self_link', '3': 101, '4': 1, '5': 9, '10': 'selfLink'},
    {'1': 'kind', '3': 102, '4': 1, '5': 9, '10': 'kind'},
  ],
  '3': [
    StorageObjectData_CustomerEncryption$json,
    StorageObjectData_MetadataEntry$json
  ],
};

@$core.Deprecated('Use storageObjectDataDescriptor instead')
const StorageObjectData_CustomerEncryption$json = {
  '1': 'CustomerEncryption',
  '2': [
    {
      '1': 'encryption_algorithm',
      '3': 1,
      '4': 1,
      '5': 9,
      '10': 'encryptionAlgorithm'
    },
    {'1': 'key_sha256', '3': 2, '4': 1, '5': 9, '10': 'keySha256'},
  ],
};

@$core.Deprecated('Use storageObjectDataDescriptor instead')
const StorageObjectData_MetadataEntry$json = {
  '1': 'MetadataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `StorageObjectData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageObjectDataDescriptor = $convert.base64Decode(
    'ChFTdG9yYWdlT2JqZWN0RGF0YRIpChBjb250ZW50X2VuY29kaW5nGAEgASgJUg9jb250ZW50RW'
    '5jb2RpbmcSLwoTY29udGVudF9kaXNwb3NpdGlvbhgCIAEoCVISY29udGVudERpc3Bvc2l0aW9u'
    'EiMKDWNhY2hlX2NvbnRyb2wYAyABKAlSDGNhY2hlQ29udHJvbBIpChBjb250ZW50X2xhbmd1YW'
    'dlGAUgASgJUg9jb250ZW50TGFuZ3VhZ2USJgoObWV0YWdlbmVyYXRpb24YBiABKANSDm1ldGFn'
    'ZW5lcmF0aW9uEj0KDHRpbWVfZGVsZXRlZBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3'
    'RhbXBSC3RpbWVEZWxldGVkEiEKDGNvbnRlbnRfdHlwZRgIIAEoCVILY29udGVudFR5cGUSEgoE'
    'c2l6ZRgJIAEoA1IEc2l6ZRI9Cgx0aW1lX2NyZWF0ZWQYCiABKAsyGi5nb29nbGUucHJvdG9idW'
    'YuVGltZXN0YW1wUgt0aW1lQ3JlYXRlZBIWCgZjcmMzMmMYCyABKAlSBmNyYzMyYxInCg9jb21w'
    'b25lbnRfY291bnQYDCABKAVSDmNvbXBvbmVudENvdW50EhkKCG1kNV9oYXNoGA0gASgJUgdtZD'
    'VIYXNoEhIKBGV0YWcYDiABKAlSBGV0YWcSNAoHdXBkYXRlZBgPIAEoCzIaLmdvb2dsZS5wcm90'
    'b2J1Zi5UaW1lc3RhbXBSB3VwZGF0ZWQSIwoNc3RvcmFnZV9jbGFzcxgQIAEoCVIMc3RvcmFnZU'
    'NsYXNzEiAKDGttc19rZXlfbmFtZRgRIAEoCVIKa21zS2V5TmFtZRJXChp0aW1lX3N0b3JhZ2Vf'
    'Y2xhc3NfdXBkYXRlZBgSIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSF3RpbWVTdG'
    '9yYWdlQ2xhc3NVcGRhdGVkEiUKDnRlbXBvcmFyeV9ob2xkGBMgASgIUg10ZW1wb3JhcnlIb2xk'
    'ElYKGXJldGVudGlvbl9leHBpcmF0aW9uX3RpbWUYFCABKAsyGi5nb29nbGUucHJvdG9idWYuVG'
    'ltZXN0YW1wUhdyZXRlbnRpb25FeHBpcmF0aW9uVGltZRJbCghtZXRhZGF0YRgVIAMoCzI/Lmdv'
    'b2dsZS5ldmVudHMuY2xvdWQuc3RvcmFnZS52MS5TdG9yYWdlT2JqZWN0RGF0YS5NZXRhZGF0YU'
    'VudHJ5UghtZXRhZGF0YRIoChBldmVudF9iYXNlZF9ob2xkGB0gASgIUg5ldmVudEJhc2VkSG9s'
    'ZBISCgRuYW1lGBcgASgJUgRuYW1lEg4KAmlkGBggASgJUgJpZBIWCgZidWNrZXQYGSABKAlSBm'
    'J1Y2tldBIeCgpnZW5lcmF0aW9uGBogASgDUgpnZW5lcmF0aW9uEnUKE2N1c3RvbWVyX2VuY3J5'
    'cHRpb24YHCABKAsyRC5nb29nbGUuZXZlbnRzLmNsb3VkLnN0b3JhZ2UudjEuU3RvcmFnZU9iam'
    'VjdERhdGEuQ3VzdG9tZXJFbmNyeXB0aW9uUhJjdXN0b21lckVuY3J5cHRpb24SHQoKbWVkaWFf'
    'bGluaxhkIAEoCVIJbWVkaWFMaW5rEhsKCXNlbGZfbGluaxhlIAEoCVIIc2VsZkxpbmsSEgoEa2'
    'luZBhmIAEoCVIEa2luZBpmChJDdXN0b21lckVuY3J5cHRpb24SMQoUZW5jcnlwdGlvbl9hbGdv'
    'cml0aG0YASABKAlSE2VuY3J5cHRpb25BbGdvcml0aG0SHQoKa2V5X3NoYTI1NhgCIAEoCVIJa2'
    'V5U2hhMjU2GjsKDU1ldGFkYXRhRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiAB'
    'KAlSBXZhbHVlOgI4AQ==');
