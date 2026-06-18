// This is a generated file - do not edit.
//
// Generated from google/events/firebase/remoteconfig/v1/data.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// What type of update was associated with the Remote Config template version.
class RemoteConfigUpdateOrigin extends $pb.ProtobufEnum {
  /// Catch-all for unrecognized values.
  static const RemoteConfigUpdateOrigin
      REMOTE_CONFIG_UPDATE_ORIGIN_UNSPECIFIED = RemoteConfigUpdateOrigin._(
          0, _omitEnumNames ? '' : 'REMOTE_CONFIG_UPDATE_ORIGIN_UNSPECIFIED');

  /// The update came from the Firebase UI.
  static const RemoteConfigUpdateOrigin CONSOLE =
      RemoteConfigUpdateOrigin._(1, _omitEnumNames ? '' : 'CONSOLE');

  /// The update came from the Remote Config REST API.
  static const RemoteConfigUpdateOrigin REST_API =
      RemoteConfigUpdateOrigin._(2, _omitEnumNames ? '' : 'REST_API');

  /// The update came from the Firebase Admin Node SDK.
  static const RemoteConfigUpdateOrigin ADMIN_SDK_NODE =
      RemoteConfigUpdateOrigin._(3, _omitEnumNames ? '' : 'ADMIN_SDK_NODE');

  static const $core.List<RemoteConfigUpdateOrigin> values =
      <RemoteConfigUpdateOrigin>[
    REMOTE_CONFIG_UPDATE_ORIGIN_UNSPECIFIED,
    CONSOLE,
    REST_API,
    ADMIN_SDK_NODE,
  ];

  static final $core.List<RemoteConfigUpdateOrigin?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static RemoteConfigUpdateOrigin? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RemoteConfigUpdateOrigin._(super.value, super.name);
}

/// Where the Remote Config update action originated.
class RemoteConfigUpdateType extends $pb.ProtobufEnum {
  /// Catch-all for unrecognized enum values.
  static const RemoteConfigUpdateType REMOTE_CONFIG_UPDATE_TYPE_UNSPECIFIED =
      RemoteConfigUpdateType._(
          0, _omitEnumNames ? '' : 'REMOTE_CONFIG_UPDATE_TYPE_UNSPECIFIED');

  /// A regular incremental update.
  static const RemoteConfigUpdateType INCREMENTAL_UPDATE =
      RemoteConfigUpdateType._(1, _omitEnumNames ? '' : 'INCREMENTAL_UPDATE');

  /// A forced update.
  /// The ETag was specified as "*" in an UpdateRemoteConfigRequest
  /// request or the "Force Update" button was pressed on the console.
  static const RemoteConfigUpdateType FORCED_UPDATE =
      RemoteConfigUpdateType._(2, _omitEnumNames ? '' : 'FORCED_UPDATE');

  /// A rollback to a previous Remote Config template.
  static const RemoteConfigUpdateType ROLLBACK =
      RemoteConfigUpdateType._(3, _omitEnumNames ? '' : 'ROLLBACK');

  static const $core.List<RemoteConfigUpdateType> values =
      <RemoteConfigUpdateType>[
    REMOTE_CONFIG_UPDATE_TYPE_UNSPECIFIED,
    INCREMENTAL_UPDATE,
    FORCED_UPDATE,
    ROLLBACK,
  ];

  static final $core.List<RemoteConfigUpdateType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static RemoteConfigUpdateType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RemoteConfigUpdateType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
