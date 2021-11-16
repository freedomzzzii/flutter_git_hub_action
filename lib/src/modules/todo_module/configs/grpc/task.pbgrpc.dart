///
import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;

import 'task.pb.dart' as $0;

export 'task.pb.dart';

class TaskServiceClient extends $grpc.Client {
  static final _$getTasks =
      $grpc.ClientMethod<$0.GetTasksParams, $0.TaskFetchWithMetaDataMessage>(
          '/gRPC.TaskService/GetTasks',
          ($0.GetTasksParams value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.TaskFetchWithMetaDataMessage.fromBuffer(value));

  TaskServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.TaskFetchWithMetaDataMessage> getTasks(
      $0.GetTasksParams request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTasks, request, options: options);
  }
}

abstract class TaskServiceBase extends $grpc.Service {
  $core.String get $name => 'gRPC.TaskService';

  TaskServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.GetTasksParams, $0.TaskFetchWithMetaDataMessage>(
            'GetTasks',
            getTasks_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetTasksParams.fromBuffer(value),
            ($0.TaskFetchWithMetaDataMessage value) => value.writeToBuffer()));
  }

  $async.Future<$0.TaskFetchWithMetaDataMessage> getTasks_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GetTasksParams> request) async {
    return getTasks(call, await request);
  }

  $async.Future<$0.TaskFetchWithMetaDataMessage> getTasks(
      $grpc.ServiceCall call, $0.GetTasksParams request);
}
