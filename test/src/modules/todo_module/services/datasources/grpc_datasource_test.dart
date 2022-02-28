import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/commons/errors/datasource_error.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/configs/grpc/task.pbgrpc.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/services/datasources/grpc_datasource.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/services/models/task_get_datasource_model.dart';
import 'package:flutter_starter_kit/src/utils/grpc/grpc_util.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../utils/grpc/grpc_util_test.mocks.dart';

class FakeResponseFuture<T> extends Mock implements ResponseFuture<T> {
  FakeResponseFuture(this.value);

  final T value;

  @override
  Future<S> then<S>(
    FutureOr<S> Function(T value) onValue, {
    Function? onError,
  }) =>
      Future<T>.value(value).then(onValue, onError: onError);
}

class FakeTaskServiceClient extends Mock implements TaskServiceClient {
  @override
  ResponseFuture<GrpcResponseSuccessWithMetaDataModel> taskFetchHandler(
    TaskFetchQueryParamsGrpcModel request, {
    CallOptions? options,
  }) {
    return FakeResponseFuture<GrpcResponseSuccessWithMetaDataModel>(
      expectGetTasksResponse,
    );
  }
}

class FakeGprcDataSource extends Mock implements GprcDataSource {
  @override
  Future<List<TaskGetResponseDataSourceModel>?> get({
    required TaskGetRequestDataSourceModel query,
  }) async {
    return expectTaskGetResponseDataSourceModelList;
  }
}

class FakeGprcDataSourceFail extends Mock implements GprcDataSource {
  @override
  Future<List<TaskGetResponseDataSourceModel>?> get({
    required TaskGetRequestDataSourceModel query,
  }) async {
    throw expectGrpcClientUtilError;
  }
}

@GenerateMocks(<Type>[ClientChannelBase])
void main() {
  final MockGrpcClientUtil mockGrpcClientUtil = MockGrpcClientUtil();
  final GprcDataSource expectGprcDataSource =
      GprcDataSource(grpcClient: mockGrpcClientUtil);
  final FakeTaskServiceClient mockTaskServiceClient = FakeTaskServiceClient();
  final MockClientChannelBase mockClientChannelBase = MockClientChannelBase();

  setUpAll(() async {
    dotenv.testLoad();
  });

  group('GprcDataSource Class', () {
    test('Should have GprcDataSource Class', () {
      expect(GprcDataSource, GprcDataSource);
    });

    test('Should have mandatory properties', () {
      expect(expectGprcDataSource.grpcClient, mockGrpcClientUtil);
    });
  });

  group('Get method', () {
    test('Should have get method - Success case', () async {
      final FakeGprcDataSource expectFakeGprcDataSource = FakeGprcDataSource();
      when(
        mockGrpcClientUtil.createChannel(
          host: 'localhost',
          port: 50051,
        ),
      ).thenReturn(mockClientChannelBase);

      final GrpcResponseSuccessWithMetaDataModel expectValueTaskServiceClient =
          await mockTaskServiceClient.taskFetchHandler(
        TaskFetchQueryParamsGrpcModel(),
      );

      expect(expectValueTaskServiceClient, expectGetTasksResponse);

      final List<TaskGetResponseDataSourceModel>? expectValue =
          await expectFakeGprcDataSource.get(
        query: expectTaskGetRequestDataSourceModel,
      );

      expect(expectValue, expectTaskGetResponseDataSourceModelList);
    });

    test('Should have get method - Failure case', () async {
      final FakeGprcDataSourceFail expectFakeGprcDataSourceFail =
          FakeGprcDataSourceFail();

      expect(
        () async => expectFakeGprcDataSourceFail.get(
          query: expectTaskGetRequestDataSourceModel,
        ),
        throwsA(isA<GrpcClientUtilError>()),
      );

      expect(
        () async => expectFakeGprcDataSourceFail.get(
          query: expectTaskGetRequestDataSourceModel,
        ),
        throwsA(
          predicate(
            (Error e) =>
                e is GrpcClientUtilError &&
                e.toString().contains(expectGrpcClientUtilError.toString()),
          ),
        ),
      );
    });
  });

  group('Update method', () {
    test('Should have update method - Failure case', () async {
      expect(
        () async => expectGprcDataSource.update(
          queryParams: expectTaskUpdateQueryParamsRequestDataSourceModel,
          task: expectTaskUpdateRequestDataSourceModel,
        ),
        throwsA(isA<DataSourceError>()),
      );
    });
  });

  group('Delete method', () {
    test('Should have delete method - Failure case', () async {
      expect(
        () async => expectGprcDataSource.delete(
          queryParams: expectTaskDeleteQueryParamsRequestDataSourceModel,
        ),
        throwsA(isA<DataSourceError>()),
      );
    });
  });

  group('Create method', () {
    test('Should have create method - Failure case', () async {
      expect(
        () async => expectGprcDataSource.create(
          task: expectTaskCreateRequestDataSourceModel,
        ),
        throwsA(isA<DataSourceError>()),
      );
    });
  });
}
