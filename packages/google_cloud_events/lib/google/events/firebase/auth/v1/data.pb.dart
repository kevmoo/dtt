// This is a generated file - do not edit.
//
// Generated from google/events/firebase/auth/v1/data.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/struct.pb.dart' as $0;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// The data within all Firebase Auth events.
class AuthEventData extends $pb.GeneratedMessage {
  factory AuthEventData({
    $core.String? uid,
    $core.String? email,
    $core.bool? emailVerified,
    $core.String? displayName,
    $core.String? photoURL,
    $core.bool? disabled,
    UserMetadata? metadata,
    $core.Iterable<UserInfo>? providerData,
    $core.String? phoneNumber,
    $0.Struct? customClaims,
  }) {
    final result = create();
    if (uid != null) result.uid = uid;
    if (email != null) result.email = email;
    if (emailVerified != null) result.emailVerified = emailVerified;
    if (displayName != null) result.displayName = displayName;
    if (photoURL != null) result.photoURL = photoURL;
    if (disabled != null) result.disabled = disabled;
    if (metadata != null) result.metadata = metadata;
    if (providerData != null) result.providerData.addAll(providerData);
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (customClaims != null) result.customClaims = customClaims;
    return result;
  }

  AuthEventData._();

  factory AuthEventData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AuthEventData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthEventData',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.firebase.auth.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'uid')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOB(3, _omitFieldNames ? '' : 'emailVerified')
    ..aOS(4, _omitFieldNames ? '' : 'displayName')
    ..aOS(5, _omitFieldNames ? '' : 'photoURL', protoName: 'photo_URL')
    ..aOB(6, _omitFieldNames ? '' : 'disabled')
    ..aOM<UserMetadata>(7, _omitFieldNames ? '' : 'metadata',
        subBuilder: UserMetadata.create)
    ..pPM<UserInfo>(8, _omitFieldNames ? '' : 'providerData',
        subBuilder: UserInfo.create)
    ..aOS(9, _omitFieldNames ? '' : 'phoneNumber')
    ..aOM<$0.Struct>(10, _omitFieldNames ? '' : 'customClaims',
        subBuilder: $0.Struct.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthEventData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthEventData copyWith(void Function(AuthEventData) updates) =>
      super.copyWith((message) => updates(message as AuthEventData))
          as AuthEventData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthEventData create() => AuthEventData._();
  @$core.override
  AuthEventData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AuthEventData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuthEventData>(create);
  static AuthEventData? _defaultInstance;

  /// The user identifier in the Firebase app.
  @$pb.TagNumber(1)
  $core.String get uid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUid() => $_clearField(1);

  /// The user's primary email, if set.
  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  /// Whether or not the user's primary email is verified.
  @$pb.TagNumber(3)
  $core.bool get emailVerified => $_getBF(2);
  @$pb.TagNumber(3)
  set emailVerified($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEmailVerified() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmailVerified() => $_clearField(3);

  /// The user's display name.
  @$pb.TagNumber(4)
  $core.String get displayName => $_getSZ(3);
  @$pb.TagNumber(4)
  set displayName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDisplayName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisplayName() => $_clearField(4);

  /// The user's photo URL.
  @$pb.TagNumber(5)
  $core.String get photoURL => $_getSZ(4);
  @$pb.TagNumber(5)
  set photoURL($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPhotoURL() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhotoURL() => $_clearField(5);

  /// Whether the user is disabled.
  @$pb.TagNumber(6)
  $core.bool get disabled => $_getBF(5);
  @$pb.TagNumber(6)
  set disabled($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDisabled() => $_has(5);
  @$pb.TagNumber(6)
  void clearDisabled() => $_clearField(6);

  /// Additional metadata about the user.
  @$pb.TagNumber(7)
  UserMetadata get metadata => $_getN(6);
  @$pb.TagNumber(7)
  set metadata(UserMetadata value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasMetadata() => $_has(6);
  @$pb.TagNumber(7)
  void clearMetadata() => $_clearField(7);
  @$pb.TagNumber(7)
  UserMetadata ensureMetadata() => $_ensure(6);

  /// User's info at the providers
  @$pb.TagNumber(8)
  $pb.PbList<UserInfo> get providerData => $_getList(7);

  /// The user's phone number.
  @$pb.TagNumber(9)
  $core.String get phoneNumber => $_getSZ(8);
  @$pb.TagNumber(9)
  set phoneNumber($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPhoneNumber() => $_has(8);
  @$pb.TagNumber(9)
  void clearPhoneNumber() => $_clearField(9);

  /// User's custom claims, typically used to define user roles and propagated
  /// to an authenticated user's ID token.
  @$pb.TagNumber(10)
  $0.Struct get customClaims => $_getN(9);
  @$pb.TagNumber(10)
  set customClaims($0.Struct value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasCustomClaims() => $_has(9);
  @$pb.TagNumber(10)
  void clearCustomClaims() => $_clearField(10);
  @$pb.TagNumber(10)
  $0.Struct ensureCustomClaims() => $_ensure(9);
}

/// Additional metadata about the user.
class UserMetadata extends $pb.GeneratedMessage {
  factory UserMetadata({
    $1.Timestamp? createTime,
    $1.Timestamp? lastSignInTime,
  }) {
    final result = create();
    if (createTime != null) result.createTime = createTime;
    if (lastSignInTime != null) result.lastSignInTime = lastSignInTime;
    return result;
  }

  UserMetadata._();

  factory UserMetadata.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserMetadata.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserMetadata',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.firebase.auth.v1'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'createTime',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'lastSignInTime',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserMetadata clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserMetadata copyWith(void Function(UserMetadata) updates) =>
      super.copyWith((message) => updates(message as UserMetadata))
          as UserMetadata;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserMetadata create() => UserMetadata._();
  @$core.override
  UserMetadata createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserMetadata>(create);
  static UserMetadata? _defaultInstance;

  /// The date the user was created.
  @$pb.TagNumber(1)
  $1.Timestamp get createTime => $_getN(0);
  @$pb.TagNumber(1)
  set createTime($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCreateTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearCreateTime() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureCreateTime() => $_ensure(0);

  /// The date the user last signed in.
  @$pb.TagNumber(2)
  $1.Timestamp get lastSignInTime => $_getN(1);
  @$pb.TagNumber(2)
  set lastSignInTime($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasLastSignInTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastSignInTime() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureLastSignInTime() => $_ensure(1);
}

/// User's info at the identity provider
class UserInfo extends $pb.GeneratedMessage {
  factory UserInfo({
    $core.String? uid,
    $core.String? email,
    $core.String? displayName,
    $core.String? photoURL,
    $core.String? providerId,
  }) {
    final result = create();
    if (uid != null) result.uid = uid;
    if (email != null) result.email = email;
    if (displayName != null) result.displayName = displayName;
    if (photoURL != null) result.photoURL = photoURL;
    if (providerId != null) result.providerId = providerId;
    return result;
  }

  UserInfo._();

  factory UserInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.firebase.auth.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'uid')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..aOS(4, _omitFieldNames ? '' : 'photoURL', protoName: 'photo_URL')
    ..aOS(5, _omitFieldNames ? '' : 'providerId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserInfo copyWith(void Function(UserInfo) updates) =>
      super.copyWith((message) => updates(message as UserInfo)) as UserInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserInfo create() => UserInfo._();
  @$core.override
  UserInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserInfo>(create);
  static UserInfo? _defaultInstance;

  /// The user identifier for the linked provider.
  @$pb.TagNumber(1)
  $core.String get uid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUid() => $_clearField(1);

  /// The email for the linked provider.
  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  /// The display name for the linked provider.
  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => $_clearField(3);

  /// The photo URL for the linked provider.
  @$pb.TagNumber(4)
  $core.String get photoURL => $_getSZ(3);
  @$pb.TagNumber(4)
  set photoURL($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPhotoURL() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhotoURL() => $_clearField(4);

  /// The linked provider ID (e.g. "google.com" for the Google provider).
  @$pb.TagNumber(5)
  $core.String get providerId => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProviderId() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderId() => $_clearField(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
