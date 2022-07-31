import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grpc/grpc_connection_interface.dart';

import '../../../../commons/constants/env_constant.dart';
import '../../../../utils/error_code/error_code_util.dart';
import '../../../../utils/grpc/grpc_for_mobile_util.dart';
import '../../../../utils/grpc/grpc_util.dart';
import '../../commons/errors/datasource_error.dart';
import '../../configs/grpc/task.pbgrpc.dart';
import '../../domains/datasources/future_datasource.dart';
import '../models/task_create_datasource_model.dart';
import '../models/task_delete_datasource_model.dart';
import '../models/task_get_datasource_model.dart';
import '../models/task_update_datasource_model.dart';

class GprcDataSource implements FutureDataSource {
  GprcDataSource({required GrpcClientUtil grpcClient})
      : _grpcClient = grpcClient;

  final GrpcClientUtil _grpcClient;

  GrpcClientUtil get grpcClient => _grpcClient;

  @override
  Future<TaskCreateResponseDataSourceModel> create({
    required TaskCreateRequestDataSourceModel task,
  }) async {
    // do something
    throw DataSourceError(
      message: '',
      code: AppErrorCodes.unknownError,
    );
  }

  @override
  Future<List<TaskGetResponseDataSourceModel>?> get({
    required TaskGetRequestDataSourceModel query,
  }) async {
    try {
      final ClientChannelBase _channel = _grpcClient.createChannel(
        host: dotenv.get(
          _grpcClient is GrpcClientUtilForMobile
              ? grpcMobileDomainEnv
              : grpcWebDomainEnv,
          fallback: '',
        ),
        port: int.parse(
          dotenv.get(
            _grpcClient is GrpcClientUtilForMobile
                ? grpcMobilePortEnv
                : grpcWebPortEnv,
            fallback: '',
          ),
        ),
      );
      final TaskServiceClient _serviceClient = TaskServiceClient(_channel);

      final GrpcResponseSuccessWithMetaDataModel response = await _serviceClient
          .taskFetchHandler(TaskFetchQueryParamsGrpcModel());
      await _channel.shutdown();

      return response.data.map((TaskFetchResponseGrpcModel data) {
        return TaskGetResponseDataSourceModel(
          id: data.id,
          title: data.title,
          imageUrl: data.imageUrl,
          isDone: data.isDone,
          createdAt: DateTime.parse('${data.createdAt.split('+')[0]}Z'),
        );
      }).toList();
    } on GrpcError catch (e) {
      throw DataSourceError(
        message: e.message ?? e.toString(),
        code: getAppErrorCode(code: e.code),
      );
    } catch (e) {
      throw DataSourceError(
        message: e.toString(),
        code: AppErrorCodes.unknownError,
      );
    }
  }

  @override
  Future<TaskUpdateResponseDataSourceModel> update({
    required TaskUpdateQueryParamsRequestDataSourceModel queryParams,
    required TaskUpdateRequestDataSourceModel task,
  }) async {
    // do something
    throw DataSourceError(
      message: '',
      code: AppErrorCodes.unknownError,
    );
  }

  @override
  Future<void> delete({
    required TaskDeleteQueryParamsRequestDataSourceModel queryParams,
  }) async {
    // do something
    throw DataSourceError(
      message: '',
      code: AppErrorCodes.unknownError,
    );
  }
}
