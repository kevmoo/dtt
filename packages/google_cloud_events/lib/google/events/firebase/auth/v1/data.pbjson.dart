// This is a generated file - do not edit.
//
// Generated from google/events/firebase/auth/v1/data.proto.

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

@$core.Deprecated('Use authEventDataDescriptor instead')
const AuthEventData$json = {
  '1': 'AuthEventData',
  '2': [
    {'1': 'uid', '3': 1, '4': 1, '5': 9, '10': 'uid'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'email_verified', '3': 3, '4': 1, '5': 8, '10': 'emailVerified'},
    {'1': 'display_name', '3': 4, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'photo_URL', '3': 5, '4': 1, '5': 9, '10': 'photoURL'},
    {'1': 'disabled', '3': 6, '4': 1, '5': 8, '10': 'disabled'},
    {
      '1': 'metadata',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.events.firebase.auth.v1.UserMetadata',
      '10': 'metadata'
    },
    {
      '1': 'provider_data',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.google.events.firebase.auth.v1.UserInfo',
      '10': 'providerData'
    },
    {'1': 'phone_number', '3': 9, '4': 1, '5': 9, '10': 'phoneNumber'},
    {
      '1': 'custom_claims',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'customClaims'
    },
  ],
};

/// Descriptor for `AuthEventData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authEventDataDescriptor = $convert.base64Decode(
    'Cg1BdXRoRXZlbnREYXRhEhAKA3VpZBgBIAEoCVIDdWlkEhQKBWVtYWlsGAIgASgJUgVlbWFpbB'
    'IlCg5lbWFpbF92ZXJpZmllZBgDIAEoCFINZW1haWxWZXJpZmllZBIhCgxkaXNwbGF5X25hbWUY'
    'BCABKAlSC2Rpc3BsYXlOYW1lEhsKCXBob3RvX1VSTBgFIAEoCVIIcGhvdG9VUkwSGgoIZGlzYW'
    'JsZWQYBiABKAhSCGRpc2FibGVkEkgKCG1ldGFkYXRhGAcgASgLMiwuZ29vZ2xlLmV2ZW50cy5m'
    'aXJlYmFzZS5hdXRoLnYxLlVzZXJNZXRhZGF0YVIIbWV0YWRhdGESTQoNcHJvdmlkZXJfZGF0YR'
    'gIIAMoCzIoLmdvb2dsZS5ldmVudHMuZmlyZWJhc2UuYXV0aC52MS5Vc2VySW5mb1IMcHJvdmlk'
    'ZXJEYXRhEiEKDHBob25lX251bWJlchgJIAEoCVILcGhvbmVOdW1iZXISPAoNY3VzdG9tX2NsYW'
    'ltcxgKIAEoCzIXLmdvb2dsZS5wcm90b2J1Zi5TdHJ1Y3RSDGN1c3RvbUNsYWltcw==');

@$core.Deprecated('Use userMetadataDescriptor instead')
const UserMetadata$json = {
  '1': 'UserMetadata',
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
      '1': 'last_sign_in_time',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastSignInTime'
    },
  ],
};

/// Descriptor for `UserMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userMetadataDescriptor = $convert.base64Decode(
    'CgxVc2VyTWV0YWRhdGESOwoLY3JlYXRlX3RpbWUYASABKAsyGi5nb29nbGUucHJvdG9idWYuVG'
    'ltZXN0YW1wUgpjcmVhdGVUaW1lEkUKEWxhc3Rfc2lnbl9pbl90aW1lGAIgASgLMhouZ29vZ2xl'
    'LnByb3RvYnVmLlRpbWVzdGFtcFIObGFzdFNpZ25JblRpbWU=');

@$core.Deprecated('Use userInfoDescriptor instead')
const UserInfo$json = {
  '1': 'UserInfo',
  '2': [
    {'1': 'uid', '3': 1, '4': 1, '5': 9, '10': 'uid'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'photo_URL', '3': 4, '4': 1, '5': 9, '10': 'photoURL'},
    {'1': 'provider_id', '3': 5, '4': 1, '5': 9, '10': 'providerId'},
  ],
};

/// Descriptor for `UserInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userInfoDescriptor = $convert.base64Decode(
    'CghVc2VySW5mbxIQCgN1aWQYASABKAlSA3VpZBIUCgVlbWFpbBgCIAEoCVIFZW1haWwSIQoMZG'
    'lzcGxheV9uYW1lGAMgASgJUgtkaXNwbGF5TmFtZRIbCglwaG90b19VUkwYBCABKAlSCHBob3Rv'
    'VVJMEh8KC3Byb3ZpZGVyX2lkGAUgASgJUgpwcm92aWRlcklk');
