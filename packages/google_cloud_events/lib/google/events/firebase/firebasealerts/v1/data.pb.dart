// This is a generated file - do not edit.
//
// Generated from google/events/firebase/firebasealerts/v1/data.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/struct.pb.dart' as $1;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// The data within all Firebase Alerts.
class AlertData extends $pb.GeneratedMessage {
  factory AlertData({
    $0.Timestamp? createTime,
    $0.Timestamp? endTime,
    $1.Struct? payload,
  }) {
    final result = create();
    if (createTime != null) result.createTime = createTime;
    if (endTime != null) result.endTime = endTime;
    if (payload != null) result.payload = payload;
    return result;
  }

  AlertData._();

  factory AlertData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AlertData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AlertData',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.firebase.firebasealerts.v1'),
      createEmptyInstance: create)
    ..aOM<$0.Timestamp>(1, _omitFieldNames ? '' : 'createTime',
        subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(2, _omitFieldNames ? '' : 'endTime',
        subBuilder: $0.Timestamp.create)
    ..aOM<$1.Struct>(3, _omitFieldNames ? '' : 'payload',
        subBuilder: $1.Struct.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AlertData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AlertData copyWith(void Function(AlertData) updates) =>
      super.copyWith((message) => updates(message as AlertData)) as AlertData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AlertData create() => AlertData._();
  @$core.override
  AlertData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AlertData getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AlertData>(create);
  static AlertData? _defaultInstance;

  /// Time that the event has created
  @$pb.TagNumber(1)
  $0.Timestamp get createTime => $_getN(0);
  @$pb.TagNumber(1)
  set createTime($0.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCreateTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearCreateTime() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Timestamp ensureCreateTime() => $_ensure(0);

  /// Time that the event has ended. Optional, only present for alertsthat are
  /// ongoing
  @$pb.TagNumber(2)
  $0.Timestamp get endTime => $_getN(1);
  @$pb.TagNumber(2)
  set endTime($0.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEndTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndTime() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensureEndTime() => $_ensure(1);

  /// Payload of the event, which includes the details of the specific alert.
  /// It's a map of keys of String type and values of various types
  @$pb.TagNumber(3)
  $1.Struct get payload => $_getN(2);
  @$pb.TagNumber(3)
  set payload($1.Struct value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPayload() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayload() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Struct ensurePayload() => $_ensure(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
