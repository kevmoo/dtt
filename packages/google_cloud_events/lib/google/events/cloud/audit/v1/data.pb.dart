// This is a generated file - do not edit.
//
// Generated from google/events/cloud/audit/v1/data.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/struct.pb.dart' as $3;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $1;

import '../../../../api/monitored_resource.pb.dart' as $0;
import '../../../../rpc/context/attribute_context.pb.dart' as $4;
import '../../../../rpc/status.pb.dart' as $2;
import 'data.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'data.pbenum.dart';

/// The data within all Cloud Audit Logs log entry events.
class LogEntryData extends $pb.GeneratedMessage {
  factory LogEntryData({
    AuditLog? protoPayload,
    $core.String? insertId,
    $0.MonitoredResource? resource,
    $1.Timestamp? timestamp,
    LogSeverity? severity,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? labels,
    $core.String? logName,
    LogEntryOperation? operation,
    $core.String? trace,
    $1.Timestamp? receiveTimestamp,
    $core.String? spanId,
    LogSplit? split,
  }) {
    final result = create();
    if (protoPayload != null) result.protoPayload = protoPayload;
    if (insertId != null) result.insertId = insertId;
    if (resource != null) result.resource = resource;
    if (timestamp != null) result.timestamp = timestamp;
    if (severity != null) result.severity = severity;
    if (labels != null) result.labels.addEntries(labels);
    if (logName != null) result.logName = logName;
    if (operation != null) result.operation = operation;
    if (trace != null) result.trace = trace;
    if (receiveTimestamp != null) result.receiveTimestamp = receiveTimestamp;
    if (spanId != null) result.spanId = spanId;
    if (split != null) result.split = split;
    return result;
  }

  LogEntryData._();

  factory LogEntryData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LogEntryData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogEntryData',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.audit.v1'),
      createEmptyInstance: create)
    ..aOM<AuditLog>(2, _omitFieldNames ? '' : 'protoPayload',
        subBuilder: AuditLog.create)
    ..aOS(4, _omitFieldNames ? '' : 'insertId')
    ..aOM<$0.MonitoredResource>(8, _omitFieldNames ? '' : 'resource',
        subBuilder: $0.MonitoredResource.create)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'timestamp',
        subBuilder: $1.Timestamp.create)
    ..aE<LogSeverity>(10, _omitFieldNames ? '' : 'severity',
        enumValues: LogSeverity.values)
    ..m<$core.String, $core.String>(11, _omitFieldNames ? '' : 'labels',
        entryClassName: 'LogEntryData.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.events.cloud.audit.v1'))
    ..aOS(12, _omitFieldNames ? '' : 'logName')
    ..aOM<LogEntryOperation>(15, _omitFieldNames ? '' : 'operation',
        subBuilder: LogEntryOperation.create)
    ..aOS(22, _omitFieldNames ? '' : 'trace')
    ..aOM<$1.Timestamp>(24, _omitFieldNames ? '' : 'receiveTimestamp',
        subBuilder: $1.Timestamp.create)
    ..aOS(27, _omitFieldNames ? '' : 'spanId')
    ..aOM<LogSplit>(35, _omitFieldNames ? '' : 'split',
        subBuilder: LogSplit.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogEntryData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogEntryData copyWith(void Function(LogEntryData) updates) =>
      super.copyWith((message) => updates(message as LogEntryData))
          as LogEntryData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogEntryData create() => LogEntryData._();
  @$core.override
  LogEntryData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LogEntryData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogEntryData>(create);
  static LogEntryData? _defaultInstance;

  /// The log entry payload, which is always an AuditLog for Cloud Audit Log
  /// events.
  @$pb.TagNumber(2)
  AuditLog get protoPayload => $_getN(0);
  @$pb.TagNumber(2)
  set protoPayload(AuditLog value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasProtoPayload() => $_has(0);
  @$pb.TagNumber(2)
  void clearProtoPayload() => $_clearField(2);
  @$pb.TagNumber(2)
  AuditLog ensureProtoPayload() => $_ensure(0);

  /// A unique identifier for the log entry.
  @$pb.TagNumber(4)
  $core.String get insertId => $_getSZ(1);
  @$pb.TagNumber(4)
  set insertId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(4)
  $core.bool hasInsertId() => $_has(1);
  @$pb.TagNumber(4)
  void clearInsertId() => $_clearField(4);

  /// The monitored resource that produced this log entry.
  ///
  /// Example: a log entry that reports a database error would be associated with
  /// the monitored resource designating the particular database that reported
  /// the error.
  @$pb.TagNumber(8)
  $0.MonitoredResource get resource => $_getN(2);
  @$pb.TagNumber(8)
  set resource($0.MonitoredResource value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasResource() => $_has(2);
  @$pb.TagNumber(8)
  void clearResource() => $_clearField(8);
  @$pb.TagNumber(8)
  $0.MonitoredResource ensureResource() => $_ensure(2);

  /// The time the event described by the log entry occurred.
  @$pb.TagNumber(9)
  $1.Timestamp get timestamp => $_getN(3);
  @$pb.TagNumber(9)
  set timestamp($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(9)
  void clearTimestamp() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureTimestamp() => $_ensure(3);

  /// The severity of the log entry.
  @$pb.TagNumber(10)
  LogSeverity get severity => $_getN(4);
  @$pb.TagNumber(10)
  set severity(LogSeverity value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasSeverity() => $_has(4);
  @$pb.TagNumber(10)
  void clearSeverity() => $_clearField(10);

  /// A set of user-defined (key, value) data that provides additional
  /// information about the log entry.
  @$pb.TagNumber(11)
  $pb.PbMap<$core.String, $core.String> get labels => $_getMap(5);

  /// The resource name of the log to which this log entry belongs.
  @$pb.TagNumber(12)
  $core.String get logName => $_getSZ(6);
  @$pb.TagNumber(12)
  set logName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(12)
  $core.bool hasLogName() => $_has(6);
  @$pb.TagNumber(12)
  void clearLogName() => $_clearField(12);

  /// Information about an operation associated with the log entry, if
  /// applicable.
  @$pb.TagNumber(15)
  LogEntryOperation get operation => $_getN(7);
  @$pb.TagNumber(15)
  set operation(LogEntryOperation value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasOperation() => $_has(7);
  @$pb.TagNumber(15)
  void clearOperation() => $_clearField(15);
  @$pb.TagNumber(15)
  LogEntryOperation ensureOperation() => $_ensure(7);

  /// Resource name of the trace associated with the log entry, if any. If it
  /// contains a relative resource name, the name is assumed to be relative to
  /// `//tracing.googleapis.com`. Example:
  /// `projects/my-projectid/traces/06796866738c859f2f19b7cfb3214824`
  @$pb.TagNumber(22)
  $core.String get trace => $_getSZ(8);
  @$pb.TagNumber(22)
  set trace($core.String value) => $_setString(8, value);
  @$pb.TagNumber(22)
  $core.bool hasTrace() => $_has(8);
  @$pb.TagNumber(22)
  void clearTrace() => $_clearField(22);

  /// The time the log entry was received by Logging.
  @$pb.TagNumber(24)
  $1.Timestamp get receiveTimestamp => $_getN(9);
  @$pb.TagNumber(24)
  set receiveTimestamp($1.Timestamp value) => $_setField(24, value);
  @$pb.TagNumber(24)
  $core.bool hasReceiveTimestamp() => $_has(9);
  @$pb.TagNumber(24)
  void clearReceiveTimestamp() => $_clearField(24);
  @$pb.TagNumber(24)
  $1.Timestamp ensureReceiveTimestamp() => $_ensure(9);

  /// The span ID within the trace associated with the log entry, if any.
  ///
  /// For Trace spans, this is the same format that the Trace API v2 uses: a
  /// 16-character hexadecimal encoding of an 8-byte array, such as
  /// `000000000000004a`.
  @$pb.TagNumber(27)
  $core.String get spanId => $_getSZ(10);
  @$pb.TagNumber(27)
  set spanId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(27)
  $core.bool hasSpanId() => $_has(10);
  @$pb.TagNumber(27)
  void clearSpanId() => $_clearField(27);

  /// Information indicating this LogEntry is part of a sequence of multiple logs
  /// split from a single LogEntry.
  @$pb.TagNumber(35)
  LogSplit get split => $_getN(11);
  @$pb.TagNumber(35)
  set split(LogSplit value) => $_setField(35, value);
  @$pb.TagNumber(35)
  $core.bool hasSplit() => $_has(11);
  @$pb.TagNumber(35)
  void clearSplit() => $_clearField(35);
  @$pb.TagNumber(35)
  LogSplit ensureSplit() => $_ensure(11);
}

/// Additional information about a potentially long-running operation with which
/// a log entry is associated.
class LogEntryOperation extends $pb.GeneratedMessage {
  factory LogEntryOperation({
    $core.String? id,
    $core.String? producer,
    $core.bool? first,
    $core.bool? last,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (producer != null) result.producer = producer;
    if (first != null) result.first = first;
    if (last != null) result.last = last;
    return result;
  }

  LogEntryOperation._();

  factory LogEntryOperation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LogEntryOperation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogEntryOperation',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.audit.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'producer')
    ..aOB(3, _omitFieldNames ? '' : 'first')
    ..aOB(4, _omitFieldNames ? '' : 'last')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogEntryOperation clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogEntryOperation copyWith(void Function(LogEntryOperation) updates) =>
      super.copyWith((message) => updates(message as LogEntryOperation))
          as LogEntryOperation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogEntryOperation create() => LogEntryOperation._();
  @$core.override
  LogEntryOperation createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LogEntryOperation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogEntryOperation>(create);
  static LogEntryOperation? _defaultInstance;

  /// An arbitrary operation identifier. Log entries with the same
  /// identifier are assumed to be part of the same operation.
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// An arbitrary producer identifier. The combination of `id` and
  /// `producer` must be globally unique. Examples for `producer`:
  /// `"MyDivision.MyBigCompany.com"`, `"github.com/MyProject/MyApplication"`.
  @$pb.TagNumber(2)
  $core.String get producer => $_getSZ(1);
  @$pb.TagNumber(2)
  set producer($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProducer() => $_has(1);
  @$pb.TagNumber(2)
  void clearProducer() => $_clearField(2);

  /// True if this is the first log entry in the operation.
  @$pb.TagNumber(3)
  $core.bool get first => $_getBF(2);
  @$pb.TagNumber(3)
  set first($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFirst() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirst() => $_clearField(3);

  /// True if this is the last log entry in the operation.
  @$pb.TagNumber(4)
  $core.bool get last => $_getBF(3);
  @$pb.TagNumber(4)
  set last($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLast() => $_has(3);
  @$pb.TagNumber(4)
  void clearLast() => $_clearField(4);
}

/// Common audit log format for Google Cloud Platform API operations.
/// Copied from
/// https://github.com/googleapis/googleapis/blob/master/google/cloud/audit/audit_log.proto,
/// but changing service_data from Any to Struct.
class AuditLog extends $pb.GeneratedMessage {
  factory AuditLog({
    $2.Status? status,
    AuthenticationInfo? authenticationInfo,
    RequestMetadata? requestMetadata,
    $core.String? serviceName,
    $core.String? methodName,
    $core.Iterable<AuthorizationInfo>? authorizationInfo,
    $core.String? resourceName,
    $fixnum.Int64? numResponseItems,
    $3.Struct? serviceData,
    $3.Struct? request,
    $3.Struct? response,
    $3.Struct? metadata,
    $3.Struct? resourceOriginalState,
    ResourceLocation? resourceLocation,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (authenticationInfo != null)
      result.authenticationInfo = authenticationInfo;
    if (requestMetadata != null) result.requestMetadata = requestMetadata;
    if (serviceName != null) result.serviceName = serviceName;
    if (methodName != null) result.methodName = methodName;
    if (authorizationInfo != null)
      result.authorizationInfo.addAll(authorizationInfo);
    if (resourceName != null) result.resourceName = resourceName;
    if (numResponseItems != null) result.numResponseItems = numResponseItems;
    if (serviceData != null) result.serviceData = serviceData;
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    if (metadata != null) result.metadata = metadata;
    if (resourceOriginalState != null)
      result.resourceOriginalState = resourceOriginalState;
    if (resourceLocation != null) result.resourceLocation = resourceLocation;
    return result;
  }

  AuditLog._();

  factory AuditLog.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AuditLog.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuditLog',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.audit.v1'),
      createEmptyInstance: create)
    ..aOM<$2.Status>(2, _omitFieldNames ? '' : 'status',
        subBuilder: $2.Status.create)
    ..aOM<AuthenticationInfo>(3, _omitFieldNames ? '' : 'authenticationInfo',
        subBuilder: AuthenticationInfo.create)
    ..aOM<RequestMetadata>(4, _omitFieldNames ? '' : 'requestMetadata',
        subBuilder: RequestMetadata.create)
    ..aOS(7, _omitFieldNames ? '' : 'serviceName')
    ..aOS(8, _omitFieldNames ? '' : 'methodName')
    ..pPM<AuthorizationInfo>(9, _omitFieldNames ? '' : 'authorizationInfo',
        subBuilder: AuthorizationInfo.create)
    ..aOS(11, _omitFieldNames ? '' : 'resourceName')
    ..aInt64(12, _omitFieldNames ? '' : 'numResponseItems')
    ..aOM<$3.Struct>(15, _omitFieldNames ? '' : 'serviceData',
        subBuilder: $3.Struct.create)
    ..aOM<$3.Struct>(16, _omitFieldNames ? '' : 'request',
        subBuilder: $3.Struct.create)
    ..aOM<$3.Struct>(17, _omitFieldNames ? '' : 'response',
        subBuilder: $3.Struct.create)
    ..aOM<$3.Struct>(18, _omitFieldNames ? '' : 'metadata',
        subBuilder: $3.Struct.create)
    ..aOM<$3.Struct>(19, _omitFieldNames ? '' : 'resourceOriginalState',
        subBuilder: $3.Struct.create)
    ..aOM<ResourceLocation>(20, _omitFieldNames ? '' : 'resourceLocation',
        subBuilder: ResourceLocation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuditLog clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuditLog copyWith(void Function(AuditLog) updates) =>
      super.copyWith((message) => updates(message as AuditLog)) as AuditLog;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuditLog create() => AuditLog._();
  @$core.override
  AuditLog createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AuditLog getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AuditLog>(create);
  static AuditLog? _defaultInstance;

  /// The status of the overall operation.
  @$pb.TagNumber(2)
  $2.Status get status => $_getN(0);
  @$pb.TagNumber(2)
  set status($2.Status value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.Status ensureStatus() => $_ensure(0);

  /// Authentication information.
  @$pb.TagNumber(3)
  AuthenticationInfo get authenticationInfo => $_getN(1);
  @$pb.TagNumber(3)
  set authenticationInfo(AuthenticationInfo value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthenticationInfo() => $_has(1);
  @$pb.TagNumber(3)
  void clearAuthenticationInfo() => $_clearField(3);
  @$pb.TagNumber(3)
  AuthenticationInfo ensureAuthenticationInfo() => $_ensure(1);

  /// Metadata about the operation.
  @$pb.TagNumber(4)
  RequestMetadata get requestMetadata => $_getN(2);
  @$pb.TagNumber(4)
  set requestMetadata(RequestMetadata value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasRequestMetadata() => $_has(2);
  @$pb.TagNumber(4)
  void clearRequestMetadata() => $_clearField(4);
  @$pb.TagNumber(4)
  RequestMetadata ensureRequestMetadata() => $_ensure(2);

  /// The name of the API service performing the operation. For example,
  /// `"datastore.googleapis.com"`.
  @$pb.TagNumber(7)
  $core.String get serviceName => $_getSZ(3);
  @$pb.TagNumber(7)
  set serviceName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(7)
  $core.bool hasServiceName() => $_has(3);
  @$pb.TagNumber(7)
  void clearServiceName() => $_clearField(7);

  /// The name of the service method or operation.
  /// For API calls, this should be the name of the API method.
  /// For example,
  ///
  ///     "google.datastore.v1.Datastore.RunQuery"
  ///     "google.logging.v1.LoggingService.DeleteLog"
  @$pb.TagNumber(8)
  $core.String get methodName => $_getSZ(4);
  @$pb.TagNumber(8)
  set methodName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(8)
  $core.bool hasMethodName() => $_has(4);
  @$pb.TagNumber(8)
  void clearMethodName() => $_clearField(8);

  /// Authorization information. If there are multiple
  /// resources or permissions involved, then there is
  /// one AuthorizationInfo element for each {resource, permission} tuple.
  @$pb.TagNumber(9)
  $pb.PbList<AuthorizationInfo> get authorizationInfo => $_getList(5);

  /// The resource or collection that is the target of the operation.
  /// The name is a scheme-less URI, not including the API service name.
  /// For example:
  ///
  ///     "shelves/SHELF_ID/books"
  ///     "shelves/SHELF_ID/books/BOOK_ID"
  @$pb.TagNumber(11)
  $core.String get resourceName => $_getSZ(6);
  @$pb.TagNumber(11)
  set resourceName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(11)
  $core.bool hasResourceName() => $_has(6);
  @$pb.TagNumber(11)
  void clearResourceName() => $_clearField(11);

  /// The number of items returned from a List or Query API method,
  /// if applicable.
  @$pb.TagNumber(12)
  $fixnum.Int64 get numResponseItems => $_getI64(7);
  @$pb.TagNumber(12)
  set numResponseItems($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(12)
  $core.bool hasNumResponseItems() => $_has(7);
  @$pb.TagNumber(12)
  void clearNumResponseItems() => $_clearField(12);

  /// Deprecated: Use `metadata` field instead.
  /// Other service-specific data about the request, response, and other
  /// activities.
  /// When the JSON object represented here has a proto equivalent, the proto
  /// name will be indicated in the `@type` property.
  @$pb.TagNumber(15)
  $3.Struct get serviceData => $_getN(8);
  @$pb.TagNumber(15)
  set serviceData($3.Struct value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasServiceData() => $_has(8);
  @$pb.TagNumber(15)
  void clearServiceData() => $_clearField(15);
  @$pb.TagNumber(15)
  $3.Struct ensureServiceData() => $_ensure(8);

  /// The operation request. This may not include all request parameters,
  /// such as those that are too large, privacy-sensitive, or duplicated
  /// elsewhere in the log record.
  /// It should never include user-generated data, such as file contents.
  /// When the JSON object represented here has a proto equivalent, the proto
  /// name will be indicated in the `@type` property.
  @$pb.TagNumber(16)
  $3.Struct get request => $_getN(9);
  @$pb.TagNumber(16)
  set request($3.Struct value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasRequest() => $_has(9);
  @$pb.TagNumber(16)
  void clearRequest() => $_clearField(16);
  @$pb.TagNumber(16)
  $3.Struct ensureRequest() => $_ensure(9);

  /// The operation response. This may not include all response elements,
  /// such as those that are too large, privacy-sensitive, or duplicated
  /// elsewhere in the log record.
  /// It should never include user-generated data, such as file contents.
  /// When the JSON object represented here has a proto equivalent, the proto
  /// name will be indicated in the `@type` property.
  @$pb.TagNumber(17)
  $3.Struct get response => $_getN(10);
  @$pb.TagNumber(17)
  set response($3.Struct value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasResponse() => $_has(10);
  @$pb.TagNumber(17)
  void clearResponse() => $_clearField(17);
  @$pb.TagNumber(17)
  $3.Struct ensureResponse() => $_ensure(10);

  /// Other service-specific data about the request, response, and other
  /// information associated with the current audited event.
  @$pb.TagNumber(18)
  $3.Struct get metadata => $_getN(11);
  @$pb.TagNumber(18)
  set metadata($3.Struct value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasMetadata() => $_has(11);
  @$pb.TagNumber(18)
  void clearMetadata() => $_clearField(18);
  @$pb.TagNumber(18)
  $3.Struct ensureMetadata() => $_ensure(11);

  /// The resource's original state before mutation. Present only for
  /// operations which have successfully modified the targeted resource(s).
  /// In general, this field should contain all changed fields, except those
  /// that are already been included in `request`, `response`, `metadata` or
  /// `service_data` fields.
  /// When the JSON object represented here has a proto equivalent,
  /// the proto name will be indicated in the `@type` property.
  @$pb.TagNumber(19)
  $3.Struct get resourceOriginalState => $_getN(12);
  @$pb.TagNumber(19)
  set resourceOriginalState($3.Struct value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasResourceOriginalState() => $_has(12);
  @$pb.TagNumber(19)
  void clearResourceOriginalState() => $_clearField(19);
  @$pb.TagNumber(19)
  $3.Struct ensureResourceOriginalState() => $_ensure(12);

  /// The resource location information.
  @$pb.TagNumber(20)
  ResourceLocation get resourceLocation => $_getN(13);
  @$pb.TagNumber(20)
  set resourceLocation(ResourceLocation value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasResourceLocation() => $_has(13);
  @$pb.TagNumber(20)
  void clearResourceLocation() => $_clearField(20);
  @$pb.TagNumber(20)
  ResourceLocation ensureResourceLocation() => $_ensure(13);
}

/// Authentication information for the operation.
class AuthenticationInfo extends $pb.GeneratedMessage {
  factory AuthenticationInfo({
    $core.String? principalEmail,
    $core.String? authoritySelector,
    $3.Struct? thirdPartyPrincipal,
    $core.String? serviceAccountKeyName,
    $core.Iterable<ServiceAccountDelegationInfo>? serviceAccountDelegationInfo,
    $core.String? principalSubject,
  }) {
    final result = create();
    if (principalEmail != null) result.principalEmail = principalEmail;
    if (authoritySelector != null) result.authoritySelector = authoritySelector;
    if (thirdPartyPrincipal != null)
      result.thirdPartyPrincipal = thirdPartyPrincipal;
    if (serviceAccountKeyName != null)
      result.serviceAccountKeyName = serviceAccountKeyName;
    if (serviceAccountDelegationInfo != null)
      result.serviceAccountDelegationInfo.addAll(serviceAccountDelegationInfo);
    if (principalSubject != null) result.principalSubject = principalSubject;
    return result;
  }

  AuthenticationInfo._();

  factory AuthenticationInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AuthenticationInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthenticationInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.audit.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'principalEmail')
    ..aOS(2, _omitFieldNames ? '' : 'authoritySelector')
    ..aOM<$3.Struct>(4, _omitFieldNames ? '' : 'thirdPartyPrincipal',
        subBuilder: $3.Struct.create)
    ..aOS(5, _omitFieldNames ? '' : 'serviceAccountKeyName')
    ..pPM<ServiceAccountDelegationInfo>(
        6, _omitFieldNames ? '' : 'serviceAccountDelegationInfo',
        subBuilder: ServiceAccountDelegationInfo.create)
    ..aOS(8, _omitFieldNames ? '' : 'principalSubject')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthenticationInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthenticationInfo copyWith(void Function(AuthenticationInfo) updates) =>
      super.copyWith((message) => updates(message as AuthenticationInfo))
          as AuthenticationInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthenticationInfo create() => AuthenticationInfo._();
  @$core.override
  AuthenticationInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AuthenticationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuthenticationInfo>(create);
  static AuthenticationInfo? _defaultInstance;

  /// The email address of the authenticated user (or service account on behalf
  /// of third party principal) making the request. For third party identity
  /// callers, the `principal_subject` field is populated instead of this field.
  /// For privacy reasons, the principal email address is sometimes redacted.
  /// For more information, see [Caller identities in audit
  /// logs](https://cloud.google.com/logging/docs/audit#user-id).
  @$pb.TagNumber(1)
  $core.String get principalEmail => $_getSZ(0);
  @$pb.TagNumber(1)
  set principalEmail($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPrincipalEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearPrincipalEmail() => $_clearField(1);

  /// The authority selector specified by the requestor, if any.
  /// It is not guaranteed that the principal was allowed to use this authority.
  @$pb.TagNumber(2)
  $core.String get authoritySelector => $_getSZ(1);
  @$pb.TagNumber(2)
  set authoritySelector($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAuthoritySelector() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthoritySelector() => $_clearField(2);

  /// The third party identification (if any) of the authenticated user making
  /// the request.
  /// When the JSON object represented here has a proto equivalent, the proto
  /// name will be indicated in the `@type` property.
  @$pb.TagNumber(4)
  $3.Struct get thirdPartyPrincipal => $_getN(2);
  @$pb.TagNumber(4)
  set thirdPartyPrincipal($3.Struct value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasThirdPartyPrincipal() => $_has(2);
  @$pb.TagNumber(4)
  void clearThirdPartyPrincipal() => $_clearField(4);
  @$pb.TagNumber(4)
  $3.Struct ensureThirdPartyPrincipal() => $_ensure(2);

  /// The name of the service account key used to create or exchange
  /// credentials for authenticating the service account making the request.
  /// This is a scheme-less URI full resource name. For example:
  ///
  /// "//iam.googleapis.com/projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}/keys/{key}"
  @$pb.TagNumber(5)
  $core.String get serviceAccountKeyName => $_getSZ(3);
  @$pb.TagNumber(5)
  set serviceAccountKeyName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(5)
  $core.bool hasServiceAccountKeyName() => $_has(3);
  @$pb.TagNumber(5)
  void clearServiceAccountKeyName() => $_clearField(5);

  /// Identity delegation history of an authenticated service account that makes
  /// the request. It contains information on the real authorities that try to
  /// access GCP resources by delegating on a service account. When multiple
  /// authorities present, they are guaranteed to be sorted based on the original
  /// ordering of the identity delegation events.
  @$pb.TagNumber(6)
  $pb.PbList<ServiceAccountDelegationInfo> get serviceAccountDelegationInfo =>
      $_getList(4);

  /// String representation of identity of requesting party.
  /// Populated for both first and third party identities.
  @$pb.TagNumber(8)
  $core.String get principalSubject => $_getSZ(5);
  @$pb.TagNumber(8)
  set principalSubject($core.String value) => $_setString(5, value);
  @$pb.TagNumber(8)
  $core.bool hasPrincipalSubject() => $_has(5);
  @$pb.TagNumber(8)
  void clearPrincipalSubject() => $_clearField(8);
}

/// Authorization information for the operation.
class AuthorizationInfo extends $pb.GeneratedMessage {
  factory AuthorizationInfo({
    $core.String? resource,
    $core.String? permission,
    $core.bool? granted,
    $4.AttributeContext_Resource? resourceAttributes,
  }) {
    final result = create();
    if (resource != null) result.resource = resource;
    if (permission != null) result.permission = permission;
    if (granted != null) result.granted = granted;
    if (resourceAttributes != null)
      result.resourceAttributes = resourceAttributes;
    return result;
  }

  AuthorizationInfo._();

  factory AuthorizationInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AuthorizationInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthorizationInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.audit.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'resource')
    ..aOS(2, _omitFieldNames ? '' : 'permission')
    ..aOB(3, _omitFieldNames ? '' : 'granted')
    ..aOM<$4.AttributeContext_Resource>(
        5, _omitFieldNames ? '' : 'resourceAttributes',
        subBuilder: $4.AttributeContext_Resource.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthorizationInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthorizationInfo copyWith(void Function(AuthorizationInfo) updates) =>
      super.copyWith((message) => updates(message as AuthorizationInfo))
          as AuthorizationInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthorizationInfo create() => AuthorizationInfo._();
  @$core.override
  AuthorizationInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AuthorizationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuthorizationInfo>(create);
  static AuthorizationInfo? _defaultInstance;

  /// The resource being accessed, as a REST-style string. For example:
  ///
  ///     bigquery.googleapis.com/projects/PROJECTID/datasets/DATASETID
  @$pb.TagNumber(1)
  $core.String get resource => $_getSZ(0);
  @$pb.TagNumber(1)
  set resource($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasResource() => $_has(0);
  @$pb.TagNumber(1)
  void clearResource() => $_clearField(1);

  /// The required IAM permission.
  @$pb.TagNumber(2)
  $core.String get permission => $_getSZ(1);
  @$pb.TagNumber(2)
  set permission($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPermission() => $_has(1);
  @$pb.TagNumber(2)
  void clearPermission() => $_clearField(2);

  /// Whether or not authorization for `resource` and `permission`
  /// was granted.
  @$pb.TagNumber(3)
  $core.bool get granted => $_getBF(2);
  @$pb.TagNumber(3)
  set granted($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasGranted() => $_has(2);
  @$pb.TagNumber(3)
  void clearGranted() => $_clearField(3);

  /// Resource attributes used in IAM condition evaluation. This field contains
  /// resource attributes like resource type and resource name.
  ///
  /// To get the whole view of the attributes used in IAM
  /// condition evaluation, the user must also look into
  /// `AuditLogData.request_metadata.request_attributes`.
  @$pb.TagNumber(5)
  $4.AttributeContext_Resource get resourceAttributes => $_getN(3);
  @$pb.TagNumber(5)
  set resourceAttributes($4.AttributeContext_Resource value) =>
      $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasResourceAttributes() => $_has(3);
  @$pb.TagNumber(5)
  void clearResourceAttributes() => $_clearField(5);
  @$pb.TagNumber(5)
  $4.AttributeContext_Resource ensureResourceAttributes() => $_ensure(3);
}

/// Metadata about the request.
class RequestMetadata extends $pb.GeneratedMessage {
  factory RequestMetadata({
    $core.String? callerIp,
    $core.String? callerSuppliedUserAgent,
    $core.String? callerNetwork,
    $4.AttributeContext_Request? requestAttributes,
    $4.AttributeContext_Peer? destinationAttributes,
  }) {
    final result = create();
    if (callerIp != null) result.callerIp = callerIp;
    if (callerSuppliedUserAgent != null)
      result.callerSuppliedUserAgent = callerSuppliedUserAgent;
    if (callerNetwork != null) result.callerNetwork = callerNetwork;
    if (requestAttributes != null) result.requestAttributes = requestAttributes;
    if (destinationAttributes != null)
      result.destinationAttributes = destinationAttributes;
    return result;
  }

  RequestMetadata._();

  factory RequestMetadata.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestMetadata.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestMetadata',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.audit.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'callerIp')
    ..aOS(2, _omitFieldNames ? '' : 'callerSuppliedUserAgent')
    ..aOS(3, _omitFieldNames ? '' : 'callerNetwork')
    ..aOM<$4.AttributeContext_Request>(
        7, _omitFieldNames ? '' : 'requestAttributes',
        subBuilder: $4.AttributeContext_Request.create)
    ..aOM<$4.AttributeContext_Peer>(
        8, _omitFieldNames ? '' : 'destinationAttributes',
        subBuilder: $4.AttributeContext_Peer.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestMetadata clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestMetadata copyWith(void Function(RequestMetadata) updates) =>
      super.copyWith((message) => updates(message as RequestMetadata))
          as RequestMetadata;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestMetadata create() => RequestMetadata._();
  @$core.override
  RequestMetadata createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RequestMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestMetadata>(create);
  static RequestMetadata? _defaultInstance;

  /// The IP address of the caller.
  /// For caller from internet, this will be public IPv4 or IPv6 address.
  /// For caller from a Compute Engine VM with external IP address, this
  /// will be the VM's external IP address. For caller from a Compute
  /// Engine VM without external IP address, if the VM is in the same
  /// organization (or project) as the accessed resource, `caller_ip` will
  /// be the VM's internal IPv4 address, otherwise the `caller_ip` will be
  /// redacted to "gce-internal-ip".
  /// See https://cloud.google.com/compute/docs/vpc/ for more information.
  @$pb.TagNumber(1)
  $core.String get callerIp => $_getSZ(0);
  @$pb.TagNumber(1)
  set callerIp($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCallerIp() => $_has(0);
  @$pb.TagNumber(1)
  void clearCallerIp() => $_clearField(1);

  /// The user agent of the caller.
  /// This information is not authenticated and should be treated accordingly.
  /// For example:
  ///
  /// +   `google-api-python-client/1.4.0`:
  ///     The request was made by the Google API client for Python.
  /// +   `Cloud SDK Command Line Tool apitools-client/1.0 gcloud/0.9.62`:
  ///     The request was made by the Google Cloud SDK CLI (gcloud).
  /// +   `AppEngine-Google; (+http://code.google.com/appengine; appid:
  /// s~my-project`:
  ///     The request was made from the `my-project` App Engine app.
  @$pb.TagNumber(2)
  $core.String get callerSuppliedUserAgent => $_getSZ(1);
  @$pb.TagNumber(2)
  set callerSuppliedUserAgent($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCallerSuppliedUserAgent() => $_has(1);
  @$pb.TagNumber(2)
  void clearCallerSuppliedUserAgent() => $_clearField(2);

  /// The network of the caller.
  /// Set only if the network host project is part of the same GCP organization
  /// (or project) as the accessed resource.
  /// See https://cloud.google.com/compute/docs/vpc/ for more information.
  /// This is a scheme-less URI full resource name. For example:
  ///
  ///     "//compute.googleapis.com/projects/PROJECT_ID/global/networks/NETWORK_ID"
  @$pb.TagNumber(3)
  $core.String get callerNetwork => $_getSZ(2);
  @$pb.TagNumber(3)
  set callerNetwork($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCallerNetwork() => $_has(2);
  @$pb.TagNumber(3)
  void clearCallerNetwork() => $_clearField(3);

  /// Request attributes used in IAM condition evaluation. This field contains
  /// request attributes like request time and access levels associated with
  /// the request.
  ///
  ///
  /// To get the whole view of the attributes used in IAM
  /// condition evaluation, the user must also look into
  /// `AuditLog.authentication_info.resource_attributes`.
  @$pb.TagNumber(7)
  $4.AttributeContext_Request get requestAttributes => $_getN(3);
  @$pb.TagNumber(7)
  set requestAttributes($4.AttributeContext_Request value) =>
      $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasRequestAttributes() => $_has(3);
  @$pb.TagNumber(7)
  void clearRequestAttributes() => $_clearField(7);
  @$pb.TagNumber(7)
  $4.AttributeContext_Request ensureRequestAttributes() => $_ensure(3);

  /// The destination of a network activity, such as accepting a TCP connection.
  /// In a multi hop network activity, the destination represents the receiver of
  /// the last hop. Only two fields are used in this message, Peer.port and
  /// Peer.ip. These fields are optionally populated by those services utilizing
  /// the IAM condition feature.
  @$pb.TagNumber(8)
  $4.AttributeContext_Peer get destinationAttributes => $_getN(4);
  @$pb.TagNumber(8)
  set destinationAttributes($4.AttributeContext_Peer value) =>
      $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasDestinationAttributes() => $_has(4);
  @$pb.TagNumber(8)
  void clearDestinationAttributes() => $_clearField(8);
  @$pb.TagNumber(8)
  $4.AttributeContext_Peer ensureDestinationAttributes() => $_ensure(4);
}

/// Location information about a resource.
class ResourceLocation extends $pb.GeneratedMessage {
  factory ResourceLocation({
    $core.Iterable<$core.String>? currentLocations,
    $core.Iterable<$core.String>? originalLocations,
  }) {
    final result = create();
    if (currentLocations != null)
      result.currentLocations.addAll(currentLocations);
    if (originalLocations != null)
      result.originalLocations.addAll(originalLocations);
    return result;
  }

  ResourceLocation._();

  factory ResourceLocation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResourceLocation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResourceLocation',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.audit.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'currentLocations')
    ..pPS(2, _omitFieldNames ? '' : 'originalLocations')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResourceLocation clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResourceLocation copyWith(void Function(ResourceLocation) updates) =>
      super.copyWith((message) => updates(message as ResourceLocation))
          as ResourceLocation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResourceLocation create() => ResourceLocation._();
  @$core.override
  ResourceLocation createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ResourceLocation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResourceLocation>(create);
  static ResourceLocation? _defaultInstance;

  /// The locations of a resource after the execution of the operation.
  /// Requests to create or delete a location based resource must populate
  /// the 'current_locations' field and not the 'original_locations' field.
  /// For example:
  ///
  ///     "europe-west1-a"
  ///     "us-east1"
  ///     "nam3"
  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get currentLocations => $_getList(0);

  /// The locations of a resource prior to the execution of the operation.
  /// Requests that mutate the resource's location must populate both the
  /// 'original_locations' as well as the 'current_locations' fields.
  /// For example:
  ///
  ///     "europe-west1-a"
  ///     "us-east1"
  ///     "nam3"
  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get originalLocations => $_getList(1);
}

/// First party identity principal.
class ServiceAccountDelegationInfo_FirstPartyPrincipal
    extends $pb.GeneratedMessage {
  factory ServiceAccountDelegationInfo_FirstPartyPrincipal({
    $core.String? principalEmail,
    $3.Struct? serviceMetadata,
  }) {
    final result = create();
    if (principalEmail != null) result.principalEmail = principalEmail;
    if (serviceMetadata != null) result.serviceMetadata = serviceMetadata;
    return result;
  }

  ServiceAccountDelegationInfo_FirstPartyPrincipal._();

  factory ServiceAccountDelegationInfo_FirstPartyPrincipal.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ServiceAccountDelegationInfo_FirstPartyPrincipal.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'ServiceAccountDelegationInfo.FirstPartyPrincipal',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.audit.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'principalEmail')
    ..aOM<$3.Struct>(2, _omitFieldNames ? '' : 'serviceMetadata',
        subBuilder: $3.Struct.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceAccountDelegationInfo_FirstPartyPrincipal clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceAccountDelegationInfo_FirstPartyPrincipal copyWith(
          void Function(ServiceAccountDelegationInfo_FirstPartyPrincipal)
              updates) =>
      super.copyWith((message) => updates(
              message as ServiceAccountDelegationInfo_FirstPartyPrincipal))
          as ServiceAccountDelegationInfo_FirstPartyPrincipal;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceAccountDelegationInfo_FirstPartyPrincipal create() =>
      ServiceAccountDelegationInfo_FirstPartyPrincipal._();
  @$core.override
  ServiceAccountDelegationInfo_FirstPartyPrincipal createEmptyInstance() =>
      create();
  @$core.pragma('dart2js:noInline')
  static ServiceAccountDelegationInfo_FirstPartyPrincipal getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          ServiceAccountDelegationInfo_FirstPartyPrincipal>(create);
  static ServiceAccountDelegationInfo_FirstPartyPrincipal? _defaultInstance;

  /// The email address of a Google account.
  @$pb.TagNumber(1)
  $core.String get principalEmail => $_getSZ(0);
  @$pb.TagNumber(1)
  set principalEmail($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPrincipalEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearPrincipalEmail() => $_clearField(1);

  /// Metadata about the service that uses the service account.
  @$pb.TagNumber(2)
  $3.Struct get serviceMetadata => $_getN(1);
  @$pb.TagNumber(2)
  set serviceMetadata($3.Struct value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasServiceMetadata() => $_has(1);
  @$pb.TagNumber(2)
  void clearServiceMetadata() => $_clearField(2);
  @$pb.TagNumber(2)
  $3.Struct ensureServiceMetadata() => $_ensure(1);
}

/// Third party identity principal.
class ServiceAccountDelegationInfo_ThirdPartyPrincipal
    extends $pb.GeneratedMessage {
  factory ServiceAccountDelegationInfo_ThirdPartyPrincipal({
    $3.Struct? thirdPartyClaims,
  }) {
    final result = create();
    if (thirdPartyClaims != null) result.thirdPartyClaims = thirdPartyClaims;
    return result;
  }

  ServiceAccountDelegationInfo_ThirdPartyPrincipal._();

  factory ServiceAccountDelegationInfo_ThirdPartyPrincipal.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ServiceAccountDelegationInfo_ThirdPartyPrincipal.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'ServiceAccountDelegationInfo.ThirdPartyPrincipal',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.audit.v1'),
      createEmptyInstance: create)
    ..aOM<$3.Struct>(1, _omitFieldNames ? '' : 'thirdPartyClaims',
        subBuilder: $3.Struct.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceAccountDelegationInfo_ThirdPartyPrincipal clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceAccountDelegationInfo_ThirdPartyPrincipal copyWith(
          void Function(ServiceAccountDelegationInfo_ThirdPartyPrincipal)
              updates) =>
      super.copyWith((message) => updates(
              message as ServiceAccountDelegationInfo_ThirdPartyPrincipal))
          as ServiceAccountDelegationInfo_ThirdPartyPrincipal;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceAccountDelegationInfo_ThirdPartyPrincipal create() =>
      ServiceAccountDelegationInfo_ThirdPartyPrincipal._();
  @$core.override
  ServiceAccountDelegationInfo_ThirdPartyPrincipal createEmptyInstance() =>
      create();
  @$core.pragma('dart2js:noInline')
  static ServiceAccountDelegationInfo_ThirdPartyPrincipal getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          ServiceAccountDelegationInfo_ThirdPartyPrincipal>(create);
  static ServiceAccountDelegationInfo_ThirdPartyPrincipal? _defaultInstance;

  /// Metadata about third party identity.
  @$pb.TagNumber(1)
  $3.Struct get thirdPartyClaims => $_getN(0);
  @$pb.TagNumber(1)
  set thirdPartyClaims($3.Struct value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasThirdPartyClaims() => $_has(0);
  @$pb.TagNumber(1)
  void clearThirdPartyClaims() => $_clearField(1);
  @$pb.TagNumber(1)
  $3.Struct ensureThirdPartyClaims() => $_ensure(0);
}

enum ServiceAccountDelegationInfo_Authority {
  firstPartyPrincipal,
  thirdPartyPrincipal,
  notSet
}

/// Identity delegation history of an authenticated service account.
class ServiceAccountDelegationInfo extends $pb.GeneratedMessage {
  factory ServiceAccountDelegationInfo({
    ServiceAccountDelegationInfo_FirstPartyPrincipal? firstPartyPrincipal,
    ServiceAccountDelegationInfo_ThirdPartyPrincipal? thirdPartyPrincipal,
  }) {
    final result = create();
    if (firstPartyPrincipal != null)
      result.firstPartyPrincipal = firstPartyPrincipal;
    if (thirdPartyPrincipal != null)
      result.thirdPartyPrincipal = thirdPartyPrincipal;
    return result;
  }

  ServiceAccountDelegationInfo._();

  factory ServiceAccountDelegationInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ServiceAccountDelegationInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, ServiceAccountDelegationInfo_Authority>
      _ServiceAccountDelegationInfo_AuthorityByTag = {
    1: ServiceAccountDelegationInfo_Authority.firstPartyPrincipal,
    2: ServiceAccountDelegationInfo_Authority.thirdPartyPrincipal,
    0: ServiceAccountDelegationInfo_Authority.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServiceAccountDelegationInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.audit.v1'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<ServiceAccountDelegationInfo_FirstPartyPrincipal>(
        1, _omitFieldNames ? '' : 'firstPartyPrincipal',
        subBuilder: ServiceAccountDelegationInfo_FirstPartyPrincipal.create)
    ..aOM<ServiceAccountDelegationInfo_ThirdPartyPrincipal>(
        2, _omitFieldNames ? '' : 'thirdPartyPrincipal',
        subBuilder: ServiceAccountDelegationInfo_ThirdPartyPrincipal.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceAccountDelegationInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceAccountDelegationInfo copyWith(
          void Function(ServiceAccountDelegationInfo) updates) =>
      super.copyWith(
              (message) => updates(message as ServiceAccountDelegationInfo))
          as ServiceAccountDelegationInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceAccountDelegationInfo create() =>
      ServiceAccountDelegationInfo._();
  @$core.override
  ServiceAccountDelegationInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ServiceAccountDelegationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServiceAccountDelegationInfo>(create);
  static ServiceAccountDelegationInfo? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  ServiceAccountDelegationInfo_Authority whichAuthority() =>
      _ServiceAccountDelegationInfo_AuthorityByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearAuthority() => $_clearField($_whichOneof(0));

  /// First party (Google) identity as the real authority.
  @$pb.TagNumber(1)
  ServiceAccountDelegationInfo_FirstPartyPrincipal get firstPartyPrincipal =>
      $_getN(0);
  @$pb.TagNumber(1)
  set firstPartyPrincipal(
          ServiceAccountDelegationInfo_FirstPartyPrincipal value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFirstPartyPrincipal() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstPartyPrincipal() => $_clearField(1);
  @$pb.TagNumber(1)
  ServiceAccountDelegationInfo_FirstPartyPrincipal
      ensureFirstPartyPrincipal() => $_ensure(0);

  /// Third party identity as the real authority.
  @$pb.TagNumber(2)
  ServiceAccountDelegationInfo_ThirdPartyPrincipal get thirdPartyPrincipal =>
      $_getN(1);
  @$pb.TagNumber(2)
  set thirdPartyPrincipal(
          ServiceAccountDelegationInfo_ThirdPartyPrincipal value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasThirdPartyPrincipal() => $_has(1);
  @$pb.TagNumber(2)
  void clearThirdPartyPrincipal() => $_clearField(2);
  @$pb.TagNumber(2)
  ServiceAccountDelegationInfo_ThirdPartyPrincipal
      ensureThirdPartyPrincipal() => $_ensure(1);
}

/// Additional information used to correlate multiple LogEntries. Used when a
/// single LogEntry would exceed the Google Cloud Logging size limit and is split
/// across multiple entries.
class LogSplit extends $pb.GeneratedMessage {
  factory LogSplit({
    $core.String? uid,
    $core.int? index,
    $core.int? totalSplits,
  }) {
    final result = create();
    if (uid != null) result.uid = uid;
    if (index != null) result.index = index;
    if (totalSplits != null) result.totalSplits = totalSplits;
    return result;
  }

  LogSplit._();

  factory LogSplit.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LogSplit.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogSplit',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.audit.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'uid')
    ..aI(2, _omitFieldNames ? '' : 'index')
    ..aI(3, _omitFieldNames ? '' : 'totalSplits')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogSplit clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogSplit copyWith(void Function(LogSplit) updates) =>
      super.copyWith((message) => updates(message as LogSplit)) as LogSplit;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogSplit create() => LogSplit._();
  @$core.override
  LogSplit createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LogSplit getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogSplit>(create);
  static LogSplit? _defaultInstance;

  /// A globally unique identifier for all LogEntries in a sequence of split
  /// logs. All LogEntries with the same |LogSplit.uid| are assumed to be part of
  /// the same sequence of split logs.
  @$pb.TagNumber(1)
  $core.String get uid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUid() => $_clearField(1);

  /// The index of this LogEntry in the sequence of split logs. LogEntries are
  /// given |index| values 0, 1, ..., n-1 for a sequence of n entries.
  @$pb.TagNumber(2)
  $core.int get index => $_getIZ(1);
  @$pb.TagNumber(2)
  set index($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearIndex() => $_clearField(2);

  /// The total number of logs that the original LogEntry was split into.
  @$pb.TagNumber(3)
  $core.int get totalSplits => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalSplits($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalSplits() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalSplits() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
