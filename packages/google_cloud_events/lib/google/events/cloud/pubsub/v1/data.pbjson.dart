// This is a generated file - do not edit.
//
// Generated from google/events/cloud/pubsub/v1/data.proto.

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

@$core.Deprecated('Use messagePublishedDataDescriptor instead')
const MessagePublishedData$json = {
  '1': 'MessagePublishedData',
  '2': [
    {
      '1': 'message',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.pubsub.v1.PubsubMessage',
      '10': 'message'
    },
    {'1': 'subscription', '3': 2, '4': 1, '5': 9, '10': 'subscription'},
    {'1': 'delivery_attempt', '3': 3, '4': 1, '5': 5, '10': 'deliveryAttempt'},
  ],
};

/// Descriptor for `MessagePublishedData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messagePublishedDataDescriptor = $convert.base64Decode(
    'ChRNZXNzYWdlUHVibGlzaGVkRGF0YRJGCgdtZXNzYWdlGAEgASgLMiwuZ29vZ2xlLmV2ZW50cy'
    '5jbG91ZC5wdWJzdWIudjEuUHVic3ViTWVzc2FnZVIHbWVzc2FnZRIiCgxzdWJzY3JpcHRpb24Y'
    'AiABKAlSDHN1YnNjcmlwdGlvbhIpChBkZWxpdmVyeV9hdHRlbXB0GAMgASgFUg9kZWxpdmVyeU'
    'F0dGVtcHQ=');

@$core.Deprecated('Use pubsubMessageDescriptor instead')
const PubsubMessage$json = {
  '1': 'PubsubMessage',
  '2': [
    {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
    {
      '1': 'attributes',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.events.cloud.pubsub.v1.PubsubMessage.AttributesEntry',
      '10': 'attributes'
    },
    {'1': 'message_id', '3': 3, '4': 1, '5': 9, '10': 'messageId'},
    {
      '1': 'publish_time',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'publishTime'
    },
    {'1': 'ordering_key', '3': 5, '4': 1, '5': 9, '10': 'orderingKey'},
  ],
  '3': [PubsubMessage_AttributesEntry$json],
};

@$core.Deprecated('Use pubsubMessageDescriptor instead')
const PubsubMessage_AttributesEntry$json = {
  '1': 'AttributesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `PubsubMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pubsubMessageDescriptor = $convert.base64Decode(
    'Cg1QdWJzdWJNZXNzYWdlEhIKBGRhdGEYASABKAxSBGRhdGESXAoKYXR0cmlidXRlcxgCIAMoCz'
    'I8Lmdvb2dsZS5ldmVudHMuY2xvdWQucHVic3ViLnYxLlB1YnN1Yk1lc3NhZ2UuQXR0cmlidXRl'
    'c0VudHJ5UgphdHRyaWJ1dGVzEh0KCm1lc3NhZ2VfaWQYAyABKAlSCW1lc3NhZ2VJZBI9CgxwdW'
    'JsaXNoX3RpbWUYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtwdWJsaXNoVGlt'
    'ZRIhCgxvcmRlcmluZ19rZXkYBSABKAlSC29yZGVyaW5nS2V5Gj0KD0F0dHJpYnV0ZXNFbnRyeR'
    'IQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgB');
