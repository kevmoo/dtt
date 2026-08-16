// This is a generated file - do not edit.
//
// Generated from google/events/cloud/audit/v1/data.proto.

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

@$core.Deprecated('Use logSeverityDescriptor instead')
const LogSeverity$json = {
  '1': 'LogSeverity',
  '2': [
    {'1': 'DEFAULT', '2': 0},
    {'1': 'DEBUG', '2': 100},
    {'1': 'INFO', '2': 200},
    {'1': 'NOTICE', '2': 300},
    {'1': 'WARNING', '2': 400},
    {'1': 'ERROR', '2': 500},
    {'1': 'CRITICAL', '2': 600},
    {'1': 'ALERT', '2': 700},
    {'1': 'EMERGENCY', '2': 800},
  ],
};

/// Descriptor for `LogSeverity`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List logSeverityDescriptor = $convert.base64Decode(
    'CgtMb2dTZXZlcml0eRILCgdERUZBVUxUEAASCQoFREVCVUcQZBIJCgRJTkZPEMgBEgsKBk5PVE'
    'lDRRCsAhIMCgdXQVJOSU5HEJADEgoKBUVSUk9SEPQDEg0KCENSSVRJQ0FMENgEEgoKBUFMRVJU'
    'ELwFEg4KCUVNRVJHRU5DWRCgBg==');

@$core.Deprecated('Use logEntryDataDescriptor instead')
const LogEntryData$json = {
  '1': 'LogEntryData',
  '2': [
    {'1': 'log_name', '3': 12, '4': 1, '5': 9, '10': 'logName'},
    {
      '1': 'resource',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.api.MonitoredResource',
      '10': 'resource'
    },
    {
      '1': 'proto_payload',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.audit.v1.AuditLog',
      '10': 'protoPayload'
    },
    {'1': 'insert_id', '3': 4, '4': 1, '5': 9, '10': 'insertId'},
    {
      '1': 'labels',
      '3': 11,
      '4': 3,
      '5': 11,
      '6': '.google.events.cloud.audit.v1.LogEntryData.LabelsEntry',
      '10': 'labels'
    },
    {
      '1': 'operation',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.audit.v1.LogEntryOperation',
      '10': 'operation'
    },
    {
      '1': 'timestamp',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'timestamp'
    },
    {
      '1': 'receive_timestamp',
      '3': 24,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'receiveTimestamp'
    },
    {
      '1': 'severity',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.google.events.cloud.audit.v1.LogSeverity',
      '10': 'severity'
    },
    {'1': 'trace', '3': 22, '4': 1, '5': 9, '10': 'trace'},
    {'1': 'span_id', '3': 27, '4': 1, '5': 9, '10': 'spanId'},
    {
      '1': 'split',
      '3': 35,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.audit.v1.LogSplit',
      '10': 'split'
    },
  ],
  '3': [LogEntryData_LabelsEntry$json],
};

@$core.Deprecated('Use logEntryDataDescriptor instead')
const LogEntryData_LabelsEntry$json = {
  '1': 'LabelsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `LogEntryData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logEntryDataDescriptor = $convert.base64Decode(
    'CgxMb2dFbnRyeURhdGESGQoIbG9nX25hbWUYDCABKAlSB2xvZ05hbWUSOQoIcmVzb3VyY2UYCC'
    'ABKAsyHS5nb29nbGUuYXBpLk1vbml0b3JlZFJlc291cmNlUghyZXNvdXJjZRJLCg1wcm90b19w'
    'YXlsb2FkGAIgASgLMiYuZ29vZ2xlLmV2ZW50cy5jbG91ZC5hdWRpdC52MS5BdWRpdExvZ1IMcH'
    'JvdG9QYXlsb2FkEhsKCWluc2VydF9pZBgEIAEoCVIIaW5zZXJ0SWQSTgoGbGFiZWxzGAsgAygL'
    'MjYuZ29vZ2xlLmV2ZW50cy5jbG91ZC5hdWRpdC52MS5Mb2dFbnRyeURhdGEuTGFiZWxzRW50cn'
    'lSBmxhYmVscxJNCglvcGVyYXRpb24YDyABKAsyLy5nb29nbGUuZXZlbnRzLmNsb3VkLmF1ZGl0'
    'LnYxLkxvZ0VudHJ5T3BlcmF0aW9uUglvcGVyYXRpb24SOAoJdGltZXN0YW1wGAkgASgLMhouZ2'
    '9vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdGltZXN0YW1wEkcKEXJlY2VpdmVfdGltZXN0YW1w'
    'GBggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIQcmVjZWl2ZVRpbWVzdGFtcBJFCg'
    'hzZXZlcml0eRgKIAEoDjIpLmdvb2dsZS5ldmVudHMuY2xvdWQuYXVkaXQudjEuTG9nU2V2ZXJp'
    'dHlSCHNldmVyaXR5EhQKBXRyYWNlGBYgASgJUgV0cmFjZRIXCgdzcGFuX2lkGBsgASgJUgZzcG'
    'FuSWQSPAoFc3BsaXQYIyABKAsyJi5nb29nbGUuZXZlbnRzLmNsb3VkLmF1ZGl0LnYxLkxvZ1Nw'
    'bGl0UgVzcGxpdBo5CgtMYWJlbHNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIA'
    'EoCVIFdmFsdWU6AjgB');

@$core.Deprecated('Use logEntryOperationDescriptor instead')
const LogEntryOperation$json = {
  '1': 'LogEntryOperation',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'producer', '3': 2, '4': 1, '5': 9, '10': 'producer'},
    {'1': 'first', '3': 3, '4': 1, '5': 8, '10': 'first'},
    {'1': 'last', '3': 4, '4': 1, '5': 8, '10': 'last'},
  ],
};

/// Descriptor for `LogEntryOperation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logEntryOperationDescriptor = $convert.base64Decode(
    'ChFMb2dFbnRyeU9wZXJhdGlvbhIOCgJpZBgBIAEoCVICaWQSGgoIcHJvZHVjZXIYAiABKAlSCH'
    'Byb2R1Y2VyEhQKBWZpcnN0GAMgASgIUgVmaXJzdBISCgRsYXN0GAQgASgIUgRsYXN0');

@$core.Deprecated('Use auditLogDescriptor instead')
const AuditLog$json = {
  '1': 'AuditLog',
  '2': [
    {'1': 'service_name', '3': 7, '4': 1, '5': 9, '10': 'serviceName'},
    {'1': 'method_name', '3': 8, '4': 1, '5': 9, '10': 'methodName'},
    {'1': 'resource_name', '3': 11, '4': 1, '5': 9, '10': 'resourceName'},
    {
      '1': 'resource_location',
      '3': 20,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.audit.v1.ResourceLocation',
      '10': 'resourceLocation'
    },
    {
      '1': 'resource_original_state',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'resourceOriginalState'
    },
    {
      '1': 'num_response_items',
      '3': 12,
      '4': 1,
      '5': 3,
      '10': 'numResponseItems'
    },
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.rpc.Status',
      '10': 'status'
    },
    {
      '1': 'authentication_info',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.audit.v1.AuthenticationInfo',
      '10': 'authenticationInfo'
    },
    {
      '1': 'authorization_info',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.google.events.cloud.audit.v1.AuthorizationInfo',
      '10': 'authorizationInfo'
    },
    {
      '1': 'request_metadata',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.audit.v1.RequestMetadata',
      '10': 'requestMetadata'
    },
    {
      '1': 'request',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'response'
    },
    {
      '1': 'metadata',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'metadata'
    },
    {
      '1': 'service_data',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'serviceData'
    },
  ],
};

/// Descriptor for `AuditLog`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List auditLogDescriptor = $convert.base64Decode(
    'CghBdWRpdExvZxIhCgxzZXJ2aWNlX25hbWUYByABKAlSC3NlcnZpY2VOYW1lEh8KC21ldGhvZF'
    '9uYW1lGAggASgJUgptZXRob2ROYW1lEiMKDXJlc291cmNlX25hbWUYCyABKAlSDHJlc291cmNl'
    'TmFtZRJbChFyZXNvdXJjZV9sb2NhdGlvbhgUIAEoCzIuLmdvb2dsZS5ldmVudHMuY2xvdWQuYX'
    'VkaXQudjEuUmVzb3VyY2VMb2NhdGlvblIQcmVzb3VyY2VMb2NhdGlvbhJPChdyZXNvdXJjZV9v'
    'cmlnaW5hbF9zdGF0ZRgTIAEoCzIXLmdvb2dsZS5wcm90b2J1Zi5TdHJ1Y3RSFXJlc291cmNlT3'
    'JpZ2luYWxTdGF0ZRIsChJudW1fcmVzcG9uc2VfaXRlbXMYDCABKANSEG51bVJlc3BvbnNlSXRl'
    'bXMSKgoGc3RhdHVzGAIgASgLMhIuZ29vZ2xlLnJwYy5TdGF0dXNSBnN0YXR1cxJhChNhdXRoZW'
    '50aWNhdGlvbl9pbmZvGAMgASgLMjAuZ29vZ2xlLmV2ZW50cy5jbG91ZC5hdWRpdC52MS5BdXRo'
    'ZW50aWNhdGlvbkluZm9SEmF1dGhlbnRpY2F0aW9uSW5mbxJeChJhdXRob3JpemF0aW9uX2luZm'
    '8YCSADKAsyLy5nb29nbGUuZXZlbnRzLmNsb3VkLmF1ZGl0LnYxLkF1dGhvcml6YXRpb25JbmZv'
    'UhFhdXRob3JpemF0aW9uSW5mbxJYChByZXF1ZXN0X21ldGFkYXRhGAQgASgLMi0uZ29vZ2xlLm'
    'V2ZW50cy5jbG91ZC5hdWRpdC52MS5SZXF1ZXN0TWV0YWRhdGFSD3JlcXVlc3RNZXRhZGF0YRIx'
    'CgdyZXF1ZXN0GBAgASgLMhcuZ29vZ2xlLnByb3RvYnVmLlN0cnVjdFIHcmVxdWVzdBIzCghyZX'
    'Nwb25zZRgRIAEoCzIXLmdvb2dsZS5wcm90b2J1Zi5TdHJ1Y3RSCHJlc3BvbnNlEjMKCG1ldGFk'
    'YXRhGBIgASgLMhcuZ29vZ2xlLnByb3RvYnVmLlN0cnVjdFIIbWV0YWRhdGESOgoMc2VydmljZV'
    '9kYXRhGA8gASgLMhcuZ29vZ2xlLnByb3RvYnVmLlN0cnVjdFILc2VydmljZURhdGE=');

@$core.Deprecated('Use authenticationInfoDescriptor instead')
const AuthenticationInfo$json = {
  '1': 'AuthenticationInfo',
  '2': [
    {'1': 'principal_email', '3': 1, '4': 1, '5': 9, '10': 'principalEmail'},
    {
      '1': 'authority_selector',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'authoritySelector'
    },
    {
      '1': 'third_party_principal',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'thirdPartyPrincipal'
    },
    {
      '1': 'service_account_key_name',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'serviceAccountKeyName'
    },
    {
      '1': 'service_account_delegation_info',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.google.events.cloud.audit.v1.ServiceAccountDelegationInfo',
      '10': 'serviceAccountDelegationInfo'
    },
    {
      '1': 'principal_subject',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'principalSubject'
    },
  ],
};

/// Descriptor for `AuthenticationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authenticationInfoDescriptor = $convert.base64Decode(
    'ChJBdXRoZW50aWNhdGlvbkluZm8SJwoPcHJpbmNpcGFsX2VtYWlsGAEgASgJUg5wcmluY2lwYW'
    'xFbWFpbBItChJhdXRob3JpdHlfc2VsZWN0b3IYAiABKAlSEWF1dGhvcml0eVNlbGVjdG9yEksK'
    'FXRoaXJkX3BhcnR5X3ByaW5jaXBhbBgEIAEoCzIXLmdvb2dsZS5wcm90b2J1Zi5TdHJ1Y3RSE3'
    'RoaXJkUGFydHlQcmluY2lwYWwSNwoYc2VydmljZV9hY2NvdW50X2tleV9uYW1lGAUgASgJUhVz'
    'ZXJ2aWNlQWNjb3VudEtleU5hbWUSgQEKH3NlcnZpY2VfYWNjb3VudF9kZWxlZ2F0aW9uX2luZm'
    '8YBiADKAsyOi5nb29nbGUuZXZlbnRzLmNsb3VkLmF1ZGl0LnYxLlNlcnZpY2VBY2NvdW50RGVs'
    'ZWdhdGlvbkluZm9SHHNlcnZpY2VBY2NvdW50RGVsZWdhdGlvbkluZm8SKwoRcHJpbmNpcGFsX3'
    'N1YmplY3QYCCABKAlSEHByaW5jaXBhbFN1YmplY3Q=');

@$core.Deprecated('Use authorizationInfoDescriptor instead')
const AuthorizationInfo$json = {
  '1': 'AuthorizationInfo',
  '2': [
    {'1': 'resource', '3': 1, '4': 1, '5': 9, '10': 'resource'},
    {'1': 'permission', '3': 2, '4': 1, '5': 9, '10': 'permission'},
    {'1': 'granted', '3': 3, '4': 1, '5': 8, '10': 'granted'},
    {
      '1': 'resource_attributes',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.rpc.context.AttributeContext.Resource',
      '10': 'resourceAttributes'
    },
  ],
};

/// Descriptor for `AuthorizationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authorizationInfoDescriptor = $convert.base64Decode(
    'ChFBdXRob3JpemF0aW9uSW5mbxIaCghyZXNvdXJjZRgBIAEoCVIIcmVzb3VyY2USHgoKcGVybW'
    'lzc2lvbhgCIAEoCVIKcGVybWlzc2lvbhIYCgdncmFudGVkGAMgASgIUgdncmFudGVkEl4KE3Jl'
    'c291cmNlX2F0dHJpYnV0ZXMYBSABKAsyLS5nb29nbGUucnBjLmNvbnRleHQuQXR0cmlidXRlQ2'
    '9udGV4dC5SZXNvdXJjZVIScmVzb3VyY2VBdHRyaWJ1dGVz');

@$core.Deprecated('Use requestMetadataDescriptor instead')
const RequestMetadata$json = {
  '1': 'RequestMetadata',
  '2': [
    {'1': 'caller_ip', '3': 1, '4': 1, '5': 9, '10': 'callerIp'},
    {
      '1': 'caller_supplied_user_agent',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'callerSuppliedUserAgent'
    },
    {'1': 'caller_network', '3': 3, '4': 1, '5': 9, '10': 'callerNetwork'},
    {
      '1': 'request_attributes',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.rpc.context.AttributeContext.Request',
      '10': 'requestAttributes'
    },
    {
      '1': 'destination_attributes',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.rpc.context.AttributeContext.Peer',
      '10': 'destinationAttributes'
    },
  ],
};

/// Descriptor for `RequestMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestMetadataDescriptor = $convert.base64Decode(
    'Cg9SZXF1ZXN0TWV0YWRhdGESGwoJY2FsbGVyX2lwGAEgASgJUghjYWxsZXJJcBI7ChpjYWxsZX'
    'Jfc3VwcGxpZWRfdXNlcl9hZ2VudBgCIAEoCVIXY2FsbGVyU3VwcGxpZWRVc2VyQWdlbnQSJQoO'
    'Y2FsbGVyX25ldHdvcmsYAyABKAlSDWNhbGxlck5ldHdvcmsSWwoScmVxdWVzdF9hdHRyaWJ1dG'
    'VzGAcgASgLMiwuZ29vZ2xlLnJwYy5jb250ZXh0LkF0dHJpYnV0ZUNvbnRleHQuUmVxdWVzdFIR'
    'cmVxdWVzdEF0dHJpYnV0ZXMSYAoWZGVzdGluYXRpb25fYXR0cmlidXRlcxgIIAEoCzIpLmdvb2'
    'dsZS5ycGMuY29udGV4dC5BdHRyaWJ1dGVDb250ZXh0LlBlZXJSFWRlc3RpbmF0aW9uQXR0cmli'
    'dXRlcw==');

@$core.Deprecated('Use resourceLocationDescriptor instead')
const ResourceLocation$json = {
  '1': 'ResourceLocation',
  '2': [
    {
      '1': 'current_locations',
      '3': 1,
      '4': 3,
      '5': 9,
      '10': 'currentLocations'
    },
    {
      '1': 'original_locations',
      '3': 2,
      '4': 3,
      '5': 9,
      '10': 'originalLocations'
    },
  ],
};

/// Descriptor for `ResourceLocation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resourceLocationDescriptor = $convert.base64Decode(
    'ChBSZXNvdXJjZUxvY2F0aW9uEisKEWN1cnJlbnRfbG9jYXRpb25zGAEgAygJUhBjdXJyZW50TG'
    '9jYXRpb25zEi0KEm9yaWdpbmFsX2xvY2F0aW9ucxgCIAMoCVIRb3JpZ2luYWxMb2NhdGlvbnM=');

@$core.Deprecated('Use serviceAccountDelegationInfoDescriptor instead')
const ServiceAccountDelegationInfo$json = {
  '1': 'ServiceAccountDelegationInfo',
  '2': [
    {
      '1': 'first_party_principal',
      '3': 1,
      '4': 1,
      '5': 11,
      '6':
          '.google.events.cloud.audit.v1.ServiceAccountDelegationInfo.FirstPartyPrincipal',
      '9': 0,
      '10': 'firstPartyPrincipal'
    },
    {
      '1': 'third_party_principal',
      '3': 2,
      '4': 1,
      '5': 11,
      '6':
          '.google.events.cloud.audit.v1.ServiceAccountDelegationInfo.ThirdPartyPrincipal',
      '9': 0,
      '10': 'thirdPartyPrincipal'
    },
  ],
  '3': [
    ServiceAccountDelegationInfo_FirstPartyPrincipal$json,
    ServiceAccountDelegationInfo_ThirdPartyPrincipal$json
  ],
  '8': [
    {'1': 'Authority'},
  ],
};

@$core.Deprecated('Use serviceAccountDelegationInfoDescriptor instead')
const ServiceAccountDelegationInfo_FirstPartyPrincipal$json = {
  '1': 'FirstPartyPrincipal',
  '2': [
    {'1': 'principal_email', '3': 1, '4': 1, '5': 9, '10': 'principalEmail'},
    {
      '1': 'service_metadata',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'serviceMetadata'
    },
  ],
};

@$core.Deprecated('Use serviceAccountDelegationInfoDescriptor instead')
const ServiceAccountDelegationInfo_ThirdPartyPrincipal$json = {
  '1': 'ThirdPartyPrincipal',
  '2': [
    {
      '1': 'third_party_claims',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Struct',
      '10': 'thirdPartyClaims'
    },
  ],
};

/// Descriptor for `ServiceAccountDelegationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceAccountDelegationInfoDescriptor = $convert.base64Decode(
    'ChxTZXJ2aWNlQWNjb3VudERlbGVnYXRpb25JbmZvEoQBChVmaXJzdF9wYXJ0eV9wcmluY2lwYW'
    'wYASABKAsyTi5nb29nbGUuZXZlbnRzLmNsb3VkLmF1ZGl0LnYxLlNlcnZpY2VBY2NvdW50RGVs'
    'ZWdhdGlvbkluZm8uRmlyc3RQYXJ0eVByaW5jaXBhbEgAUhNmaXJzdFBhcnR5UHJpbmNpcGFsEo'
    'QBChV0aGlyZF9wYXJ0eV9wcmluY2lwYWwYAiABKAsyTi5nb29nbGUuZXZlbnRzLmNsb3VkLmF1'
    'ZGl0LnYxLlNlcnZpY2VBY2NvdW50RGVsZWdhdGlvbkluZm8uVGhpcmRQYXJ0eVByaW5jaXBhbE'
    'gAUhN0aGlyZFBhcnR5UHJpbmNpcGFsGoIBChNGaXJzdFBhcnR5UHJpbmNpcGFsEicKD3ByaW5j'
    'aXBhbF9lbWFpbBgBIAEoCVIOcHJpbmNpcGFsRW1haWwSQgoQc2VydmljZV9tZXRhZGF0YRgCIA'
    'EoCzIXLmdvb2dsZS5wcm90b2J1Zi5TdHJ1Y3RSD3NlcnZpY2VNZXRhZGF0YRpcChNUaGlyZFBh'
    'cnR5UHJpbmNpcGFsEkUKEnRoaXJkX3BhcnR5X2NsYWltcxgBIAEoCzIXLmdvb2dsZS5wcm90b2'
    'J1Zi5TdHJ1Y3RSEHRoaXJkUGFydHlDbGFpbXNCCwoJQXV0aG9yaXR5');

@$core.Deprecated('Use logSplitDescriptor instead')
const LogSplit$json = {
  '1': 'LogSplit',
  '2': [
    {'1': 'uid', '3': 1, '4': 1, '5': 9, '10': 'uid'},
    {'1': 'index', '3': 2, '4': 1, '5': 5, '10': 'index'},
    {'1': 'total_splits', '3': 3, '4': 1, '5': 5, '10': 'totalSplits'},
  ],
};

/// Descriptor for `LogSplit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logSplitDescriptor = $convert.base64Decode(
    'CghMb2dTcGxpdBIQCgN1aWQYASABKAlSA3VpZBIUCgVpbmRleBgCIAEoBVIFaW5kZXgSIQoMdG'
    '90YWxfc3BsaXRzGAMgASgFUgt0b3RhbFNwbGl0cw==');
