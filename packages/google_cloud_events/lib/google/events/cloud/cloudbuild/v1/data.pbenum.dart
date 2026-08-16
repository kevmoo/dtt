// This is a generated file - do not edit.
//
// Generated from google/events/cloud/cloudbuild/v1/data.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Possible status of a build or build step.
class BuildEventData_Status extends $pb.ProtobufEnum {
  /// Status of the build is unknown.
  static const BuildEventData_Status STATUS_UNKNOWN =
      BuildEventData_Status._(0, _omitEnumNames ? '' : 'STATUS_UNKNOWN');

  /// Build or step is queued; work has not yet begun.
  static const BuildEventData_Status QUEUED =
      BuildEventData_Status._(1, _omitEnumNames ? '' : 'QUEUED');

  /// Build or step is being executed.
  static const BuildEventData_Status WORKING =
      BuildEventData_Status._(2, _omitEnumNames ? '' : 'WORKING');

  /// Build or step finished successfully.
  static const BuildEventData_Status SUCCESS =
      BuildEventData_Status._(3, _omitEnumNames ? '' : 'SUCCESS');

  /// Build or step failed to complete successfully.
  static const BuildEventData_Status FAILURE =
      BuildEventData_Status._(4, _omitEnumNames ? '' : 'FAILURE');

  /// Build or step failed due to an internal cause.
  static const BuildEventData_Status INTERNAL_ERROR =
      BuildEventData_Status._(5, _omitEnumNames ? '' : 'INTERNAL_ERROR');

  /// Build or step took longer than was allowed.
  static const BuildEventData_Status TIMEOUT =
      BuildEventData_Status._(6, _omitEnumNames ? '' : 'TIMEOUT');

  /// Build or step was canceled by a user.
  static const BuildEventData_Status CANCELLED =
      BuildEventData_Status._(7, _omitEnumNames ? '' : 'CANCELLED');

  /// Build was enqueued for longer than the value of `queue_ttl`.
  static const BuildEventData_Status EXPIRED =
      BuildEventData_Status._(9, _omitEnumNames ? '' : 'EXPIRED');

  static const $core.List<BuildEventData_Status> values =
      <BuildEventData_Status>[
    STATUS_UNKNOWN,
    QUEUED,
    WORKING,
    SUCCESS,
    FAILURE,
    INTERNAL_ERROR,
    TIMEOUT,
    CANCELLED,
    EXPIRED,
  ];

  static final $core.List<BuildEventData_Status?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 9);
  static BuildEventData_Status? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BuildEventData_Status._(super.value, super.name);
}

/// Specifies the hash algorithm, if any.
class Hash_HashType extends $pb.ProtobufEnum {
  /// No hash requested.
  static const Hash_HashType NONE =
      Hash_HashType._(0, _omitEnumNames ? '' : 'NONE');

  /// Use a sha256 hash.
  static const Hash_HashType SHA256 =
      Hash_HashType._(1, _omitEnumNames ? '' : 'SHA256');

  /// Use a md5 hash.
  static const Hash_HashType MD5 =
      Hash_HashType._(2, _omitEnumNames ? '' : 'MD5');

  static const $core.List<Hash_HashType> values = <Hash_HashType>[
    NONE,
    SHA256,
    MD5,
  ];

  static final $core.List<Hash_HashType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static Hash_HashType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Hash_HashType._(super.value, super.name);
}

/// Specifies the manner in which the build should be verified, if at all.
class BuildOptions_VerifyOption extends $pb.ProtobufEnum {
  /// Not a verifiable build. (default)
  static const BuildOptions_VerifyOption NOT_VERIFIED =
      BuildOptions_VerifyOption._(0, _omitEnumNames ? '' : 'NOT_VERIFIED');

  /// Verified build.
  static const BuildOptions_VerifyOption VERIFIED =
      BuildOptions_VerifyOption._(1, _omitEnumNames ? '' : 'VERIFIED');

  static const $core.List<BuildOptions_VerifyOption> values =
      <BuildOptions_VerifyOption>[
    NOT_VERIFIED,
    VERIFIED,
  ];

  static final $core.List<BuildOptions_VerifyOption?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static BuildOptions_VerifyOption? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BuildOptions_VerifyOption._(super.value, super.name);
}

/// Supported VM sizes.
class BuildOptions_MachineType extends $pb.ProtobufEnum {
  /// Standard machine type.
  static const BuildOptions_MachineType UNSPECIFIED =
      BuildOptions_MachineType._(0, _omitEnumNames ? '' : 'UNSPECIFIED');

  /// Highcpu machine with 8 CPUs.
  static const BuildOptions_MachineType N1_HIGHCPU_8 =
      BuildOptions_MachineType._(1, _omitEnumNames ? '' : 'N1_HIGHCPU_8');

  /// Highcpu machine with 32 CPUs.
  static const BuildOptions_MachineType N1_HIGHCPU_32 =
      BuildOptions_MachineType._(2, _omitEnumNames ? '' : 'N1_HIGHCPU_32');

  static const $core.List<BuildOptions_MachineType> values =
      <BuildOptions_MachineType>[
    UNSPECIFIED,
    N1_HIGHCPU_8,
    N1_HIGHCPU_32,
  ];

  static final $core.List<BuildOptions_MachineType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static BuildOptions_MachineType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BuildOptions_MachineType._(super.value, super.name);
}

/// Specifies the behavior when there is an error in the substitution checks.
class BuildOptions_SubstitutionOption extends $pb.ProtobufEnum {
  /// Fails the build if error in substitutions checks, like missing
  /// a substitution in the template or in the map.
  static const BuildOptions_SubstitutionOption MUST_MATCH =
      BuildOptions_SubstitutionOption._(0, _omitEnumNames ? '' : 'MUST_MATCH');

  /// Do not fail the build if error in substitutions checks.
  static const BuildOptions_SubstitutionOption ALLOW_LOOSE =
      BuildOptions_SubstitutionOption._(1, _omitEnumNames ? '' : 'ALLOW_LOOSE');

  static const $core.List<BuildOptions_SubstitutionOption> values =
      <BuildOptions_SubstitutionOption>[
    MUST_MATCH,
    ALLOW_LOOSE,
  ];

  static final $core.List<BuildOptions_SubstitutionOption?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static BuildOptions_SubstitutionOption? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BuildOptions_SubstitutionOption._(super.value, super.name);
}

/// Specifies the behavior when writing build logs to Google Cloud Storage.
class BuildOptions_LogStreamingOption extends $pb.ProtobufEnum {
  /// Service may automatically determine build log streaming behavior.
  static const BuildOptions_LogStreamingOption STREAM_DEFAULT =
      BuildOptions_LogStreamingOption._(
          0, _omitEnumNames ? '' : 'STREAM_DEFAULT');

  /// Build logs should be streamed to Google Cloud Storage.
  static const BuildOptions_LogStreamingOption STREAM_ON =
      BuildOptions_LogStreamingOption._(1, _omitEnumNames ? '' : 'STREAM_ON');

  /// Build logs should not be streamed to Google Cloud Storage; they will be
  /// written when the build is completed.
  static const BuildOptions_LogStreamingOption STREAM_OFF =
      BuildOptions_LogStreamingOption._(2, _omitEnumNames ? '' : 'STREAM_OFF');

  static const $core.List<BuildOptions_LogStreamingOption> values =
      <BuildOptions_LogStreamingOption>[
    STREAM_DEFAULT,
    STREAM_ON,
    STREAM_OFF,
  ];

  static final $core.List<BuildOptions_LogStreamingOption?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static BuildOptions_LogStreamingOption? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BuildOptions_LogStreamingOption._(super.value, super.name);
}

/// Specifies the logging mode.
class BuildOptions_LoggingMode extends $pb.ProtobufEnum {
  /// The service determines the logging mode. The default is `LEGACY`. Do not
  /// rely on the default logging behavior as it may change in the future.
  static const BuildOptions_LoggingMode LOGGING_UNSPECIFIED =
      BuildOptions_LoggingMode._(
          0, _omitEnumNames ? '' : 'LOGGING_UNSPECIFIED');

  /// Stackdriver logging and Cloud Storage logging are enabled.
  static const BuildOptions_LoggingMode LEGACY =
      BuildOptions_LoggingMode._(1, _omitEnumNames ? '' : 'LEGACY');

  /// Only Cloud Storage logging is enabled.
  static const BuildOptions_LoggingMode GCS_ONLY =
      BuildOptions_LoggingMode._(2, _omitEnumNames ? '' : 'GCS_ONLY');

  static const $core.List<BuildOptions_LoggingMode> values =
      <BuildOptions_LoggingMode>[
    LOGGING_UNSPECIFIED,
    LEGACY,
    GCS_ONLY,
  ];

  static final $core.List<BuildOptions_LoggingMode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static BuildOptions_LoggingMode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BuildOptions_LoggingMode._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
