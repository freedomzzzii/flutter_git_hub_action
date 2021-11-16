///
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class GetTasksParams extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetTasksParams',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'gRPC'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  GetTasksParams._() : super();

  factory GetTasksParams() => create();

  factory GetTasksParams.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory GetTasksParams.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetTasksParams clone() => GetTasksParams()..mergeFromMessage(this);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetTasksParams copyWith(void Function(GetTasksParams) updates) =>
      super.copyWith((message) => updates(message as GetTasksParams))
          as GetTasksParams; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTasksParams create() => GetTasksParams._();

  GetTasksParams createEmptyInstance() => create();

  static $pb.PbList<GetTasksParams> createRepeated() =>
      $pb.PbList<GetTasksParams>();

  @$core.pragma('dart2js:noInline')
  static GetTasksParams getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTasksParams>(create);
  static GetTasksParams? _defaultInstance;
}

class Task extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Task',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'gRPC'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'id')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'title')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'imageUrl',
        protoName: 'imageUrl')
    ..aOB(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'isDone',
        protoName: 'isDone')
    ..aOS(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'createdAt',
        protoName: 'createdAt')
    ..hasRequiredFields = false;

  Task._() : super();

  factory Task({
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

  factory Task.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory Task.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Task clone() => Task()..mergeFromMessage(this);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Task copyWith(void Function(Task) updates) =>
      super.copyWith((message) => updates(message as Task))
          as Task; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Task create() => Task._();

  Task createEmptyInstance() => create();

  static $pb.PbList<Task> createRepeated() => $pb.PbList<Task>();

  @$core.pragma('dart2js:noInline')
  static Task getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Task>(create);
  static Task? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);

  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);

  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);

  @$pb.TagNumber(2)
  set title($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);

  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get imageUrl => $_getSZ(2);

  @$pb.TagNumber(3)
  set imageUrl($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasImageUrl() => $_has(2);

  @$pb.TagNumber(3)
  void clearImageUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isDone => $_getBF(3);

  @$pb.TagNumber(4)
  set isDone($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasIsDone() => $_has(3);

  @$pb.TagNumber(4)
  void clearIsDone() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get createdAt => $_getSZ(4);

  @$pb.TagNumber(5)
  set createdAt($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);

  @$pb.TagNumber(5)
  void clearCreatedAt() => clearField(5);
}

class TaskFetchTotalRecordsMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'TaskFetchTotalRecordsMessage',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'gRPC'),
      createEmptyInstance: create)
    ..aInt64(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'totalRecords',
        protoName: 'totalRecords')
    ..hasRequiredFields = false;

  TaskFetchTotalRecordsMessage._() : super();

  factory TaskFetchTotalRecordsMessage({
    $fixnum.Int64? totalRecords,
  }) {
    final _result = create();
    if (totalRecords != null) {
      _result.totalRecords = totalRecords;
    }
    return _result;
  }

  factory TaskFetchTotalRecordsMessage.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory TaskFetchTotalRecordsMessage.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TaskFetchTotalRecordsMessage clone() =>
      TaskFetchTotalRecordsMessage()..mergeFromMessage(this);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TaskFetchTotalRecordsMessage copyWith(
          void Function(TaskFetchTotalRecordsMessage) updates) =>
      super.copyWith(
              (message) => updates(message as TaskFetchTotalRecordsMessage))
          as TaskFetchTotalRecordsMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TaskFetchTotalRecordsMessage create() =>
      TaskFetchTotalRecordsMessage._();

  TaskFetchTotalRecordsMessage createEmptyInstance() => create();

  static $pb.PbList<TaskFetchTotalRecordsMessage> createRepeated() =>
      $pb.PbList<TaskFetchTotalRecordsMessage>();

  @$core.pragma('dart2js:noInline')
  static TaskFetchTotalRecordsMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TaskFetchTotalRecordsMessage>(create);
  static TaskFetchTotalRecordsMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get totalRecords => $_getI64(0);

  @$pb.TagNumber(1)
  set totalRecords($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTotalRecords() => $_has(0);

  @$pb.TagNumber(1)
  void clearTotalRecords() => clearField(1);
}

class TaskFetchMetaDataMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'TaskFetchMetaDataMessage',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'gRPC'),
      createEmptyInstance: create)
    ..aOM<TaskFetchTotalRecordsMessage>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'pagination',
        subBuilder: TaskFetchTotalRecordsMessage.create)
    ..hasRequiredFields = false;

  TaskFetchMetaDataMessage._() : super();

  factory TaskFetchMetaDataMessage({
    TaskFetchTotalRecordsMessage? pagination,
  }) {
    final _result = create();
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }

  factory TaskFetchMetaDataMessage.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory TaskFetchMetaDataMessage.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TaskFetchMetaDataMessage clone() =>
      TaskFetchMetaDataMessage()..mergeFromMessage(this);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TaskFetchMetaDataMessage copyWith(
          void Function(TaskFetchMetaDataMessage) updates) =>
      super.copyWith((message) => updates(message as TaskFetchMetaDataMessage))
          as TaskFetchMetaDataMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TaskFetchMetaDataMessage create() => TaskFetchMetaDataMessage._();

  TaskFetchMetaDataMessage createEmptyInstance() => create();

  static $pb.PbList<TaskFetchMetaDataMessage> createRepeated() =>
      $pb.PbList<TaskFetchMetaDataMessage>();

  @$core.pragma('dart2js:noInline')
  static TaskFetchMetaDataMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TaskFetchMetaDataMessage>(create);
  static TaskFetchMetaDataMessage? _defaultInstance;

  @$pb.TagNumber(1)
  TaskFetchTotalRecordsMessage get pagination => $_getN(0);

  @$pb.TagNumber(1)
  set pagination(TaskFetchTotalRecordsMessage v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPagination() => $_has(0);

  @$pb.TagNumber(1)
  void clearPagination() => clearField(1);

  @$pb.TagNumber(1)
  TaskFetchTotalRecordsMessage ensurePagination() => $_ensure(0);
}

class TaskFetchWithMetaDataMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'TaskFetchWithMetaDataMessage',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'gRPC'),
      createEmptyInstance: create)
    ..pc<Task>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'data',
        $pb.PbFieldType.PM,
        subBuilder: Task.create)
    ..aOM<TaskFetchMetaDataMessage>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'metaData',
        protoName: 'metaData',
        subBuilder: TaskFetchMetaDataMessage.create)
    ..hasRequiredFields = false;

  TaskFetchWithMetaDataMessage._() : super();

  factory TaskFetchWithMetaDataMessage({
    $core.Iterable<Task>? data,
    TaskFetchMetaDataMessage? metaData,
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

  factory TaskFetchWithMetaDataMessage.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory TaskFetchWithMetaDataMessage.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TaskFetchWithMetaDataMessage clone() =>
      TaskFetchWithMetaDataMessage()..mergeFromMessage(this);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TaskFetchWithMetaDataMessage copyWith(
          void Function(TaskFetchWithMetaDataMessage) updates) =>
      super.copyWith(
              (message) => updates(message as TaskFetchWithMetaDataMessage))
          as TaskFetchWithMetaDataMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TaskFetchWithMetaDataMessage create() =>
      TaskFetchWithMetaDataMessage._();

  TaskFetchWithMetaDataMessage createEmptyInstance() => create();

  static $pb.PbList<TaskFetchWithMetaDataMessage> createRepeated() =>
      $pb.PbList<TaskFetchWithMetaDataMessage>();

  @$core.pragma('dart2js:noInline')
  static TaskFetchWithMetaDataMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TaskFetchWithMetaDataMessage>(create);
  static TaskFetchWithMetaDataMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Task> get data => $_getList(0);

  @$pb.TagNumber(2)
  TaskFetchMetaDataMessage get metaData => $_getN(1);

  @$pb.TagNumber(2)
  set metaData(TaskFetchMetaDataMessage v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMetaData() => $_has(1);

  @$pb.TagNumber(2)
  void clearMetaData() => clearField(2);

  @$pb.TagNumber(2)
  TaskFetchMetaDataMessage ensureMetaData() => $_ensure(1);
}
