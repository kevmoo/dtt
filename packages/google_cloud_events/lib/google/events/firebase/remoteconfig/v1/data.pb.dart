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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $0;

import 'data.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'data.pbenum.dart';

/// The data within all Firebase Remote Config events.
class RemoteConfigEventData extends $pb.GeneratedMessage {
  factory RemoteConfigEventData({
    $fixnum.Int64? versionNumber,
    $0.Timestamp? updateTime,
    RemoteConfigUser? updateUser,
    $core.String? description,
    RemoteConfigUpdateOrigin? updateOrigin,
    RemoteConfigUpdateType? updateType,
    $fixnum.Int64? rollbackSource,
  }) {
    final result = create();
    if (versionNumber != null) result.versionNumber = versionNumber;
    if (updateTime != null) result.updateTime = updateTime;
    if (updateUser != null) result.updateUser = updateUser;
    if (description != null) result.description = description;
    if (updateOrigin != null) result.updateOrigin = updateOrigin;
    if (updateType != null) result.updateType = updateType;
    if (rollbackSource != null) result.rollbackSource = rollbackSource;
    return result;
  }

  RemoteConfigEventData._();

  factory RemoteConfigEventData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoteConfigEventData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoteConfigEventData',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.firebase.remoteconfig.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'versionNumber')
    ..aOM<$0.Timestamp>(2, _omitFieldNames ? '' : 'updateTime',
        subBuilder: $0.Timestamp.create)
    ..aOM<RemoteConfigUser>(3, _omitFieldNames ? '' : 'updateUser',
        subBuilder: RemoteConfigUser.create)
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aE<RemoteConfigUpdateOrigin>(5, _omitFieldNames ? '' : 'updateOrigin',
        enumValues: RemoteConfigUpdateOrigin.values)
    ..aE<RemoteConfigUpdateType>(6, _omitFieldNames ? '' : 'updateType',
        enumValues: RemoteConfigUpdateType.values)
    ..aInt64(7, _omitFieldNames ? '' : 'rollbackSource')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoteConfigEventData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoteConfigEventData copyWith(
          void Function(RemoteConfigEventData) updates) =>
      super.copyWith((message) => updates(message as RemoteConfigEventData))
          as RemoteConfigEventData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoteConfigEventData create() => RemoteConfigEventData._();
  @$core.override
  RemoteConfigEventData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RemoteConfigEventData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoteConfigEventData>(create);
  static RemoteConfigEventData? _defaultInstance;

  /// The version number of the version's corresponding Remote Config template.
  @$pb.TagNumber(1)
  $fixnum.Int64 get versionNumber => $_getI64(0);
  @$pb.TagNumber(1)
  set versionNumber($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersionNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersionNumber() => $_clearField(1);

  /// When the Remote Config template was written to the Remote Config server.
  @$pb.TagNumber(2)
  $0.Timestamp get updateTime => $_getN(1);
  @$pb.TagNumber(2)
  set updateTime($0.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUpdateTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateTime() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensureUpdateTime() => $_ensure(1);

  /// Aggregation of all metadata fields about the account that performed the
  /// update.
  @$pb.TagNumber(3)
  RemoteConfigUser get updateUser => $_getN(2);
  @$pb.TagNumber(3)
  set updateUser(RemoteConfigUser value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasUpdateUser() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdateUser() => $_clearField(3);
  @$pb.TagNumber(3)
  RemoteConfigUser ensureUpdateUser() => $_ensure(2);

  /// The user-provided description of the corresponding Remote Config template.
  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  /// Where the update action originated.
  @$pb.TagNumber(5)
  RemoteConfigUpdateOrigin get updateOrigin => $_getN(4);
  @$pb.TagNumber(5)
  set updateOrigin(RemoteConfigUpdateOrigin value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasUpdateOrigin() => $_has(4);
  @$pb.TagNumber(5)
  void clearUpdateOrigin() => $_clearField(5);

  /// What type of update was made.
  @$pb.TagNumber(6)
  RemoteConfigUpdateType get updateType => $_getN(5);
  @$pb.TagNumber(6)
  set updateType(RemoteConfigUpdateType value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasUpdateType() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdateType() => $_clearField(6);

  /// Only present if this version is the result of a rollback, and will be the
  /// version number of the Remote Config template that was rolled-back to.
  @$pb.TagNumber(7)
  $fixnum.Int64 get rollbackSource => $_getI64(6);
  @$pb.TagNumber(7)
  set rollbackSource($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRollbackSource() => $_has(6);
  @$pb.TagNumber(7)
  void clearRollbackSource() => $_clearField(7);
}

/// All the fields associated with the person/service account
/// that wrote a Remote Config template.
class RemoteConfigUser extends $pb.GeneratedMessage {
  factory RemoteConfigUser({
    $core.String? name,
    $core.String? email,
    $core.String? imageUrl,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (email != null) result.email = email;
    if (imageUrl != null) result.imageUrl = imageUrl;
    return result;
  }

  RemoteConfigUser._();

  factory RemoteConfigUser.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoteConfigUser.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoteConfigUser',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.firebase.remoteconfig.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'imageUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoteConfigUser clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoteConfigUser copyWith(void Function(RemoteConfigUser) updates) =>
      super.copyWith((message) => updates(message as RemoteConfigUser))
          as RemoteConfigUser;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoteConfigUser create() => RemoteConfigUser._();
  @$core.override
  RemoteConfigUser createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RemoteConfigUser getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoteConfigUser>(create);
  static RemoteConfigUser? _defaultInstance;

  /// Display name.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// Email address.
  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  /// Image URL.
  @$pb.TagNumber(3)
  $core.String get imageUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set imageUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasImageUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearImageUrl() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
