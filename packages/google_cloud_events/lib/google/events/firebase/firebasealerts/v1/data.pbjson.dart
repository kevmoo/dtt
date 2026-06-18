// This is a generated file - do not edit.
//
// Generated from google/events/firebase/firebasealerts/v1/data.proto.

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

@$core.Deprecated('Use alertDataDescriptor instead')
const AlertData$json = {
  '1': 'AlertData',
  '2': [
    {
      '1': 'create_time',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createTime'
    },
    {
      '1': 'end_time',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'endTime'
    },
    {
      '1': 'payload',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'payload'
    },
  ],
};

/// Descriptor for `AlertData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List alertDataDescriptor = $convert.base64Decode(
    'CglBbGVydERhdGESOwoLY3JlYXRlX3RpbWUYASABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZX'
    'N0YW1wUgpjcmVhdGVUaW1lEjUKCGVuZF90aW1lGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRp'
    'bWVzdGFtcFIHZW5kVGltZRIxCgdwYXlsb2FkGAMgASgLMhcuZ29vZ2xlLnByb3RvYnVmLlN0cn'
    'VjdFIHcGF5bG9hZA==');
