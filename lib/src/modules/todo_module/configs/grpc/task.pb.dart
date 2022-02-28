///
//  Generated code. Do not modify.
//  source: task.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class TaskFetchQueryParamsGrpcModel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TaskFetchQueryParamsGrpcModel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'gRPC'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  TaskFetchQueryParamsGrpcModel._() : super();
  factory TaskFetchQueryParamsGrpcModel() => create();
  factory TaskFetchQueryParamsGrpcModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TaskFetchQueryParamsGrpcModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TaskFetchQueryParamsGrpcModel clone() => TaskFetchQueryParamsGrpcModel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TaskFetchQueryParamsGrpcModel copyWith(void Function(TaskFetchQueryParamsGrpcModel) updates) => super.copyWith((message) => updates(message as TaskFetchQueryParamsGrpcModel)) as TaskFetchQueryParamsGrpcModel; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TaskFetchQueryParamsGrpcModel create() => TaskFetchQueryParamsGrpcModel._();
  TaskFetchQueryParamsGrpcModel createEmptyInstance() => create();
  static $pb.PbList<TaskFetchQueryParamsGrpcModel> createRepeated() => $pb.PbList<TaskFetchQueryParamsGrpcModel>();
  @$core.pragma('dart2js:noInline')
  static TaskFetchQueryParamsGrpcModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TaskFetchQueryParamsGrpcModel>(create);
  static TaskFetchQueryParamsGrpcModel? _defaultInstance;
}

class TaskFetchResponseGrpcModel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TaskFetchResponseGrpcModel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'gRPC'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageUrl', protoName: 'imageUrl')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isDone', protoName: 'isDone')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', protoName: 'createdAt')
    ..hasRequiredFields = false
  ;

  TaskFetchResponseGrpcModel._() : super();
  factory TaskFetchResponseGrpcModel({
    $core.String? id,
    $core.String? title,
    $core.String? imageUrl,
    $core.bool? isDone,
    $core.String? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (title != null) {
      _result.title = title;
    }
    if (imageUrl != null) {
      _result.imageUrl = imageUrl;
    }
    if (isDone != null) {
      _result.isDone = isDone;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory TaskFetchResponseGrpcModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TaskFetchResponseGrpcModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TaskFetchResponseGrpcModel clone() => TaskFetchResponseGrpcModel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TaskFetchResponseGrpcModel copyWith(void Function(TaskFetchResponseGrpcModel) updates) => super.copyWith((message) => updates(message as TaskFetchResponseGrpcModel)) as TaskFetchResponseGrpcModel; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TaskFetchResponseGrpcModel create() => TaskFetchResponseGrpcModel._();
  TaskFetchResponseGrpcModel createEmptyInstance() => create();
  static $pb.PbList<TaskFetchResponseGrpcModel> createRepeated() => $pb.PbList<TaskFetchResponseGrpcModel>();
  @$core.pragma('dart2js:noInline')
  static TaskFetchResponseGrpcModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TaskFetchResponseGrpcModel>(create);
  static TaskFetchResponseGrpcModel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get imageUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set imageUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasImageUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearImageUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isDone => $_getBF(3);
  @$pb.TagNumber(4)
  set isDone($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsDone() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsDone() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get createdAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set createdAt($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => clearField(5);
}

class TaskFetchTotalRecordsResponseGrpcModel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TaskFetchTotalRecordsResponseGrpcModel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'gRPC'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalRecords', protoName: 'totalRecords')
    ..hasRequiredFields = false
  ;

  TaskFetchTotalRecordsResponseGrpcModel._() : super();
  factory TaskFetchTotalRecordsResponseGrpcModel({
    $fixnum.Int64? totalRecords,
  }) {
    final _result = create();
    if (totalRecords != null) {
      _result.totalRecords = totalRecords;
    }
    return _result;
  }
  factory TaskFetchTotalRecordsResponseGrpcModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TaskFetchTotalRecordsResponseGrpcModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TaskFetchTotalRecordsResponseGrpcModel clone() => TaskFetchTotalRecordsResponseGrpcModel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TaskFetchTotalRecordsResponseGrpcModel copyWith(void Function(TaskFetchTotalRecordsResponseGrpcModel) updates) => super.copyWith((message) => updates(message as TaskFetchTotalRecordsResponseGrpcModel)) as TaskFetchTotalRecordsResponseGrpcModel; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TaskFetchTotalRecordsResponseGrpcModel create() => TaskFetchTotalRecordsResponseGrpcModel._();
  TaskFetchTotalRecordsResponseGrpcModel createEmptyInstance() => create();
  static $pb.PbList<TaskFetchTotalRecordsResponseGrpcModel> createRepeated() => $pb.PbList<TaskFetchTotalRecordsResponseGrpcModel>();
  @$core.pragma('dart2js:noInline')
  static TaskFetchTotalRecordsResponseGrpcModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TaskFetchTotalRecordsResponseGrpcModel>(create);
  static TaskFetchTotalRecordsResponseGrpcModel? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get totalRecords => $_getI64(0);
  @$pb.TagNumber(1)
  set totalRecords($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalRecords() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalRecords() => clearField(1);
}

class TaskFetchMetaDataResponseGrpcModel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TaskFetchMetaDataResponseGrpcModel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'gRPC'), createEmptyInstance: create)
    ..aOM<TaskFetchTotalRecordsResponseGrpcModel>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: TaskFetchTotalRecordsResponseGrpcModel.create)
    ..hasRequiredFields = false
  ;

  TaskFetchMetaDataResponseGrpcModel._() : super();
  factory TaskFetchMetaDataResponseGrpcModel({
    TaskFetchTotalRecordsResponseGrpcModel? pagination,
  }) {
    final _result = create();
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory TaskFetchMetaDataResponseGrpcModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TaskFetchMetaDataResponseGrpcModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TaskFetchMetaDataResponseGrpcModel clone() => TaskFetchMetaDataResponseGrpcModel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TaskFetchMetaDataResponseGrpcModel copyWith(void Function(TaskFetchMetaDataResponseGrpcModel) updates) => super.copyWith((message) => updates(message as TaskFetchMetaDataResponseGrpcModel)) as TaskFetchMetaDataResponseGrpcModel; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TaskFetchMetaDataResponseGrpcModel create() => TaskFetchMetaDataResponseGrpcModel._();
  TaskFetchMetaDataResponseGrpcModel createEmptyInstance() => create();
  static $pb.PbList<TaskFetchMetaDataResponseGrpcModel> createRepeated() => $pb.PbList<TaskFetchMetaDataResponseGrpcModel>();
  @$core.pragma('dart2js:noInline')
  static TaskFetchMetaDataResponseGrpcModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TaskFetchMetaDataResponseGrpcModel>(create);
  static TaskFetchMetaDataResponseGrpcModel? _defaultInstance;

  @$pb.TagNumber(1)
  TaskFetchTotalRecordsResponseGrpcModel get pagination => $_getN(0);
  @$pb.TagNumber(1)
  set pagination(TaskFetchTotalRecordsResponseGrpcModel v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPagination() => $_has(0);
  @$pb.TagNumber(1)
  void clearPagination() => clearField(1);
  @$pb.TagNumber(1)
  TaskFetchTotalRecordsResponseGrpcModel ensurePagination() => $_ensure(0);
}

class GrpcResponseSuccessWithMetaDataModel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GrpcResponseSuccessWithMetaDataModel', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'gRPC'), createEmptyInstance: create)
    ..pc<TaskFetchResponseGrpcModel>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', $pb.PbFieldType.PM, subBuilder: TaskFetchResponseGrpcModel.create)
    ..aOM<TaskFetchMetaDataResponseGrpcModel>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metaData', protoName: 'metaData', subBuilder: TaskFetchMetaDataResponseGrpcModel.create)
    ..hasRequiredFields = false
  ;

  GrpcResponseSuccessWithMetaDataModel._() : super();
  factory GrpcResponseSuccessWithMetaDataModel({
    $core.Iterable<TaskFetchResponseGrpcModel>? data,
    TaskFetchMetaDataResponseGrpcModel? metaData,
  }) {
    final _result = create();
    if (data != null) {
      _result.data.addAll(data);
    }
    if (metaData != null) {
      _result.metaData = metaData;
    }
    return _result;
  }
  factory GrpcResponseSuccessWithMetaDataModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GrpcResponseSuccessWithMetaDataModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GrpcResponseSuccessWithMetaDataModel clone() => GrpcResponseSuccessWithMetaDataModel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GrpcResponseSuccessWithMetaDataModel copyWith(void Function(GrpcResponseSuccessWithMetaDataModel) updates) => super.copyWith((message) => updates(message as GrpcResponseSuccessWithMetaDataModel)) as GrpcResponseSuccessWithMetaDataModel; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GrpcResponseSuccessWithMetaDataModel create() => GrpcResponseSuccessWithMetaDataModel._();
  GrpcResponseSuccessWithMetaDataModel createEmptyInstance() => create();
  static $pb.PbList<GrpcResponseSuccessWithMetaDataModel> createRepeated() => $pb.PbList<GrpcResponseSuccessWithMetaDataModel>();
  @$core.pragma('dart2js:noInline')
  static GrpcResponseSuccessWithMetaDataModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GrpcResponseSuccessWithMetaDataModel>(create);
  static GrpcResponseSuccessWithMetaDataModel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TaskFetchResponseGrpcModel> get data => $_getList(0);

  @$pb.TagNumber(2)
  TaskFetchMetaDataResponseGrpcModel get metaData => $_getN(1);
  @$pb.TagNumber(2)
  set metaData(TaskFetchMetaDataResponseGrpcModel v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMetaData() => $_has(1);
  @$pb.TagNumber(2)
  void clearMetaData() => clearField(2);
  @$pb.TagNumber(2)
  TaskFetchMetaDataResponseGrpcModel ensureMetaData() => $_ensure(1);
}

