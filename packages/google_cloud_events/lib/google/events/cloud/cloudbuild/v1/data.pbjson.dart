// This is a generated file - do not edit.
//
// Generated from google/events/cloud/cloudbuild/v1/data.proto.

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

@$core.Deprecated('Use buildEventDataDescriptor instead')
const BuildEventData$json = {
  '1': 'BuildEventData',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'project_id', '3': 16, '4': 1, '5': 9, '10': 'projectId'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.events.cloud.cloudbuild.v1.BuildEventData.Status',
      '10': 'status'
    },
    {'1': 'status_detail', '3': 24, '4': 1, '5': 9, '10': 'statusDetail'},
    {
      '1': 'source',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.Source',
      '10': 'source'
    },
    {
      '1': 'steps',
      '3': 11,
      '4': 3,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.BuildStep',
      '10': 'steps'
    },
    {
      '1': 'results',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.Results',
      '10': 'results'
    },
    {
      '1': 'create_time',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createTime'
    },
    {
      '1': 'start_time',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'startTime'
    },
    {
      '1': 'finish_time',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'finishTime'
    },
    {
      '1': 'timeout',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'timeout'
    },
    {'1': 'images', '3': 13, '4': 3, '5': 9, '10': 'images'},
    {
      '1': 'queue_ttl',
      '3': 40,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'queueTtl'
    },
    {
      '1': 'artifacts',
      '3': 37,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.Artifacts',
      '10': 'artifacts'
    },
    {'1': 'logs_bucket', '3': 19, '4': 1, '5': 9, '10': 'logsBucket'},
    {
      '1': 'source_provenance',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.SourceProvenance',
      '10': 'sourceProvenance'
    },
    {'1': 'build_trigger_id', '3': 22, '4': 1, '5': 9, '10': 'buildTriggerId'},
    {
      '1': 'options',
      '3': 23,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.BuildOptions',
      '10': 'options'
    },
    {'1': 'log_url', '3': 25, '4': 1, '5': 9, '10': 'logUrl'},
    {
      '1': 'substitutions',
      '3': 29,
      '4': 3,
      '5': 11,
      '6':
          '.google.events.cloud.cloudbuild.v1.BuildEventData.SubstitutionsEntry',
      '10': 'substitutions'
    },
    {'1': 'tags', '3': 31, '4': 3, '5': 9, '10': 'tags'},
    {
      '1': 'secrets',
      '3': 32,
      '4': 3,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.Secret',
      '10': 'secrets'
    },
    {
      '1': 'timing',
      '3': 33,
      '4': 3,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.BuildEventData.TimingEntry',
      '10': 'timing'
    },
  ],
  '3': [
    BuildEventData_SubstitutionsEntry$json,
    BuildEventData_TimingEntry$json
  ],
  '4': [BuildEventData_Status$json],
};

@$core.Deprecated('Use buildEventDataDescriptor instead')
const BuildEventData_SubstitutionsEntry$json = {
  '1': 'SubstitutionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use buildEventDataDescriptor instead')
const BuildEventData_TimingEntry$json = {
  '1': 'TimingEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.TimeSpan',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use buildEventDataDescriptor instead')
const BuildEventData_Status$json = {
  '1': 'Status',
  '2': [
    {'1': 'STATUS_UNKNOWN', '2': 0},
    {'1': 'QUEUED', '2': 1},
    {'1': 'WORKING', '2': 2},
    {'1': 'SUCCESS', '2': 3},
    {'1': 'FAILURE', '2': 4},
    {'1': 'INTERNAL_ERROR', '2': 5},
    {'1': 'TIMEOUT', '2': 6},
    {'1': 'CANCELLED', '2': 7},
    {'1': 'EXPIRED', '2': 9},
  ],
};

/// Descriptor for `BuildEventData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buildEventDataDescriptor = $convert.base64Decode(
    'Cg5CdWlsZEV2ZW50RGF0YRIOCgJpZBgBIAEoCVICaWQSHQoKcHJvamVjdF9pZBgQIAEoCVIJcH'
    'JvamVjdElkElAKBnN0YXR1cxgCIAEoDjI4Lmdvb2dsZS5ldmVudHMuY2xvdWQuY2xvdWRidWls'
    'ZC52MS5CdWlsZEV2ZW50RGF0YS5TdGF0dXNSBnN0YXR1cxIjCg1zdGF0dXNfZGV0YWlsGBggAS'
    'gJUgxzdGF0dXNEZXRhaWwSQQoGc291cmNlGAMgASgLMikuZ29vZ2xlLmV2ZW50cy5jbG91ZC5j'
    'bG91ZGJ1aWxkLnYxLlNvdXJjZVIGc291cmNlEkIKBXN0ZXBzGAsgAygLMiwuZ29vZ2xlLmV2ZW'
    '50cy5jbG91ZC5jbG91ZGJ1aWxkLnYxLkJ1aWxkU3RlcFIFc3RlcHMSRAoHcmVzdWx0cxgKIAEo'
    'CzIqLmdvb2dsZS5ldmVudHMuY2xvdWQuY2xvdWRidWlsZC52MS5SZXN1bHRzUgdyZXN1bHRzEj'
    'sKC2NyZWF0ZV90aW1lGAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKY3JlYXRl'
    'VGltZRI5CgpzdGFydF90aW1lGAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc3'
    'RhcnRUaW1lEjsKC2ZpbmlzaF90aW1lGAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFt'
    'cFIKZmluaXNoVGltZRIzCgd0aW1lb3V0GAwgASgLMhkuZ29vZ2xlLnByb3RvYnVmLkR1cmF0aW'
    '9uUgd0aW1lb3V0EhYKBmltYWdlcxgNIAMoCVIGaW1hZ2VzEjYKCXF1ZXVlX3R0bBgoIAEoCzIZ'
    'Lmdvb2dsZS5wcm90b2J1Zi5EdXJhdGlvblIIcXVldWVUdGwSSgoJYXJ0aWZhY3RzGCUgASgLMi'
    'wuZ29vZ2xlLmV2ZW50cy5jbG91ZC5jbG91ZGJ1aWxkLnYxLkFydGlmYWN0c1IJYXJ0aWZhY3Rz'
    'Eh8KC2xvZ3NfYnVja2V0GBMgASgJUgpsb2dzQnVja2V0EmAKEXNvdXJjZV9wcm92ZW5hbmNlGB'
    'UgASgLMjMuZ29vZ2xlLmV2ZW50cy5jbG91ZC5jbG91ZGJ1aWxkLnYxLlNvdXJjZVByb3ZlbmFu'
    'Y2VSEHNvdXJjZVByb3ZlbmFuY2USKAoQYnVpbGRfdHJpZ2dlcl9pZBgWIAEoCVIOYnVpbGRUcm'
    'lnZ2VySWQSSQoHb3B0aW9ucxgXIAEoCzIvLmdvb2dsZS5ldmVudHMuY2xvdWQuY2xvdWRidWls'
    'ZC52MS5CdWlsZE9wdGlvbnNSB29wdGlvbnMSFwoHbG9nX3VybBgZIAEoCVIGbG9nVXJsEmoKDX'
    'N1YnN0aXR1dGlvbnMYHSADKAsyRC5nb29nbGUuZXZlbnRzLmNsb3VkLmNsb3VkYnVpbGQudjEu'
    'QnVpbGRFdmVudERhdGEuU3Vic3RpdHV0aW9uc0VudHJ5Ug1zdWJzdGl0dXRpb25zEhIKBHRhZ3'
    'MYHyADKAlSBHRhZ3MSQwoHc2VjcmV0cxggIAMoCzIpLmdvb2dsZS5ldmVudHMuY2xvdWQuY2xv'
    'dWRidWlsZC52MS5TZWNyZXRSB3NlY3JldHMSVQoGdGltaW5nGCEgAygLMj0uZ29vZ2xlLmV2ZW'
    '50cy5jbG91ZC5jbG91ZGJ1aWxkLnYxLkJ1aWxkRXZlbnREYXRhLlRpbWluZ0VudHJ5UgZ0aW1p'
    'bmcaQAoSU3Vic3RpdHV0aW9uc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgAS'
    'gJUgV2YWx1ZToCOAEaZgoLVGltaW5nRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSQQoFdmFsdWUY'
    'AiABKAsyKy5nb29nbGUuZXZlbnRzLmNsb3VkLmNsb3VkYnVpbGQudjEuVGltZVNwYW5SBXZhbH'
    'VlOgI4ASKMAQoGU3RhdHVzEhIKDlNUQVRVU19VTktOT1dOEAASCgoGUVVFVUVEEAESCwoHV09S'
    'S0lORxACEgsKB1NVQ0NFU1MQAxILCgdGQUlMVVJFEAQSEgoOSU5URVJOQUxfRVJST1IQBRILCg'
    'dUSU1FT1VUEAYSDQoJQ0FOQ0VMTEVEEAcSCwoHRVhQSVJFRBAJ');

@$core.Deprecated('Use sourceDescriptor instead')
const Source$json = {
  '1': 'Source',
  '2': [
    {
      '1': 'storage_source',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.StorageSource',
      '9': 0,
      '10': 'storageSource'
    },
    {
      '1': 'repo_source',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.RepoSource',
      '9': 0,
      '10': 'repoSource'
    },
  ],
  '8': [
    {'1': 'source'},
  ],
};

/// Descriptor for `Source`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sourceDescriptor = $convert.base64Decode(
    'CgZTb3VyY2USWQoOc3RvcmFnZV9zb3VyY2UYAiABKAsyMC5nb29nbGUuZXZlbnRzLmNsb3VkLm'
    'Nsb3VkYnVpbGQudjEuU3RvcmFnZVNvdXJjZUgAUg1zdG9yYWdlU291cmNlElAKC3JlcG9fc291'
    'cmNlGAMgASgLMi0uZ29vZ2xlLmV2ZW50cy5jbG91ZC5jbG91ZGJ1aWxkLnYxLlJlcG9Tb3VyY2'
    'VIAFIKcmVwb1NvdXJjZUIICgZzb3VyY2U=');

@$core.Deprecated('Use storageSourceDescriptor instead')
const StorageSource$json = {
  '1': 'StorageSource',
  '2': [
    {'1': 'bucket', '3': 1, '4': 1, '5': 9, '10': 'bucket'},
    {'1': 'object', '3': 2, '4': 1, '5': 9, '10': 'object'},
    {'1': 'generation', '3': 3, '4': 1, '5': 3, '10': 'generation'},
  ],
};

/// Descriptor for `StorageSource`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageSourceDescriptor = $convert.base64Decode(
    'Cg1TdG9yYWdlU291cmNlEhYKBmJ1Y2tldBgBIAEoCVIGYnVja2V0EhYKBm9iamVjdBgCIAEoCV'
    'IGb2JqZWN0Eh4KCmdlbmVyYXRpb24YAyABKANSCmdlbmVyYXRpb24=');

@$core.Deprecated('Use repoSourceDescriptor instead')
const RepoSource$json = {
  '1': 'RepoSource',
  '2': [
    {'1': 'project_id', '3': 1, '4': 1, '5': 9, '10': 'projectId'},
    {'1': 'repo_name', '3': 2, '4': 1, '5': 9, '10': 'repoName'},
    {'1': 'branch_name', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'branchName'},
    {'1': 'tag_name', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'tagName'},
    {'1': 'commit_sha', '3': 5, '4': 1, '5': 9, '9': 0, '10': 'commitSha'},
    {'1': 'dir', '3': 7, '4': 1, '5': 9, '10': 'dir'},
    {'1': 'invert_regex', '3': 8, '4': 1, '5': 8, '10': 'invertRegex'},
    {
      '1': 'substitutions',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.RepoSource.SubstitutionsEntry',
      '10': 'substitutions'
    },
  ],
  '3': [RepoSource_SubstitutionsEntry$json],
  '8': [
    {'1': 'revision'},
  ],
};

@$core.Deprecated('Use repoSourceDescriptor instead')
const RepoSource_SubstitutionsEntry$json = {
  '1': 'SubstitutionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `RepoSource`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List repoSourceDescriptor = $convert.base64Decode(
    'CgpSZXBvU291cmNlEh0KCnByb2plY3RfaWQYASABKAlSCXByb2plY3RJZBIbCglyZXBvX25hbW'
    'UYAiABKAlSCHJlcG9OYW1lEiEKC2JyYW5jaF9uYW1lGAMgASgJSABSCmJyYW5jaE5hbWUSGwoI'
    'dGFnX25hbWUYBCABKAlIAFIHdGFnTmFtZRIfCgpjb21taXRfc2hhGAUgASgJSABSCWNvbW1pdF'
    'NoYRIQCgNkaXIYByABKAlSA2RpchIhCgxpbnZlcnRfcmVnZXgYCCABKAhSC2ludmVydFJlZ2V4'
    'EmYKDXN1YnN0aXR1dGlvbnMYCSADKAsyQC5nb29nbGUuZXZlbnRzLmNsb3VkLmNsb3VkYnVpbG'
    'QudjEuUmVwb1NvdXJjZS5TdWJzdGl0dXRpb25zRW50cnlSDXN1YnN0aXR1dGlvbnMaQAoSU3Vi'
    'c3RpdHV0aW9uc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZT'
    'oCOAFCCgoIcmV2aXNpb24=');

@$core.Deprecated('Use buildStepDescriptor instead')
const BuildStep$json = {
  '1': 'BuildStep',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'env', '3': 2, '4': 3, '5': 9, '10': 'env'},
    {'1': 'args', '3': 3, '4': 3, '5': 9, '10': 'args'},
    {'1': 'dir', '3': 4, '4': 1, '5': 9, '10': 'dir'},
    {'1': 'id', '3': 5, '4': 1, '5': 9, '10': 'id'},
    {'1': 'wait_for', '3': 6, '4': 3, '5': 9, '10': 'waitFor'},
    {'1': 'entrypoint', '3': 7, '4': 1, '5': 9, '10': 'entrypoint'},
    {'1': 'secret_env', '3': 8, '4': 3, '5': 9, '10': 'secretEnv'},
    {
      '1': 'volumes',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.Volume',
      '10': 'volumes'
    },
    {
      '1': 'timing',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.TimeSpan',
      '10': 'timing'
    },
    {
      '1': 'pull_timing',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.TimeSpan',
      '10': 'pullTiming'
    },
    {
      '1': 'timeout',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'timeout'
    },
    {
      '1': 'status',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.google.events.cloud.cloudbuild.v1.BuildEventData.Status',
      '10': 'status'
    },
  ],
};

/// Descriptor for `BuildStep`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buildStepDescriptor = $convert.base64Decode(
    'CglCdWlsZFN0ZXASEgoEbmFtZRgBIAEoCVIEbmFtZRIQCgNlbnYYAiADKAlSA2VudhISCgRhcm'
    'dzGAMgAygJUgRhcmdzEhAKA2RpchgEIAEoCVIDZGlyEg4KAmlkGAUgASgJUgJpZBIZCgh3YWl0'
    'X2ZvchgGIAMoCVIHd2FpdEZvchIeCgplbnRyeXBvaW50GAcgASgJUgplbnRyeXBvaW50Eh0KCn'
    'NlY3JldF9lbnYYCCADKAlSCXNlY3JldEVudhJDCgd2b2x1bWVzGAkgAygLMikuZ29vZ2xlLmV2'
    'ZW50cy5jbG91ZC5jbG91ZGJ1aWxkLnYxLlZvbHVtZVIHdm9sdW1lcxJDCgZ0aW1pbmcYCiABKA'
    'syKy5nb29nbGUuZXZlbnRzLmNsb3VkLmNsb3VkYnVpbGQudjEuVGltZVNwYW5SBnRpbWluZxJM'
    'CgtwdWxsX3RpbWluZxgNIAEoCzIrLmdvb2dsZS5ldmVudHMuY2xvdWQuY2xvdWRidWlsZC52MS'
    '5UaW1lU3BhblIKcHVsbFRpbWluZxIzCgd0aW1lb3V0GAsgASgLMhkuZ29vZ2xlLnByb3RvYnVm'
    'LkR1cmF0aW9uUgd0aW1lb3V0ElAKBnN0YXR1cxgMIAEoDjI4Lmdvb2dsZS5ldmVudHMuY2xvdW'
    'QuY2xvdWRidWlsZC52MS5CdWlsZEV2ZW50RGF0YS5TdGF0dXNSBnN0YXR1cw==');

@$core.Deprecated('Use volumeDescriptor instead')
const Volume$json = {
  '1': 'Volume',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'path', '3': 2, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `Volume`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List volumeDescriptor = $convert.base64Decode(
    'CgZWb2x1bWUSEgoEbmFtZRgBIAEoCVIEbmFtZRISCgRwYXRoGAIgASgJUgRwYXRo');

@$core.Deprecated('Use resultsDescriptor instead')
const Results$json = {
  '1': 'Results',
  '2': [
    {
      '1': 'images',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.BuiltImage',
      '10': 'images'
    },
    {'1': 'build_step_images', '3': 3, '4': 3, '5': 9, '10': 'buildStepImages'},
    {
      '1': 'artifact_manifest',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'artifactManifest'
    },
    {'1': 'num_artifacts', '3': 5, '4': 1, '5': 3, '10': 'numArtifacts'},
    {
      '1': 'build_step_outputs',
      '3': 6,
      '4': 3,
      '5': 12,
      '10': 'buildStepOutputs'
    },
    {
      '1': 'artifact_timing',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.TimeSpan',
      '10': 'artifactTiming'
    },
  ],
};

/// Descriptor for `Results`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resultsDescriptor = $convert.base64Decode(
    'CgdSZXN1bHRzEkUKBmltYWdlcxgCIAMoCzItLmdvb2dsZS5ldmVudHMuY2xvdWQuY2xvdWRidW'
    'lsZC52MS5CdWlsdEltYWdlUgZpbWFnZXMSKgoRYnVpbGRfc3RlcF9pbWFnZXMYAyADKAlSD2J1'
    'aWxkU3RlcEltYWdlcxIrChFhcnRpZmFjdF9tYW5pZmVzdBgEIAEoCVIQYXJ0aWZhY3RNYW5pZm'
    'VzdBIjCg1udW1fYXJ0aWZhY3RzGAUgASgDUgxudW1BcnRpZmFjdHMSLAoSYnVpbGRfc3RlcF9v'
    'dXRwdXRzGAYgAygMUhBidWlsZFN0ZXBPdXRwdXRzElQKD2FydGlmYWN0X3RpbWluZxgHIAEoCz'
    'IrLmdvb2dsZS5ldmVudHMuY2xvdWQuY2xvdWRidWlsZC52MS5UaW1lU3BhblIOYXJ0aWZhY3RU'
    'aW1pbmc=');

@$core.Deprecated('Use builtImageDescriptor instead')
const BuiltImage$json = {
  '1': 'BuiltImage',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'digest', '3': 3, '4': 1, '5': 9, '10': 'digest'},
    {
      '1': 'push_timing',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.TimeSpan',
      '10': 'pushTiming'
    },
  ],
};

/// Descriptor for `BuiltImage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List builtImageDescriptor = $convert.base64Decode(
    'CgpCdWlsdEltYWdlEhIKBG5hbWUYASABKAlSBG5hbWUSFgoGZGlnZXN0GAMgASgJUgZkaWdlc3'
    'QSTAoLcHVzaF90aW1pbmcYBCABKAsyKy5nb29nbGUuZXZlbnRzLmNsb3VkLmNsb3VkYnVpbGQu'
    'djEuVGltZVNwYW5SCnB1c2hUaW1pbmc=');

@$core.Deprecated('Use artifactsDescriptor instead')
const Artifacts$json = {
  '1': 'Artifacts',
  '2': [
    {'1': 'images', '3': 1, '4': 3, '5': 9, '10': 'images'},
    {
      '1': 'objects',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.Artifacts.ArtifactObjects',
      '10': 'objects'
    },
  ],
  '3': [Artifacts_ArtifactObjects$json],
};

@$core.Deprecated('Use artifactsDescriptor instead')
const Artifacts_ArtifactObjects$json = {
  '1': 'ArtifactObjects',
  '2': [
    {'1': 'location', '3': 1, '4': 1, '5': 9, '10': 'location'},
    {'1': 'paths', '3': 2, '4': 3, '5': 9, '10': 'paths'},
    {
      '1': 'timing',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.TimeSpan',
      '10': 'timing'
    },
  ],
};

/// Descriptor for `Artifacts`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List artifactsDescriptor = $convert.base64Decode(
    'CglBcnRpZmFjdHMSFgoGaW1hZ2VzGAEgAygJUgZpbWFnZXMSVgoHb2JqZWN0cxgCIAEoCzI8Lm'
    'dvb2dsZS5ldmVudHMuY2xvdWQuY2xvdWRidWlsZC52MS5BcnRpZmFjdHMuQXJ0aWZhY3RPYmpl'
    'Y3RzUgdvYmplY3RzGogBCg9BcnRpZmFjdE9iamVjdHMSGgoIbG9jYXRpb24YASABKAlSCGxvY2'
    'F0aW9uEhQKBXBhdGhzGAIgAygJUgVwYXRocxJDCgZ0aW1pbmcYAyABKAsyKy5nb29nbGUuZXZl'
    'bnRzLmNsb3VkLmNsb3VkYnVpbGQudjEuVGltZVNwYW5SBnRpbWluZw==');

@$core.Deprecated('Use timeSpanDescriptor instead')
const TimeSpan$json = {
  '1': 'TimeSpan',
  '2': [
    {
      '1': 'start_time',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'startTime'
    },
    {
      '1': 'end_time',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'endTime'
    },
  ],
};

/// Descriptor for `TimeSpan`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeSpanDescriptor = $convert.base64Decode(
    'CghUaW1lU3BhbhI5CgpzdGFydF90aW1lGAEgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdG'
    'FtcFIJc3RhcnRUaW1lEjUKCGVuZF90aW1lGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVz'
    'dGFtcFIHZW5kVGltZQ==');

@$core.Deprecated('Use sourceProvenanceDescriptor instead')
const SourceProvenance$json = {
  '1': 'SourceProvenance',
  '2': [
    {
      '1': 'resolved_storage_source',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.StorageSource',
      '10': 'resolvedStorageSource'
    },
    {
      '1': 'resolved_repo_source',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.RepoSource',
      '10': 'resolvedRepoSource'
    },
    {
      '1': 'file_hashes',
      '3': 4,
      '4': 3,
      '5': 11,
      '6':
          '.google.events.cloud.cloudbuild.v1.SourceProvenance.FileHashesEntry',
      '10': 'fileHashes'
    },
  ],
  '3': [SourceProvenance_FileHashesEntry$json],
};

@$core.Deprecated('Use sourceProvenanceDescriptor instead')
const SourceProvenance_FileHashesEntry$json = {
  '1': 'FileHashesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.FileHashes',
      '10': 'value'
    },
  ],
  '7': {'7': true},
};

/// Descriptor for `SourceProvenance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sourceProvenanceDescriptor = $convert.base64Decode(
    'ChBTb3VyY2VQcm92ZW5hbmNlEmgKF3Jlc29sdmVkX3N0b3JhZ2Vfc291cmNlGAMgASgLMjAuZ2'
    '9vZ2xlLmV2ZW50cy5jbG91ZC5jbG91ZGJ1aWxkLnYxLlN0b3JhZ2VTb3VyY2VSFXJlc29sdmVk'
    'U3RvcmFnZVNvdXJjZRJfChRyZXNvbHZlZF9yZXBvX3NvdXJjZRgGIAEoCzItLmdvb2dsZS5ldm'
    'VudHMuY2xvdWQuY2xvdWRidWlsZC52MS5SZXBvU291cmNlUhJyZXNvbHZlZFJlcG9Tb3VyY2US'
    'ZAoLZmlsZV9oYXNoZXMYBCADKAsyQy5nb29nbGUuZXZlbnRzLmNsb3VkLmNsb3VkYnVpbGQudj'
    'EuU291cmNlUHJvdmVuYW5jZS5GaWxlSGFzaGVzRW50cnlSCmZpbGVIYXNoZXMabAoPRmlsZUhh'
    'c2hlc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EkMKBXZhbHVlGAIgASgLMi0uZ29vZ2xlLmV2ZW'
    '50cy5jbG91ZC5jbG91ZGJ1aWxkLnYxLkZpbGVIYXNoZXNSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use fileHashesDescriptor instead')
const FileHashes$json = {
  '1': 'FileHashes',
  '2': [
    {
      '1': 'file_hash',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.Hash',
      '10': 'fileHash'
    },
  ],
};

/// Descriptor for `FileHashes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileHashesDescriptor = $convert.base64Decode(
    'CgpGaWxlSGFzaGVzEkQKCWZpbGVfaGFzaBgBIAMoCzInLmdvb2dsZS5ldmVudHMuY2xvdWQuY2'
    'xvdWRidWlsZC52MS5IYXNoUghmaWxlSGFzaA==');

@$core.Deprecated('Use hashDescriptor instead')
const Hash$json = {
  '1': 'Hash',
  '2': [
    {
      '1': 'type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.events.cloud.cloudbuild.v1.Hash.HashType',
      '10': 'type'
    },
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '4': [Hash_HashType$json],
};

@$core.Deprecated('Use hashDescriptor instead')
const Hash_HashType$json = {
  '1': 'HashType',
  '2': [
    {'1': 'NONE', '2': 0},
    {'1': 'SHA256', '2': 1},
    {'1': 'MD5', '2': 2},
  ],
};

/// Descriptor for `Hash`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hashDescriptor = $convert.base64Decode(
    'CgRIYXNoEkQKBHR5cGUYASABKA4yMC5nb29nbGUuZXZlbnRzLmNsb3VkLmNsb3VkYnVpbGQudj'
    'EuSGFzaC5IYXNoVHlwZVIEdHlwZRIUCgV2YWx1ZRgCIAEoDFIFdmFsdWUiKQoISGFzaFR5cGUS'
    'CAoETk9ORRAAEgoKBlNIQTI1NhABEgcKA01ENRAC');

@$core.Deprecated('Use secretDescriptor instead')
const Secret$json = {
  '1': 'Secret',
  '2': [
    {'1': 'kms_key_name', '3': 1, '4': 1, '5': 9, '10': 'kmsKeyName'},
    {
      '1': 'secret_env',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.Secret.SecretEnvEntry',
      '10': 'secretEnv'
    },
  ],
  '3': [Secret_SecretEnvEntry$json],
};

@$core.Deprecated('Use secretDescriptor instead')
const Secret_SecretEnvEntry$json = {
  '1': 'SecretEnvEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Secret`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List secretDescriptor = $convert.base64Decode(
    'CgZTZWNyZXQSIAoMa21zX2tleV9uYW1lGAEgASgJUgprbXNLZXlOYW1lElcKCnNlY3JldF9lbn'
    'YYAyADKAsyOC5nb29nbGUuZXZlbnRzLmNsb3VkLmNsb3VkYnVpbGQudjEuU2VjcmV0LlNlY3Jl'
    'dEVudkVudHJ5UglzZWNyZXRFbnYaPAoOU2VjcmV0RW52RW50cnkSEAoDa2V5GAEgASgJUgNrZX'
    'kSFAoFdmFsdWUYAiABKAxSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use buildOptionsDescriptor instead')
const BuildOptions$json = {
  '1': 'BuildOptions',
  '2': [
    {
      '1': 'source_provenance_hash',
      '3': 1,
      '4': 3,
      '5': 14,
      '6': '.google.events.cloud.cloudbuild.v1.Hash.HashType',
      '10': 'sourceProvenanceHash'
    },
    {
      '1': 'requested_verify_option',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.events.cloud.cloudbuild.v1.BuildOptions.VerifyOption',
      '10': 'requestedVerifyOption'
    },
    {
      '1': 'machine_type',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.google.events.cloud.cloudbuild.v1.BuildOptions.MachineType',
      '10': 'machineType'
    },
    {'1': 'disk_size_gb', '3': 6, '4': 1, '5': 3, '10': 'diskSizeGb'},
    {
      '1': 'substitution_option',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.google.events.cloud.cloudbuild.v1.BuildOptions.SubstitutionOption',
      '10': 'substitutionOption'
    },
    {
      '1': 'log_streaming_option',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.google.events.cloud.cloudbuild.v1.BuildOptions.LogStreamingOption',
      '10': 'logStreamingOption'
    },
    {'1': 'worker_pool', '3': 7, '4': 1, '5': 9, '10': 'workerPool'},
    {
      '1': 'logging',
      '3': 11,
      '4': 1,
      '5': 14,
      '6': '.google.events.cloud.cloudbuild.v1.BuildOptions.LoggingMode',
      '10': 'logging'
    },
    {'1': 'env', '3': 12, '4': 3, '5': 9, '10': 'env'},
    {'1': 'secret_env', '3': 13, '4': 3, '5': 9, '10': 'secretEnv'},
    {
      '1': 'volumes',
      '3': 14,
      '4': 3,
      '5': 11,
      '6': '.google.events.cloud.cloudbuild.v1.Volume',
      '10': 'volumes'
    },
  ],
  '4': [
    BuildOptions_VerifyOption$json,
    BuildOptions_MachineType$json,
    BuildOptions_SubstitutionOption$json,
    BuildOptions_LogStreamingOption$json,
    BuildOptions_LoggingMode$json
  ],
};

@$core.Deprecated('Use buildOptionsDescriptor instead')
const BuildOptions_VerifyOption$json = {
  '1': 'VerifyOption',
  '2': [
    {'1': 'NOT_VERIFIED', '2': 0},
    {'1': 'VERIFIED', '2': 1},
  ],
};

@$core.Deprecated('Use buildOptionsDescriptor instead')
const BuildOptions_MachineType$json = {
  '1': 'MachineType',
  '2': [
    {'1': 'UNSPECIFIED', '2': 0},
    {'1': 'N1_HIGHCPU_8', '2': 1},
    {'1': 'N1_HIGHCPU_32', '2': 2},
  ],
};

@$core.Deprecated('Use buildOptionsDescriptor instead')
const BuildOptions_SubstitutionOption$json = {
  '1': 'SubstitutionOption',
  '2': [
    {'1': 'MUST_MATCH', '2': 0},
    {'1': 'ALLOW_LOOSE', '2': 1},
  ],
};

@$core.Deprecated('Use buildOptionsDescriptor instead')
const BuildOptions_LogStreamingOption$json = {
  '1': 'LogStreamingOption',
  '2': [
    {'1': 'STREAM_DEFAULT', '2': 0},
    {'1': 'STREAM_ON', '2': 1},
    {'1': 'STREAM_OFF', '2': 2},
  ],
};

@$core.Deprecated('Use buildOptionsDescriptor instead')
const BuildOptions_LoggingMode$json = {
  '1': 'LoggingMode',
  '2': [
    {'1': 'LOGGING_UNSPECIFIED', '2': 0},
    {'1': 'LEGACY', '2': 1},
    {'1': 'GCS_ONLY', '2': 2},
  ],
};

/// Descriptor for `BuildOptions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buildOptionsDescriptor = $convert.base64Decode(
    'CgxCdWlsZE9wdGlvbnMSZgoWc291cmNlX3Byb3ZlbmFuY2VfaGFzaBgBIAMoDjIwLmdvb2dsZS'
    '5ldmVudHMuY2xvdWQuY2xvdWRidWlsZC52MS5IYXNoLkhhc2hUeXBlUhRzb3VyY2VQcm92ZW5h'
    'bmNlSGFzaBJ0ChdyZXF1ZXN0ZWRfdmVyaWZ5X29wdGlvbhgCIAEoDjI8Lmdvb2dsZS5ldmVudH'
    'MuY2xvdWQuY2xvdWRidWlsZC52MS5CdWlsZE9wdGlvbnMuVmVyaWZ5T3B0aW9uUhVyZXF1ZXN0'
    'ZWRWZXJpZnlPcHRpb24SXgoMbWFjaGluZV90eXBlGAMgASgOMjsuZ29vZ2xlLmV2ZW50cy5jbG'
    '91ZC5jbG91ZGJ1aWxkLnYxLkJ1aWxkT3B0aW9ucy5NYWNoaW5lVHlwZVILbWFjaGluZVR5cGUS'
    'IAoMZGlza19zaXplX2diGAYgASgDUgpkaXNrU2l6ZUdiEnMKE3N1YnN0aXR1dGlvbl9vcHRpb2'
    '4YBCABKA4yQi5nb29nbGUuZXZlbnRzLmNsb3VkLmNsb3VkYnVpbGQudjEuQnVpbGRPcHRpb25z'
    'LlN1YnN0aXR1dGlvbk9wdGlvblISc3Vic3RpdHV0aW9uT3B0aW9uEnQKFGxvZ19zdHJlYW1pbm'
    'dfb3B0aW9uGAUgASgOMkIuZ29vZ2xlLmV2ZW50cy5jbG91ZC5jbG91ZGJ1aWxkLnYxLkJ1aWxk'
    'T3B0aW9ucy5Mb2dTdHJlYW1pbmdPcHRpb25SEmxvZ1N0cmVhbWluZ09wdGlvbhIfCgt3b3JrZX'
    'JfcG9vbBgHIAEoCVIKd29ya2VyUG9vbBJVCgdsb2dnaW5nGAsgASgOMjsuZ29vZ2xlLmV2ZW50'
    'cy5jbG91ZC5jbG91ZGJ1aWxkLnYxLkJ1aWxkT3B0aW9ucy5Mb2dnaW5nTW9kZVIHbG9nZ2luZx'
    'IQCgNlbnYYDCADKAlSA2VudhIdCgpzZWNyZXRfZW52GA0gAygJUglzZWNyZXRFbnYSQwoHdm9s'
    'dW1lcxgOIAMoCzIpLmdvb2dsZS5ldmVudHMuY2xvdWQuY2xvdWRidWlsZC52MS5Wb2x1bWVSB3'
    'ZvbHVtZXMiLgoMVmVyaWZ5T3B0aW9uEhAKDE5PVF9WRVJJRklFRBAAEgwKCFZFUklGSUVEEAEi'
    'QwoLTWFjaGluZVR5cGUSDwoLVU5TUEVDSUZJRUQQABIQCgxOMV9ISUdIQ1BVXzgQARIRCg1OMV'
    '9ISUdIQ1BVXzMyEAIiNQoSU3Vic3RpdHV0aW9uT3B0aW9uEg4KCk1VU1RfTUFUQ0gQABIPCgtB'
    'TExPV19MT09TRRABIkcKEkxvZ1N0cmVhbWluZ09wdGlvbhISCg5TVFJFQU1fREVGQVVMVBAAEg'
    '0KCVNUUkVBTV9PThABEg4KClNUUkVBTV9PRkYQAiJACgtMb2dnaW5nTW9kZRIXChNMT0dHSU5H'
    'X1VOU1BFQ0lGSUVEEAASCgoGTEVHQUNZEAESDAoIR0NTX09OTFkQAg==');
