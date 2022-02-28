///
//  Generated code. Do not modify.
//  source: task.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'task.pb.dart' as $0;
export 'task.pb.dart';

class TaskServiceClient extends $grpc.Client {
  static final _$taskFetchHandler = $grpc.ClientMethod<
          $0.TaskFetchQueryParamsGrpcModel,
          $0.GrpcResponseSuccessWithMetaDataModel>(
      '/gRPC.TaskService/TaskFetchHandler',
      ($0.TaskFetchQueryParamsGrpcModel value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GrpcResponseSuccessWithMetaDataModel.fromBuffer(value));

  TaskServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GrpcResponseSuccessWithMetaDataModel>
      taskFetchHandler($0.TaskFetchQueryParamsGrpcModel request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$taskFetchHandler, request, options: options);
  }
}

abstract class TaskServiceBase extends $grpc.Service {
  $core.String get $name => 'gRPC.TaskService';

  TaskServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.TaskFetchQueryParamsGrpcModel,
            $0.GrpcResponseSuccessWithMetaDataModel>(
        'TaskFetchHandler',
        taskFetchHandler_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.TaskFetchQueryParamsGrpcModel.fromBuffer(value),
        ($0.GrpcResponseSuccessWithMetaDataModel value) =>
            value.writeToBuffer()));
  }

  $async.Future<$0.GrpcResponseSuccessWithMetaDataModel> taskFetchHandler_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.TaskFetchQueryParamsGrpcModel> request) async {
    return taskFetchHandler(call, await request);
  }

  $async.Future<$0.GrpcResponseSuccessWithMetaDataModel> taskFetchHandler(
      $grpc.ServiceCall call, $0.TaskFetchQueryParamsGrpcModel request);
}
