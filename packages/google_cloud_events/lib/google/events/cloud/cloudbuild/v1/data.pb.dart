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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/duration.pb.dart'
    as $1;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $0;

import 'data.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'data.pbenum.dart';

/// Build event data for Google Cloud Platform API operations.
class BuildEventData extends $pb.GeneratedMessage {
  factory BuildEventData({
    $core.String? id,
    BuildEventData_Status? status,
    Source? source,
    $0.Timestamp? createTime,
    $0.Timestamp? startTime,
    $0.Timestamp? finishTime,
    Results? results,
    $core.Iterable<BuildStep>? steps,
    $1.Duration? timeout,
    $core.Iterable<$core.String>? images,
    $core.String? projectId,
    $core.String? logsBucket,
    SourceProvenance? sourceProvenance,
    $core.String? buildTriggerId,
    BuildOptions? options,
    $core.String? statusDetail,
    $core.String? logUrl,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? substitutions,
    $core.Iterable<$core.String>? tags,
    $core.Iterable<Secret>? secrets,
    $core.Iterable<$core.MapEntry<$core.String, TimeSpan>>? timing,
    Artifacts? artifacts,
    $1.Duration? queueTtl,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (status != null) result.status = status;
    if (source != null) result.source = source;
    if (createTime != null) result.createTime = createTime;
    if (startTime != null) result.startTime = startTime;
    if (finishTime != null) result.finishTime = finishTime;
    if (results != null) result.results = results;
    if (steps != null) result.steps.addAll(steps);
    if (timeout != null) result.timeout = timeout;
    if (images != null) result.images.addAll(images);
    if (projectId != null) result.projectId = projectId;
    if (logsBucket != null) result.logsBucket = logsBucket;
    if (sourceProvenance != null) result.sourceProvenance = sourceProvenance;
    if (buildTriggerId != null) result.buildTriggerId = buildTriggerId;
    if (options != null) result.options = options;
    if (statusDetail != null) result.statusDetail = statusDetail;
    if (logUrl != null) result.logUrl = logUrl;
    if (substitutions != null) result.substitutions.addEntries(substitutions);
    if (tags != null) result.tags.addAll(tags);
    if (secrets != null) result.secrets.addAll(secrets);
    if (timing != null) result.timing.addEntries(timing);
    if (artifacts != null) result.artifacts = artifacts;
    if (queueTtl != null) result.queueTtl = queueTtl;
    return result;
  }

  BuildEventData._();

  factory BuildEventData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuildEventData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuildEventData',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.cloudbuild.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aE<BuildEventData_Status>(2, _omitFieldNames ? '' : 'status',
        enumValues: BuildEventData_Status.values)
    ..aOM<Source>(3, _omitFieldNames ? '' : 'source', subBuilder: Source.create)
    ..aOM<$0.Timestamp>(6, _omitFieldNames ? '' : 'createTime',
        subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(7, _omitFieldNames ? '' : 'startTime',
        subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(8, _omitFieldNames ? '' : 'finishTime',
        subBuilder: $0.Timestamp.create)
    ..aOM<Results>(10, _omitFieldNames ? '' : 'results',
        subBuilder: Results.create)
    ..pPM<BuildStep>(11, _omitFieldNames ? '' : 'steps',
        subBuilder: BuildStep.create)
    ..aOM<$1.Duration>(12, _omitFieldNames ? '' : 'timeout',
        subBuilder: $1.Duration.create)
    ..pPS(13, _omitFieldNames ? '' : 'images')
    ..aOS(16, _omitFieldNames ? '' : 'projectId')
    ..aOS(19, _omitFieldNames ? '' : 'logsBucket')
    ..aOM<SourceProvenance>(21, _omitFieldNames ? '' : 'sourceProvenance',
        subBuilder: SourceProvenance.create)
    ..aOS(22, _omitFieldNames ? '' : 'buildTriggerId')
    ..aOM<BuildOptions>(23, _omitFieldNames ? '' : 'options',
        subBuilder: BuildOptions.create)
    ..aOS(24, _omitFieldNames ? '' : 'statusDetail')
    ..aOS(25, _omitFieldNames ? '' : 'logUrl')
    ..m<$core.String, $core.String>(29, _omitFieldNames ? '' : 'substitutions',
        entryClassName: 'BuildEventData.SubstitutionsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.events.cloud.cloudbuild.v1'))
    ..pPS(31, _omitFieldNames ? '' : 'tags')
    ..pPM<Secret>(32, _omitFieldNames ? '' : 'secrets',
        subBuilder: Secret.create)
    ..m<$core.String, TimeSpan>(33, _omitFieldNames ? '' : 'timing',
        entryClassName: 'BuildEventData.TimingEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: TimeSpan.create,
        valueDefaultOrMaker: TimeSpan.getDefault,
        packageName: const $pb.PackageName('google.events.cloud.cloudbuild.v1'))
    ..aOM<Artifacts>(37, _omitFieldNames ? '' : 'artifacts',
        subBuilder: Artifacts.create)
    ..aOM<$1.Duration>(40, _omitFieldNames ? '' : 'queueTtl',
        subBuilder: $1.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuildEventData clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuildEventData copyWith(void Function(BuildEventData) updates) =>
      super.copyWith((message) => updates(message as BuildEventData))
          as BuildEventData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuildEventData create() => BuildEventData._();
  @$core.override
  BuildEventData createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BuildEventData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuildEventData>(create);
  static BuildEventData? _defaultInstance;

  /// Unique identifier of the build.
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// Status of the build.
  @$pb.TagNumber(2)
  BuildEventData_Status get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(BuildEventData_Status value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  /// The location of the source files to build.
  @$pb.TagNumber(3)
  Source get source => $_getN(2);
  @$pb.TagNumber(3)
  set source(Source value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSource() => $_has(2);
  @$pb.TagNumber(3)
  void clearSource() => $_clearField(3);
  @$pb.TagNumber(3)
  Source ensureSource() => $_ensure(2);

  /// Time at which the request to create the build was received.
  @$pb.TagNumber(6)
  $0.Timestamp get createTime => $_getN(3);
  @$pb.TagNumber(6)
  set createTime($0.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCreateTime() => $_has(3);
  @$pb.TagNumber(6)
  void clearCreateTime() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.Timestamp ensureCreateTime() => $_ensure(3);

  /// Time at which execution of the build was started.
  @$pb.TagNumber(7)
  $0.Timestamp get startTime => $_getN(4);
  @$pb.TagNumber(7)
  set startTime($0.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasStartTime() => $_has(4);
  @$pb.TagNumber(7)
  void clearStartTime() => $_clearField(7);
  @$pb.TagNumber(7)
  $0.Timestamp ensureStartTime() => $_ensure(4);

  /// Time at which execution of the build was finished.
  ///
  /// The difference between finish_time and start_time is the duration of the
  /// build's execution.
  @$pb.TagNumber(8)
  $0.Timestamp get finishTime => $_getN(5);
  @$pb.TagNumber(8)
  set finishTime($0.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasFinishTime() => $_has(5);
  @$pb.TagNumber(8)
  void clearFinishTime() => $_clearField(8);
  @$pb.TagNumber(8)
  $0.Timestamp ensureFinishTime() => $_ensure(5);

  /// Results of the build.
  @$pb.TagNumber(10)
  Results get results => $_getN(6);
  @$pb.TagNumber(10)
  set results(Results value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasResults() => $_has(6);
  @$pb.TagNumber(10)
  void clearResults() => $_clearField(10);
  @$pb.TagNumber(10)
  Results ensureResults() => $_ensure(6);

  /// The operations to be performed on the workspace.
  @$pb.TagNumber(11)
  $pb.PbList<BuildStep> get steps => $_getList(7);

  /// Amount of time that this build should be allowed to run, to second
  /// granularity. If this amount of time elapses, work on the build will cease
  /// and the build status will be `TIMEOUT`.
  @$pb.TagNumber(12)
  $1.Duration get timeout => $_getN(8);
  @$pb.TagNumber(12)
  set timeout($1.Duration value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasTimeout() => $_has(8);
  @$pb.TagNumber(12)
  void clearTimeout() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.Duration ensureTimeout() => $_ensure(8);

  /// A list of images to be pushed upon the successful completion of all build
  /// steps.
  ///
  /// The images are pushed using the builder service account's credentials.
  ///
  /// The digests of the pushed images will be stored in the `Build` resource's
  /// results field.
  ///
  /// If any of the images fail to be pushed, the build status is marked
  /// `FAILURE`.
  @$pb.TagNumber(13)
  $pb.PbList<$core.String> get images => $_getList(9);

  /// ID of the project.
  @$pb.TagNumber(16)
  $core.String get projectId => $_getSZ(10);
  @$pb.TagNumber(16)
  set projectId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(16)
  $core.bool hasProjectId() => $_has(10);
  @$pb.TagNumber(16)
  void clearProjectId() => $_clearField(16);

  /// Google Cloud Storage bucket where logs should be written (see
  /// [Bucket Name
  /// Requirements](https://cloud.google.com/storage/docs/bucket-naming#requirements)).
  /// Logs file names will be of the format `${logs_bucket}/log-${build_id}.txt`.
  @$pb.TagNumber(19)
  $core.String get logsBucket => $_getSZ(11);
  @$pb.TagNumber(19)
  set logsBucket($core.String value) => $_setString(11, value);
  @$pb.TagNumber(19)
  $core.bool hasLogsBucket() => $_has(11);
  @$pb.TagNumber(19)
  void clearLogsBucket() => $_clearField(19);

  /// A permanent fixed identifier for source.
  @$pb.TagNumber(21)
  SourceProvenance get sourceProvenance => $_getN(12);
  @$pb.TagNumber(21)
  set sourceProvenance(SourceProvenance value) => $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasSourceProvenance() => $_has(12);
  @$pb.TagNumber(21)
  void clearSourceProvenance() => $_clearField(21);
  @$pb.TagNumber(21)
  SourceProvenance ensureSourceProvenance() => $_ensure(12);

  /// The ID of the `BuildTrigger` that triggered this build, if it
  /// was triggered automatically.
  @$pb.TagNumber(22)
  $core.String get buildTriggerId => $_getSZ(13);
  @$pb.TagNumber(22)
  set buildTriggerId($core.String value) => $_setString(13, value);
  @$pb.TagNumber(22)
  $core.bool hasBuildTriggerId() => $_has(13);
  @$pb.TagNumber(22)
  void clearBuildTriggerId() => $_clearField(22);

  /// Special options for this build.
  @$pb.TagNumber(23)
  BuildOptions get options => $_getN(14);
  @$pb.TagNumber(23)
  set options(BuildOptions value) => $_setField(23, value);
  @$pb.TagNumber(23)
  $core.bool hasOptions() => $_has(14);
  @$pb.TagNumber(23)
  void clearOptions() => $_clearField(23);
  @$pb.TagNumber(23)
  BuildOptions ensureOptions() => $_ensure(14);

  /// Customer-readable message about the current status.
  @$pb.TagNumber(24)
  $core.String get statusDetail => $_getSZ(15);
  @$pb.TagNumber(24)
  set statusDetail($core.String value) => $_setString(15, value);
  @$pb.TagNumber(24)
  $core.bool hasStatusDetail() => $_has(15);
  @$pb.TagNumber(24)
  void clearStatusDetail() => $_clearField(24);

  /// URL to logs for this build in Google Cloud Console.
  @$pb.TagNumber(25)
  $core.String get logUrl => $_getSZ(16);
  @$pb.TagNumber(25)
  set logUrl($core.String value) => $_setString(16, value);
  @$pb.TagNumber(25)
  $core.bool hasLogUrl() => $_has(16);
  @$pb.TagNumber(25)
  void clearLogUrl() => $_clearField(25);

  /// Substitutions data for `Build` resource.
  @$pb.TagNumber(29)
  $pb.PbMap<$core.String, $core.String> get substitutions => $_getMap(17);

  /// Tags for annotation of a `Build`. These are not docker tags.
  @$pb.TagNumber(31)
  $pb.PbList<$core.String> get tags => $_getList(18);

  /// Secrets to decrypt using Cloud Key Management Service.
  @$pb.TagNumber(32)
  $pb.PbList<Secret> get secrets => $_getList(19);

  /// Stores timing information for phases of the build. Valid keys
  /// are:
  ///
  /// * BUILD: time to execute all build steps
  /// * PUSH: time to push all specified images.
  /// * FETCHSOURCE: time to fetch source.
  ///
  /// If the build does not specify source or images,
  /// these keys will not be included.
  @$pb.TagNumber(33)
  $pb.PbMap<$core.String, TimeSpan> get timing => $_getMap(20);

  /// Artifacts produced by the build that should be uploaded upon
  /// successful completion of all build steps.
  @$pb.TagNumber(37)
  Artifacts get artifacts => $_getN(21);
  @$pb.TagNumber(37)
  set artifacts(Artifacts value) => $_setField(37, value);
  @$pb.TagNumber(37)
  $core.bool hasArtifacts() => $_has(21);
  @$pb.TagNumber(37)
  void clearArtifacts() => $_clearField(37);
  @$pb.TagNumber(37)
  Artifacts ensureArtifacts() => $_ensure(21);

  /// TTL in queue for this build. If provided and the build is enqueued longer
  /// than this value, the build will expire and the build status will be
  /// `EXPIRED`.
  ///
  /// The TTL starts ticking from create_time.
  @$pb.TagNumber(40)
  $1.Duration get queueTtl => $_getN(22);
  @$pb.TagNumber(40)
  set queueTtl($1.Duration value) => $_setField(40, value);
  @$pb.TagNumber(40)
  $core.bool hasQueueTtl() => $_has(22);
  @$pb.TagNumber(40)
  void clearQueueTtl() => $_clearField(40);
  @$pb.TagNumber(40)
  $1.Duration ensureQueueTtl() => $_ensure(22);
}

enum Source_Source { storageSource, repoSource, notSet }

class Source extends $pb.GeneratedMessage {
  factory Source({
    StorageSource? storageSource,
    RepoSource? repoSource,
  }) {
    final result = create();
    if (storageSource != null) result.storageSource = storageSource;
    if (repoSource != null) result.repoSource = repoSource;
    return result;
  }

  Source._();

  factory Source.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Source.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Source_Source> _Source_SourceByTag = {
    2: Source_Source.storageSource,
    3: Source_Source.repoSource,
    0: Source_Source.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Source',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.cloudbuild.v1'),
      createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aOM<StorageSource>(2, _omitFieldNames ? '' : 'storageSource',
        subBuilder: StorageSource.create)
    ..aOM<RepoSource>(3, _omitFieldNames ? '' : 'repoSource',
        subBuilder: RepoSource.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Source clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Source copyWith(void Function(Source) updates) =>
      super.copyWith((message) => updates(message as Source)) as Source;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Source create() => Source._();
  @$core.override
  Source createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Source getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Source>(create);
  static Source? _defaultInstance;

  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  Source_Source whichSource() => _Source_SourceByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  void clearSource() => $_clearField($_whichOneof(0));

  /// If provided, get the source from this location in Google Cloud Storage.
  @$pb.TagNumber(2)
  StorageSource get storageSource => $_getN(0);
  @$pb.TagNumber(2)
  set storageSource(StorageSource value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStorageSource() => $_has(0);
  @$pb.TagNumber(2)
  void clearStorageSource() => $_clearField(2);
  @$pb.TagNumber(2)
  StorageSource ensureStorageSource() => $_ensure(0);

  /// If provided, get the source from this location in a Cloud Source
  /// Repository.
  @$pb.TagNumber(3)
  RepoSource get repoSource => $_getN(1);
  @$pb.TagNumber(3)
  set repoSource(RepoSource value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRepoSource() => $_has(1);
  @$pb.TagNumber(3)
  void clearRepoSource() => $_clearField(3);
  @$pb.TagNumber(3)
  RepoSource ensureRepoSource() => $_ensure(1);
}

/// Location of the source in an archive file in Google Cloud Storage.
class StorageSource extends $pb.GeneratedMessage {
  factory StorageSource({
    $core.String? bucket,
    $core.String? object,
    $fixnum.Int64? generation,
  }) {
    final result = create();
    if (bucket != null) result.bucket = bucket;
    if (object != null) result.object = object;
    if (generation != null) result.generation = generation;
    return result;
  }

  StorageSource._();

  factory StorageSource.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StorageSource.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StorageSource',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.cloudbuild.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'bucket')
    ..aOS(2, _omitFieldNames ? '' : 'object')
    ..aInt64(3, _omitFieldNames ? '' : 'generation')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StorageSource clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StorageSource copyWith(void Function(StorageSource) updates) =>
      super.copyWith((message) => updates(message as StorageSource))
          as StorageSource;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StorageSource create() => StorageSource._();
  @$core.override
  StorageSource createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StorageSource getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StorageSource>(create);
  static StorageSource? _defaultInstance;

  /// Google Cloud Storage bucket containing the source (see
  /// [Bucket Name
  /// Requirements](https://cloud.google.com/storage/docs/bucket-naming#requirements)).
  @$pb.TagNumber(1)
  $core.String get bucket => $_getSZ(0);
  @$pb.TagNumber(1)
  set bucket($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBucket() => $_has(0);
  @$pb.TagNumber(1)
  void clearBucket() => $_clearField(1);

  /// Google Cloud Storage object containing the source.
  @$pb.TagNumber(2)
  $core.String get object => $_getSZ(1);
  @$pb.TagNumber(2)
  set object($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasObject() => $_has(1);
  @$pb.TagNumber(2)
  void clearObject() => $_clearField(2);

  /// Google Cloud Storage generation for the object. If the generation is
  /// omitted, the latest generation will be used.
  @$pb.TagNumber(3)
  $fixnum.Int64 get generation => $_getI64(2);
  @$pb.TagNumber(3)
  set generation($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasGeneration() => $_has(2);
  @$pb.TagNumber(3)
  void clearGeneration() => $_clearField(3);
}

enum RepoSource_Revision { branchName, tagName, commitSha, notSet }

/// Location of the source in a Google Cloud Source Repository.
class RepoSource extends $pb.GeneratedMessage {
  factory RepoSource({
    $core.String? projectId,
    $core.String? repoName,
    $core.String? branchName,
    $core.String? tagName,
    $core.String? commitSha,
    $core.String? dir,
    $core.bool? invertRegex,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? substitutions,
  }) {
    final result = create();
    if (projectId != null) result.projectId = projectId;
    if (repoName != null) result.repoName = repoName;
    if (branchName != null) result.branchName = branchName;
    if (tagName != null) result.tagName = tagName;
    if (commitSha != null) result.commitSha = commitSha;
    if (dir != null) result.dir = dir;
    if (invertRegex != null) result.invertRegex = invertRegex;
    if (substitutions != null) result.substitutions.addEntries(substitutions);
    return result;
  }

  RepoSource._();

  factory RepoSource.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RepoSource.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, RepoSource_Revision>
      _RepoSource_RevisionByTag = {
    3: RepoSource_Revision.branchName,
    4: RepoSource_Revision.tagName,
    5: RepoSource_Revision.commitSha,
    0: RepoSource_Revision.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RepoSource',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.cloudbuild.v1'),
      createEmptyInstance: create)
    ..oo(0, [3, 4, 5])
    ..aOS(1, _omitFieldNames ? '' : 'projectId')
    ..aOS(2, _omitFieldNames ? '' : 'repoName')
    ..aOS(3, _omitFieldNames ? '' : 'branchName')
    ..aOS(4, _omitFieldNames ? '' : 'tagName')
    ..aOS(5, _omitFieldNames ? '' : 'commitSha')
    ..aOS(7, _omitFieldNames ? '' : 'dir')
    ..aOB(8, _omitFieldNames ? '' : 'invertRegex')
    ..m<$core.String, $core.String>(9, _omitFieldNames ? '' : 'substitutions',
        entryClassName: 'RepoSource.SubstitutionsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.events.cloud.cloudbuild.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RepoSource clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RepoSource copyWith(void Function(RepoSource) updates) =>
      super.copyWith((message) => updates(message as RepoSource)) as RepoSource;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RepoSource create() => RepoSource._();
  @$core.override
  RepoSource createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RepoSource getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RepoSource>(create);
  static RepoSource? _defaultInstance;

  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  RepoSource_Revision whichRevision() =>
      _RepoSource_RevisionByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  void clearRevision() => $_clearField($_whichOneof(0));

  /// ID of the project that owns the Cloud Source Repository.
  @$pb.TagNumber(1)
  $core.String get projectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set projectId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProjectId() => $_clearField(1);

  /// Name of the Cloud Source Repository.
  @$pb.TagNumber(2)
  $core.String get repoName => $_getSZ(1);
  @$pb.TagNumber(2)
  set repoName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRepoName() => $_has(1);
  @$pb.TagNumber(2)
  void clearRepoName() => $_clearField(2);

  /// Regex matching branches to build.
  ///
  /// The syntax of the regular expressions accepted is the syntax accepted by
  /// RE2 and described at https://github.com/google/re2/wiki/Syntax
  @$pb.TagNumber(3)
  $core.String get branchName => $_getSZ(2);
  @$pb.TagNumber(3)
  set branchName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBranchName() => $_has(2);
  @$pb.TagNumber(3)
  void clearBranchName() => $_clearField(3);

  /// Regex matching tags to build.
  ///
  /// The syntax of the regular expressions accepted is the syntax accepted by
  /// RE2 and described at https://github.com/google/re2/wiki/Syntax
  @$pb.TagNumber(4)
  $core.String get tagName => $_getSZ(3);
  @$pb.TagNumber(4)
  set tagName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTagName() => $_has(3);
  @$pb.TagNumber(4)
  void clearTagName() => $_clearField(4);

  /// Explicit commit SHA to build.
  @$pb.TagNumber(5)
  $core.String get commitSha => $_getSZ(4);
  @$pb.TagNumber(5)
  set commitSha($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCommitSha() => $_has(4);
  @$pb.TagNumber(5)
  void clearCommitSha() => $_clearField(5);

  /// Directory, relative to the source root, in which to run the build.
  ///
  /// This must be a relative path. If a step's `dir` is specified and is an
  /// absolute path, this value is ignored for that step's execution.
  @$pb.TagNumber(7)
  $core.String get dir => $_getSZ(5);
  @$pb.TagNumber(7)
  set dir($core.String value) => $_setString(5, value);
  @$pb.TagNumber(7)
  $core.bool hasDir() => $_has(5);
  @$pb.TagNumber(7)
  void clearDir() => $_clearField(7);

  /// Only trigger a build if the revision regex does NOT match the revision
  /// regex.
  @$pb.TagNumber(8)
  $core.bool get invertRegex => $_getBF(6);
  @$pb.TagNumber(8)
  set invertRegex($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(8)
  $core.bool hasInvertRegex() => $_has(6);
  @$pb.TagNumber(8)
  void clearInvertRegex() => $_clearField(8);

  /// Substitutions to use in a triggered build.
  /// Should only be used with RunBuildTrigger
  @$pb.TagNumber(9)
  $pb.PbMap<$core.String, $core.String> get substitutions => $_getMap(7);
}

/// A step in the build pipeline.
class BuildStep extends $pb.GeneratedMessage {
  factory BuildStep({
    $core.String? name,
    $core.Iterable<$core.String>? env,
    $core.Iterable<$core.String>? args,
    $core.String? dir,
    $core.String? id,
    $core.Iterable<$core.String>? waitFor,
    $core.String? entrypoint,
    $core.Iterable<$core.String>? secretEnv,
    $core.Iterable<Volume>? volumes,
    TimeSpan? timing,
    $1.Duration? timeout,
    BuildEventData_Status? status,
    TimeSpan? pullTiming,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (env != null) result.env.addAll(env);
    if (args != null) result.args.addAll(args);
    if (dir != null) result.dir = dir;
    if (id != null) result.id = id;
    if (waitFor != null) result.waitFor.addAll(waitFor);
    if (entrypoint != null) result.entrypoint = entrypoint;
    if (secretEnv != null) result.secretEnv.addAll(secretEnv);
    if (volumes != null) result.volumes.addAll(volumes);
    if (timing != null) result.timing = timing;
    if (timeout != null) result.timeout = timeout;
    if (status != null) result.status = status;
    if (pullTiming != null) result.pullTiming = pullTiming;
    return result;
  }

  BuildStep._();

  factory BuildStep.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuildStep.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuildStep',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.cloudbuild.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pPS(2, _omitFieldNames ? '' : 'env')
    ..pPS(3, _omitFieldNames ? '' : 'args')
    ..aOS(4, _omitFieldNames ? '' : 'dir')
    ..aOS(5, _omitFieldNames ? '' : 'id')
    ..pPS(6, _omitFieldNames ? '' : 'waitFor')
    ..aOS(7, _omitFieldNames ? '' : 'entrypoint')
    ..pPS(8, _omitFieldNames ? '' : 'secretEnv')
    ..pPM<Volume>(9, _omitFieldNames ? '' : 'volumes',
        subBuilder: Volume.create)
    ..aOM<TimeSpan>(10, _omitFieldNames ? '' : 'timing',
        subBuilder: TimeSpan.create)
    ..aOM<$1.Duration>(11, _omitFieldNames ? '' : 'timeout',
        subBuilder: $1.Duration.create)
    ..aE<BuildEventData_Status>(12, _omitFieldNames ? '' : 'status',
        enumValues: BuildEventData_Status.values)
    ..aOM<TimeSpan>(13, _omitFieldNames ? '' : 'pullTiming',
        subBuilder: TimeSpan.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuildStep clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuildStep copyWith(void Function(BuildStep) updates) =>
      super.copyWith((message) => updates(message as BuildStep)) as BuildStep;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuildStep create() => BuildStep._();
  @$core.override
  BuildStep createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BuildStep getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuildStep>(create);
  static BuildStep? _defaultInstance;

  /// The name of the container image that will run this particular
  /// build step.
  ///
  /// If the image is available in the host's Docker daemon's cache, it
  /// will be run directly. If not, the host will attempt to pull the image
  /// first, using the builder service account's credentials if necessary.
  ///
  /// The Docker daemon's cache will already have the latest versions of all of
  /// the officially supported build steps
  /// ([https://github.com/GoogleCloudPlatform/cloud-builders](https://github.com/GoogleCloudPlatform/cloud-builders)).
  /// The Docker daemon will also have cached many of the layers for some popular
  /// images, like "ubuntu", "debian", but they will be refreshed at the time you
  /// attempt to use them.
  ///
  /// If you built an image in a previous build step, it will be stored in the
  /// host's Docker daemon's cache and is available to use as the name for a
  /// later build step.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// A list of environment variable definitions to be used when running a step.
  ///
  /// The elements are of the form "KEY=VALUE" for the environment variable "KEY"
  /// being given the value "VALUE".
  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get env => $_getList(1);

  /// A list of arguments that will be presented to the step when it is started.
  ///
  /// If the image used to run the step's container has an entrypoint, the `args`
  /// are used as arguments to that entrypoint. If the image does not define
  /// an entrypoint, the first element in args is used as the entrypoint,
  /// and the remainder will be used as arguments.
  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get args => $_getList(2);

  /// Working directory to use when running this step's container.
  ///
  /// If this value is a relative path, it is relative to the build's working
  /// directory. If this value is absolute, it may be outside the build's working
  /// directory, in which case the contents of the path may not be persisted
  /// across build step executions, unless a `volume` for that path is specified.
  ///
  /// If the build specifies a `RepoSource` with `dir` and a step with a `dir`,
  /// which specifies an absolute path, the `RepoSource` `dir` is ignored for
  /// the step's execution.
  @$pb.TagNumber(4)
  $core.String get dir => $_getSZ(3);
  @$pb.TagNumber(4)
  set dir($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDir() => $_has(3);
  @$pb.TagNumber(4)
  void clearDir() => $_clearField(4);

  /// Unique identifier for this build step, used in `wait_for` to
  /// reference this build step as a dependency.
  @$pb.TagNumber(5)
  $core.String get id => $_getSZ(4);
  @$pb.TagNumber(5)
  set id($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasId() => $_has(4);
  @$pb.TagNumber(5)
  void clearId() => $_clearField(5);

  /// The ID(s) of the step(s) that this build step depends on.
  /// This build step will not start until all the build steps in `wait_for`
  /// have completed successfully. If `wait_for` is empty, this build step will
  /// start when all previous build steps in the `Build.Steps` list have
  /// completed successfully.
  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get waitFor => $_getList(5);

  /// Entrypoint to be used instead of the build step image's default entrypoint.
  /// If unset, the image's default entrypoint is used.
  @$pb.TagNumber(7)
  $core.String get entrypoint => $_getSZ(6);
  @$pb.TagNumber(7)
  set entrypoint($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEntrypoint() => $_has(6);
  @$pb.TagNumber(7)
  void clearEntrypoint() => $_clearField(7);

  /// A list of environment variables which are encrypted using a Cloud Key
  /// Management Service crypto key. These values must be specified in the
  /// build's `Secret`.
  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get secretEnv => $_getList(7);

  /// List of volumes to mount into the build step.
  ///
  /// Each volume is created as an empty volume prior to execution of the
  /// build step. Upon completion of the build, volumes and their contents are
  /// discarded.
  ///
  /// Using a named volume in only one step is not valid as it is indicative
  /// of a build request with an incorrect configuration.
  @$pb.TagNumber(9)
  $pb.PbList<Volume> get volumes => $_getList(8);

  /// Stores timing information for executing this build step.
  @$pb.TagNumber(10)
  TimeSpan get timing => $_getN(9);
  @$pb.TagNumber(10)
  set timing(TimeSpan value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasTiming() => $_has(9);
  @$pb.TagNumber(10)
  void clearTiming() => $_clearField(10);
  @$pb.TagNumber(10)
  TimeSpan ensureTiming() => $_ensure(9);

  /// Time limit for executing this build step. If not defined, the step has no
  /// time limit and will be allowed to continue to run until either it completes
  /// or the build itself times out.
  @$pb.TagNumber(11)
  $1.Duration get timeout => $_getN(10);
  @$pb.TagNumber(11)
  set timeout($1.Duration value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasTimeout() => $_has(10);
  @$pb.TagNumber(11)
  void clearTimeout() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Duration ensureTimeout() => $_ensure(10);

  /// Status of the build step. At this time, build step status is
  /// only updated on build completion; step status is not updated in real-time
  /// as the build progresses.
  @$pb.TagNumber(12)
  BuildEventData_Status get status => $_getN(11);
  @$pb.TagNumber(12)
  set status(BuildEventData_Status value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasStatus() => $_has(11);
  @$pb.TagNumber(12)
  void clearStatus() => $_clearField(12);

  /// Stores timing information for pulling this build step's
  /// builder image only.
  @$pb.TagNumber(13)
  TimeSpan get pullTiming => $_getN(12);
  @$pb.TagNumber(13)
  set pullTiming(TimeSpan value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasPullTiming() => $_has(12);
  @$pb.TagNumber(13)
  void clearPullTiming() => $_clearField(13);
  @$pb.TagNumber(13)
  TimeSpan ensurePullTiming() => $_ensure(12);
}

/// Volume describes a Docker container volume which is mounted into build steps
/// in order to persist files across build step execution.
class Volume extends $pb.GeneratedMessage {
  factory Volume({
    $core.String? name,
    $core.String? path,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (path != null) result.path = path;
    return result;
  }

  Volume._();

  factory Volume.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Volume.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Volume',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.cloudbuild.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'path')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Volume clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Volume copyWith(void Function(Volume) updates) =>
      super.copyWith((message) => updates(message as Volume)) as Volume;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Volume create() => Volume._();
  @$core.override
  Volume createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Volume getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Volume>(create);
  static Volume? _defaultInstance;

  /// Name of the volume to mount.
  ///
  /// Volume names must be unique per build step and must be valid names for
  /// Docker volumes. Each named volume must be used by at least two build steps.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// Path at which to mount the volume.
  ///
  /// Paths must be absolute and cannot conflict with other volume paths on the
  /// same build step or with certain reserved volume paths.
  @$pb.TagNumber(2)
  $core.String get path => $_getSZ(1);
  @$pb.TagNumber(2)
  set path($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearPath() => $_clearField(2);
}

/// Artifacts created by the build pipeline.
class Results extends $pb.GeneratedMessage {
  factory Results({
    $core.Iterable<BuiltImage>? images,
    $core.Iterable<$core.String>? buildStepImages,
    $core.String? artifactManifest,
    $fixnum.Int64? numArtifacts,
    $core.Iterable<$core.List<$core.int>>? buildStepOutputs,
    TimeSpan? artifactTiming,
  }) {
    final result = create();
    if (images != null) result.images.addAll(images);
    if (buildStepImages != null) result.buildStepImages.addAll(buildStepImages);
    if (artifactManifest != null) result.artifactManifest = artifactManifest;
    if (numArtifacts != null) result.numArtifacts = numArtifacts;
    if (buildStepOutputs != null)
      result.buildStepOutputs.addAll(buildStepOutputs);
    if (artifactTiming != null) result.artifactTiming = artifactTiming;
    return result;
  }

  Results._();

  factory Results.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Results.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Results',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.cloudbuild.v1'),
      createEmptyInstance: create)
    ..pPM<BuiltImage>(2, _omitFieldNames ? '' : 'images',
        subBuilder: BuiltImage.create)
    ..pPS(3, _omitFieldNames ? '' : 'buildStepImages')
    ..aOS(4, _omitFieldNames ? '' : 'artifactManifest')
    ..aInt64(5, _omitFieldNames ? '' : 'numArtifacts')
    ..p<$core.List<$core.int>>(
        6, _omitFieldNames ? '' : 'buildStepOutputs', $pb.PbFieldType.PY)
    ..aOM<TimeSpan>(7, _omitFieldNames ? '' : 'artifactTiming',
        subBuilder: TimeSpan.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Results clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Results copyWith(void Function(Results) updates) =>
      super.copyWith((message) => updates(message as Results)) as Results;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Results create() => Results._();
  @$core.override
  Results createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Results getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Results>(create);
  static Results? _defaultInstance;

  /// Container images that were built as a part of the build.
  @$pb.TagNumber(2)
  $pb.PbList<BuiltImage> get images => $_getList(0);

  /// List of build step digests, in the order corresponding to build step
  /// indices.
  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get buildStepImages => $_getList(1);

  /// Path to the artifact manifest. Only populated when artifacts are uploaded.
  @$pb.TagNumber(4)
  $core.String get artifactManifest => $_getSZ(2);
  @$pb.TagNumber(4)
  set artifactManifest($core.String value) => $_setString(2, value);
  @$pb.TagNumber(4)
  $core.bool hasArtifactManifest() => $_has(2);
  @$pb.TagNumber(4)
  void clearArtifactManifest() => $_clearField(4);

  /// Number of artifacts uploaded. Only populated when artifacts are uploaded.
  @$pb.TagNumber(5)
  $fixnum.Int64 get numArtifacts => $_getI64(3);
  @$pb.TagNumber(5)
  set numArtifacts($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(5)
  $core.bool hasNumArtifacts() => $_has(3);
  @$pb.TagNumber(5)
  void clearNumArtifacts() => $_clearField(5);

  /// List of build step outputs, produced by builder images, in the order
  /// corresponding to build step indices.
  ///
  /// [Cloud Builders](https://cloud.google.com/cloud-build/docs/cloud-builders)
  /// can produce this output by writing to `$BUILDER_OUTPUT/output`.
  /// Only the first 4KB of data is stored.
  @$pb.TagNumber(6)
  $pb.PbList<$core.List<$core.int>> get buildStepOutputs => $_getList(4);

  /// Time to push all non-container artifacts.
  @$pb.TagNumber(7)
  TimeSpan get artifactTiming => $_getN(5);
  @$pb.TagNumber(7)
  set artifactTiming(TimeSpan value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasArtifactTiming() => $_has(5);
  @$pb.TagNumber(7)
  void clearArtifactTiming() => $_clearField(7);
  @$pb.TagNumber(7)
  TimeSpan ensureArtifactTiming() => $_ensure(5);
}

/// An image built by the pipeline.
class BuiltImage extends $pb.GeneratedMessage {
  factory BuiltImage({
    $core.String? name,
    $core.String? digest,
    TimeSpan? pushTiming,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (digest != null) result.digest = digest;
    if (pushTiming != null) result.pushTiming = pushTiming;
    return result;
  }

  BuiltImage._();

  factory BuiltImage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuiltImage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuiltImage',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.cloudbuild.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'digest')
    ..aOM<TimeSpan>(4, _omitFieldNames ? '' : 'pushTiming',
        subBuilder: TimeSpan.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuiltImage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuiltImage copyWith(void Function(BuiltImage) updates) =>
      super.copyWith((message) => updates(message as BuiltImage)) as BuiltImage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuiltImage create() => BuiltImage._();
  @$core.override
  BuiltImage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BuiltImage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuiltImage>(create);
  static BuiltImage? _defaultInstance;

  /// Name used to push the container image to Google Container Registry, as
  /// presented to `docker push`.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// Docker Registry 2.0 digest.
  @$pb.TagNumber(3)
  $core.String get digest => $_getSZ(1);
  @$pb.TagNumber(3)
  set digest($core.String value) => $_setString(1, value);
  @$pb.TagNumber(3)
  $core.bool hasDigest() => $_has(1);
  @$pb.TagNumber(3)
  void clearDigest() => $_clearField(3);

  /// Stores timing information for pushing the specified image.
  @$pb.TagNumber(4)
  TimeSpan get pushTiming => $_getN(2);
  @$pb.TagNumber(4)
  set pushTiming(TimeSpan value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPushTiming() => $_has(2);
  @$pb.TagNumber(4)
  void clearPushTiming() => $_clearField(4);
  @$pb.TagNumber(4)
  TimeSpan ensurePushTiming() => $_ensure(2);
}

/// Files in the workspace to upload to Cloud Storage upon successful
/// completion of all build steps.
class Artifacts_ArtifactObjects extends $pb.GeneratedMessage {
  factory Artifacts_ArtifactObjects({
    $core.String? location,
    $core.Iterable<$core.String>? paths,
    TimeSpan? timing,
  }) {
    final result = create();
    if (location != null) result.location = location;
    if (paths != null) result.paths.addAll(paths);
    if (timing != null) result.timing = timing;
    return result;
  }

  Artifacts_ArtifactObjects._();

  factory Artifacts_ArtifactObjects.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Artifacts_ArtifactObjects.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Artifacts.ArtifactObjects',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.cloudbuild.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'location')
    ..pPS(2, _omitFieldNames ? '' : 'paths')
    ..aOM<TimeSpan>(3, _omitFieldNames ? '' : 'timing',
        subBuilder: TimeSpan.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Artifacts_ArtifactObjects clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Artifacts_ArtifactObjects copyWith(
          void Function(Artifacts_ArtifactObjects) updates) =>
      super.copyWith((message) => updates(message as Artifacts_ArtifactObjects))
          as Artifacts_ArtifactObjects;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Artifacts_ArtifactObjects create() => Artifacts_ArtifactObjects._();
  @$core.override
  Artifacts_ArtifactObjects createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Artifacts_ArtifactObjects getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Artifacts_ArtifactObjects>(create);
  static Artifacts_ArtifactObjects? _defaultInstance;

  /// Cloud Storage bucket and optional object path, in the form
  /// "gs://bucket/path/to/somewhere/". (see [Bucket Name
  /// Requirements](https://cloud.google.com/storage/docs/bucket-naming#requirements)).
  ///
  /// Files in the workspace matching any path pattern will be uploaded to
  /// Cloud Storage with this location as a prefix.
  @$pb.TagNumber(1)
  $core.String get location => $_getSZ(0);
  @$pb.TagNumber(1)
  set location($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLocation() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocation() => $_clearField(1);

  /// Path globs used to match files in the build's workspace.
  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get paths => $_getList(1);

  /// Stores timing information for pushing all artifact objects.
  @$pb.TagNumber(3)
  TimeSpan get timing => $_getN(2);
  @$pb.TagNumber(3)
  set timing(TimeSpan value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTiming() => $_has(2);
  @$pb.TagNumber(3)
  void clearTiming() => $_clearField(3);
  @$pb.TagNumber(3)
  TimeSpan ensureTiming() => $_ensure(2);
}

/// Artifacts produced by a build that should be uploaded upon
/// successful completion of all build steps.
class Artifacts extends $pb.GeneratedMessage {
  factory Artifacts({
    $core.Iterable<$core.String>? images,
    Artifacts_ArtifactObjects? objects,
  }) {
    final result = create();
    if (images != null) result.images.addAll(images);
    if (objects != null) result.objects = objects;
    return result;
  }

  Artifacts._();

  factory Artifacts.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Artifacts.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Artifacts',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.cloudbuild.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'images')
    ..aOM<Artifacts_ArtifactObjects>(2, _omitFieldNames ? '' : 'objects',
        subBuilder: Artifacts_ArtifactObjects.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Artifacts clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Artifacts copyWith(void Function(Artifacts) updates) =>
      super.copyWith((message) => updates(message as Artifacts)) as Artifacts;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Artifacts create() => Artifacts._();
  @$core.override
  Artifacts createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Artifacts getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Artifacts>(create);
  static Artifacts? _defaultInstance;

  /// A list of images to be pushed upon the successful completion of all build
  /// steps.
  ///
  /// The images will be pushed using the builder service account's credentials.
  ///
  /// The digests of the pushed images will be stored in the Build resource's
  /// results field.
  ///
  /// If any of the images fail to be pushed, the build is marked FAILURE.
  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get images => $_getList(0);

  /// A list of objects to be uploaded to Cloud Storage upon successful
  /// completion of all build steps.
  ///
  /// Files in the workspace matching specified paths globs will be uploaded to
  /// the specified Cloud Storage location using the builder service account's
  /// credentials.
  ///
  /// The location and generation of the uploaded objects will be stored in the
  /// Build resource's results field.
  ///
  /// If any objects fail to be pushed, the build is marked FAILURE.
  @$pb.TagNumber(2)
  Artifacts_ArtifactObjects get objects => $_getN(1);
  @$pb.TagNumber(2)
  set objects(Artifacts_ArtifactObjects value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasObjects() => $_has(1);
  @$pb.TagNumber(2)
  void clearObjects() => $_clearField(2);
  @$pb.TagNumber(2)
  Artifacts_ArtifactObjects ensureObjects() => $_ensure(1);
}

/// Start and end times for a build execution phase.
class TimeSpan extends $pb.GeneratedMessage {
  factory TimeSpan({
    $0.Timestamp? startTime,
    $0.Timestamp? endTime,
  }) {
    final result = create();
    if (startTime != null) result.startTime = startTime;
    if (endTime != null) result.endTime = endTime;
    return result;
  }

  TimeSpan._();

  factory TimeSpan.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TimeSpan.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TimeSpan',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.cloudbuild.v1'),
      createEmptyInstance: create)
    ..aOM<$0.Timestamp>(1, _omitFieldNames ? '' : 'startTime',
        subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(2, _omitFieldNames ? '' : 'endTime',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimeSpan clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimeSpan copyWith(void Function(TimeSpan) updates) =>
      super.copyWith((message) => updates(message as TimeSpan)) as TimeSpan;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TimeSpan create() => TimeSpan._();
  @$core.override
  TimeSpan createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TimeSpan getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimeSpan>(create);
  static TimeSpan? _defaultInstance;

  /// Start of time span.
  @$pb.TagNumber(1)
  $0.Timestamp get startTime => $_getN(0);
  @$pb.TagNumber(1)
  set startTime($0.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStartTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartTime() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Timestamp ensureStartTime() => $_ensure(0);

  /// End of time span.
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
}

/// Provenance of the source. Ways to find the original source, or verify that
/// some source was used for this build.
class SourceProvenance extends $pb.GeneratedMessage {
  factory SourceProvenance({
    StorageSource? resolvedStorageSource,
    $core.Iterable<$core.MapEntry<$core.String, FileHashes>>? fileHashes,
    RepoSource? resolvedRepoSource,
  }) {
    final result = create();
    if (resolvedStorageSource != null)
      result.resolvedStorageSource = resolvedStorageSource;
    if (fileHashes != null) result.fileHashes.addEntries(fileHashes);
    if (resolvedRepoSource != null)
      result.resolvedRepoSource = resolvedRepoSource;
    return result;
  }

  SourceProvenance._();

  factory SourceProvenance.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SourceProvenance.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SourceProvenance',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.cloudbuild.v1'),
      createEmptyInstance: create)
    ..aOM<StorageSource>(3, _omitFieldNames ? '' : 'resolvedStorageSource',
        subBuilder: StorageSource.create)
    ..m<$core.String, FileHashes>(4, _omitFieldNames ? '' : 'fileHashes',
        entryClassName: 'SourceProvenance.FileHashesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: FileHashes.create,
        valueDefaultOrMaker: FileHashes.getDefault,
        packageName: const $pb.PackageName('google.events.cloud.cloudbuild.v1'))
    ..aOM<RepoSource>(6, _omitFieldNames ? '' : 'resolvedRepoSource',
        subBuilder: RepoSource.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SourceProvenance clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SourceProvenance copyWith(void Function(SourceProvenance) updates) =>
      super.copyWith((message) => updates(message as SourceProvenance))
          as SourceProvenance;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SourceProvenance create() => SourceProvenance._();
  @$core.override
  SourceProvenance createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SourceProvenance getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SourceProvenance>(create);
  static SourceProvenance? _defaultInstance;

  /// A copy of the build's `source.storage_source`, if exists, with any
  /// generations resolved.
  @$pb.TagNumber(3)
  StorageSource get resolvedStorageSource => $_getN(0);
  @$pb.TagNumber(3)
  set resolvedStorageSource(StorageSource value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasResolvedStorageSource() => $_has(0);
  @$pb.TagNumber(3)
  void clearResolvedStorageSource() => $_clearField(3);
  @$pb.TagNumber(3)
  StorageSource ensureResolvedStorageSource() => $_ensure(0);

  /// Hash(es) of the build source, which can be used to verify that
  /// the original source integrity was maintained in the build. Note that
  /// `FileHashes` will only be populated if `BuildOptions` has requested a
  /// `SourceProvenanceHash`.
  ///
  /// The keys to this map are file paths used as build source and the values
  /// contain the hash values for those files.
  ///
  /// If the build source came in a single package such as a gzipped tarfile
  /// (`.tar.gz`), the `FileHash` will be for the single path to that file.
  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, FileHashes> get fileHashes => $_getMap(1);

  /// A copy of the build's `source.repo_source`, if exists, with any
  /// revisions resolved.
  @$pb.TagNumber(6)
  RepoSource get resolvedRepoSource => $_getN(2);
  @$pb.TagNumber(6)
  set resolvedRepoSource(RepoSource value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasResolvedRepoSource() => $_has(2);
  @$pb.TagNumber(6)
  void clearResolvedRepoSource() => $_clearField(6);
  @$pb.TagNumber(6)
  RepoSource ensureResolvedRepoSource() => $_ensure(2);
}

/// Container message for hashes of byte content of files, used in
/// SourceProvenance messages to verify integrity of source input to the build.
class FileHashes extends $pb.GeneratedMessage {
  factory FileHashes({
    $core.Iterable<Hash>? fileHash,
  }) {
    final result = create();
    if (fileHash != null) result.fileHash.addAll(fileHash);
    return result;
  }

  FileHashes._();

  factory FileHashes.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FileHashes.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FileHashes',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.cloudbuild.v1'),
      createEmptyInstance: create)
    ..pPM<Hash>(1, _omitFieldNames ? '' : 'fileHash', subBuilder: Hash.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileHashes clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileHashes copyWith(void Function(FileHashes) updates) =>
      super.copyWith((message) => updates(message as FileHashes)) as FileHashes;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileHashes create() => FileHashes._();
  @$core.override
  FileHashes createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FileHashes getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FileHashes>(create);
  static FileHashes? _defaultInstance;

  /// Collection of file hashes.
  @$pb.TagNumber(1)
  $pb.PbList<Hash> get fileHash => $_getList(0);
}

/// Container message for hash values.
class Hash extends $pb.GeneratedMessage {
  factory Hash({
    Hash_HashType? type,
    $core.List<$core.int>? value,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (value != null) result.value = value;
    return result;
  }

  Hash._();

  factory Hash.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Hash.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Hash',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.cloudbuild.v1'),
      createEmptyInstance: create)
    ..aE<Hash_HashType>(1, _omitFieldNames ? '' : 'type',
        enumValues: Hash_HashType.values)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Hash clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Hash copyWith(void Function(Hash) updates) =>
      super.copyWith((message) => updates(message as Hash)) as Hash;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Hash create() => Hash._();
  @$core.override
  Hash createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Hash getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Hash>(create);
  static Hash? _defaultInstance;

  /// The type of hash that was performed.
  @$pb.TagNumber(1)
  Hash_HashType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(Hash_HashType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  /// The hash value.
  @$pb.TagNumber(2)
  $core.List<$core.int> get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
}

/// Pairs a set of secret environment variables containing encrypted
/// values with the Cloud KMS key to use to decrypt the value.
class Secret extends $pb.GeneratedMessage {
  factory Secret({
    $core.String? kmsKeyName,
    $core.Iterable<$core.MapEntry<$core.String, $core.List<$core.int>>>?
        secretEnv,
  }) {
    final result = create();
    if (kmsKeyName != null) result.kmsKeyName = kmsKeyName;
    if (secretEnv != null) result.secretEnv.addEntries(secretEnv);
    return result;
  }

  Secret._();

  factory Secret.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Secret.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Secret',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.cloudbuild.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'kmsKeyName')
    ..m<$core.String, $core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'secretEnv',
        entryClassName: 'Secret.SecretEnvEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OY,
        packageName: const $pb.PackageName('google.events.cloud.cloudbuild.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Secret clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Secret copyWith(void Function(Secret) updates) =>
      super.copyWith((message) => updates(message as Secret)) as Secret;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Secret create() => Secret._();
  @$core.override
  Secret createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Secret getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Secret>(create);
  static Secret? _defaultInstance;

  /// Cloud KMS key name to use to decrypt these envs.
  @$pb.TagNumber(1)
  $core.String get kmsKeyName => $_getSZ(0);
  @$pb.TagNumber(1)
  set kmsKeyName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKmsKeyName() => $_has(0);
  @$pb.TagNumber(1)
  void clearKmsKeyName() => $_clearField(1);

  /// Map of environment variable name to its encrypted value.
  ///
  /// Secret environment variables must be unique across all of a build's
  /// secrets, and must be used by at least one build step. Values can be at most
  /// 64 KB in size. There can be at most 100 secret values across all of a
  /// build's secrets.
  @$pb.TagNumber(3)
  $pb.PbMap<$core.String, $core.List<$core.int>> get secretEnv => $_getMap(1);
}

/// Optional arguments to enable specific features of builds.
class BuildOptions extends $pb.GeneratedMessage {
  factory BuildOptions({
    $core.Iterable<Hash_HashType>? sourceProvenanceHash,
    BuildOptions_VerifyOption? requestedVerifyOption,
    BuildOptions_MachineType? machineType,
    BuildOptions_SubstitutionOption? substitutionOption,
    BuildOptions_LogStreamingOption? logStreamingOption,
    $fixnum.Int64? diskSizeGb,
    $core.String? workerPool,
    BuildOptions_LoggingMode? logging,
    $core.Iterable<$core.String>? env,
    $core.Iterable<$core.String>? secretEnv,
    $core.Iterable<Volume>? volumes,
  }) {
    final result = create();
    if (sourceProvenanceHash != null)
      result.sourceProvenanceHash.addAll(sourceProvenanceHash);
    if (requestedVerifyOption != null)
      result.requestedVerifyOption = requestedVerifyOption;
    if (machineType != null) result.machineType = machineType;
    if (substitutionOption != null)
      result.substitutionOption = substitutionOption;
    if (logStreamingOption != null)
      result.logStreamingOption = logStreamingOption;
    if (diskSizeGb != null) result.diskSizeGb = diskSizeGb;
    if (workerPool != null) result.workerPool = workerPool;
    if (logging != null) result.logging = logging;
    if (env != null) result.env.addAll(env);
    if (secretEnv != null) result.secretEnv.addAll(secretEnv);
    if (volumes != null) result.volumes.addAll(volumes);
    return result;
  }

  BuildOptions._();

  factory BuildOptions.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuildOptions.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuildOptions',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.events.cloud.cloudbuild.v1'),
      createEmptyInstance: create)
    ..pc<Hash_HashType>(
        1, _omitFieldNames ? '' : 'sourceProvenanceHash', $pb.PbFieldType.KE,
        valueOf: Hash_HashType.valueOf,
        enumValues: Hash_HashType.values,
        defaultEnumValue: Hash_HashType.NONE)
    ..aE<BuildOptions_VerifyOption>(
        2, _omitFieldNames ? '' : 'requestedVerifyOption',
        enumValues: BuildOptions_VerifyOption.values)
    ..aE<BuildOptions_MachineType>(3, _omitFieldNames ? '' : 'machineType',
        enumValues: BuildOptions_MachineType.values)
    ..aE<BuildOptions_SubstitutionOption>(
        4, _omitFieldNames ? '' : 'substitutionOption',
        enumValues: BuildOptions_SubstitutionOption.values)
    ..aE<BuildOptions_LogStreamingOption>(
        5, _omitFieldNames ? '' : 'logStreamingOption',
        enumValues: BuildOptions_LogStreamingOption.values)
    ..aInt64(6, _omitFieldNames ? '' : 'diskSizeGb')
    ..aOS(7, _omitFieldNames ? '' : 'workerPool')
    ..aE<BuildOptions_LoggingMode>(11, _omitFieldNames ? '' : 'logging',
        enumValues: BuildOptions_LoggingMode.values)
    ..pPS(12, _omitFieldNames ? '' : 'env')
    ..pPS(13, _omitFieldNames ? '' : 'secretEnv')
    ..pPM<Volume>(14, _omitFieldNames ? '' : 'volumes',
        subBuilder: Volume.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuildOptions clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuildOptions copyWith(void Function(BuildOptions) updates) =>
      super.copyWith((message) => updates(message as BuildOptions))
          as BuildOptions;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuildOptions create() => BuildOptions._();
  @$core.override
  BuildOptions createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BuildOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuildOptions>(create);
  static BuildOptions? _defaultInstance;

  /// Requested hash for SourceProvenance.
  @$pb.TagNumber(1)
  $pb.PbList<Hash_HashType> get sourceProvenanceHash => $_getList(0);

  /// Requested verifiability options.
  @$pb.TagNumber(2)
  BuildOptions_VerifyOption get requestedVerifyOption => $_getN(1);
  @$pb.TagNumber(2)
  set requestedVerifyOption(BuildOptions_VerifyOption value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRequestedVerifyOption() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequestedVerifyOption() => $_clearField(2);

  /// Compute Engine machine type on which to run the build.
  @$pb.TagNumber(3)
  BuildOptions_MachineType get machineType => $_getN(2);
  @$pb.TagNumber(3)
  set machineType(BuildOptions_MachineType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasMachineType() => $_has(2);
  @$pb.TagNumber(3)
  void clearMachineType() => $_clearField(3);

  /// Option to specify behavior when there is an error in the substitution
  /// checks.
  @$pb.TagNumber(4)
  BuildOptions_SubstitutionOption get substitutionOption => $_getN(3);
  @$pb.TagNumber(4)
  set substitutionOption(BuildOptions_SubstitutionOption value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSubstitutionOption() => $_has(3);
  @$pb.TagNumber(4)
  void clearSubstitutionOption() => $_clearField(4);

  /// Option to define build log streaming behavior to Google Cloud
  /// Storage.
  @$pb.TagNumber(5)
  BuildOptions_LogStreamingOption get logStreamingOption => $_getN(4);
  @$pb.TagNumber(5)
  set logStreamingOption(BuildOptions_LogStreamingOption value) =>
      $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasLogStreamingOption() => $_has(4);
  @$pb.TagNumber(5)
  void clearLogStreamingOption() => $_clearField(5);

  /// Requested disk size for the VM that runs the build. Note that this is *NOT*
  /// "disk free"; some of the space will be used by the operating system and
  /// build utilities. Also note that this is the minimum disk size that will be
  /// allocated for the build -- the build may run with a larger disk than
  /// requested. At present, the maximum disk size is 1000GB; builds that request
  /// more than the maximum are rejected with an error.
  @$pb.TagNumber(6)
  $fixnum.Int64 get diskSizeGb => $_getI64(5);
  @$pb.TagNumber(6)
  set diskSizeGb($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDiskSizeGb() => $_has(5);
  @$pb.TagNumber(6)
  void clearDiskSizeGb() => $_clearField(6);

  /// Option to specify a `WorkerPool` for the build.
  /// Format: projects/{project}/locations/{location}/workerPools/{workerPool}
  @$pb.TagNumber(7)
  $core.String get workerPool => $_getSZ(6);
  @$pb.TagNumber(7)
  set workerPool($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasWorkerPool() => $_has(6);
  @$pb.TagNumber(7)
  void clearWorkerPool() => $_clearField(7);

  /// Option to specify the logging mode, which determines where the logs are
  /// stored.
  @$pb.TagNumber(11)
  BuildOptions_LoggingMode get logging => $_getN(7);
  @$pb.TagNumber(11)
  set logging(BuildOptions_LoggingMode value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasLogging() => $_has(7);
  @$pb.TagNumber(11)
  void clearLogging() => $_clearField(11);

  /// A list of global environment variable definitions that will exist for all
  /// build steps in this build. If a variable is defined in both globally and in
  /// a build step, the variable will use the build step value.
  ///
  /// The elements are of the form "KEY=VALUE" for the environment variable "KEY"
  /// being given the value "VALUE".
  @$pb.TagNumber(12)
  $pb.PbList<$core.String> get env => $_getList(8);

  /// A list of global environment variables, which are encrypted using a Cloud
  /// Key Management Service crypto key. These values must be specified in the
  /// build's `Secret`. These variables will be available to all build steps
  /// in this build.
  @$pb.TagNumber(13)
  $pb.PbList<$core.String> get secretEnv => $_getList(9);

  /// Global list of volumes to mount for ALL build steps
  ///
  /// Each volume is created as an empty volume prior to starting the build
  /// process. Upon completion of the build, volumes and their contents are
  /// discarded. Global volume names and paths cannot conflict with the volumes
  /// defined a build step.
  ///
  /// Using a global volume in a build with only one step is not valid as
  /// it is indicative of a build request with an incorrect configuration.
  @$pb.TagNumber(14)
  $pb.PbList<Volume> get volumes => $_getList(10);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
