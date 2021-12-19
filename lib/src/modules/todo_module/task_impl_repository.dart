import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:universal_html/html.dart';

import '../../commons/constants/api_constant.dart';
import '../../commons/constants/env_constant.dart';
import '../../utils/error_code/error_code_util.dart';
import 'commons/errors/repository_error.dart';
import 'domains/datasources/datasource.dart';
import 'domains/datasources/stream_datasource.dart';
import 'domains/entities/task_create_entity.dart';
import 'domains/entities/task_delete_entity.dart';
import 'domains/entities/task_get_entity.dart';
import 'domains/entities/task_update_entity.dart';
import 'domains/repositories/task_repository.dart';
import 'domains/repositories/task_sse_repository.dart';
import 'services/models/task_create_datasource_model.dart';
import 'services/models/task_delete_datasource_model.dart';
import 'services/models/task_get_datasource_model.dart';
import 'services/models/task_update_datasource_model.dart';

class TaskImplRepository implements TaskRepository {
  TaskImplRepository({required DataSource dataSource})
      : _dataSource = dataSource;

  final DataSource _dataSource;

  DataSource get dataSource => _dataSource;

  @override
  Future<TaskCreateResponseEntity> create({
    required TaskCreateRequestEntity task,
  }) async {
    try {
      final TaskCreateResponseDataSourceModel response =
          await _dataSource.create(
        task: TaskCreateRequestDataSourceModel(
          title: task.title,
          imageUrl: task.imageUrl,
        ),
      );

      return TaskCreateResponseEntity(
        id: response.id,
        title: response.title,
        imageUrl: response.imageUrl,
        isDone: response.isDone,
        createdAt: response.createdAt,
      );
    } catch (e) {
      throw RepositoryError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }

  @override
  Future<List<TaskGetResponseEntity>?> get({
    required TaskGetRequestEntity query,
  }) async {
    try {
      final List<TaskGetResponseDataSourceModel>? response =
          await _dataSource.get(
        query: TaskGetRequestDataSourceModel(
          sortBy: query.sortBy,
          orderBy: query.orderBy,
        ),
      );

      return response == null
          ? <TaskGetResponseEntity>[]
          : response.map((TaskGetResponseDataSourceModel task) {
              return TaskGetResponseEntity(
                id: task.id,
                title: task.title,
                imageUrl: task.imageUrl,
                isDone: task.isDone,
                createdAt: task.createdAt,
              );
            }).toList();
    } catch (e) {
      throw RepositoryError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }

  @override
  Future<void> delete({
    required TaskDeleteQueryParamsRequestEntity queryParams,
  }) async {
    try {
      final TaskDeleteQueryParamsRequestDataSourceModel queryParam =
          TaskDeleteQueryParamsRequestDataSourceModel(id: queryParams.id);

      await _dataSource.delete(
        queryParams: queryParam,
      );
    } catch (e) {
      throw RepositoryError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }

  @override
  Future<TaskUpdateResponseEntity> update({
    required TaskUpdateQueryParamsRequestEntity queryParams,
    required TaskUpdateBodyRequestEntity task,
  }) async {
    try {
      final TaskUpdateRequestDataSourceModel body =
          TaskUpdateRequestDataSourceModel(
        title: task.title,
        isDone: task.isDone,
        imageUrl: task.imageUrl,
      );

      final TaskUpdateQueryParamsRequestDataSourceModel queryParam =
          TaskUpdateQueryParamsRequestDataSourceModel(id: queryParams.id);

      final TaskUpdateResponseDataSourceModel response =
          await _dataSource.update(
        task: body,
        queryParams: queryParam,
      );

      return TaskUpdateResponseEntity(
        id: response.id,
        title: response.title,
        isDone: response.isDone,
        imageUrl: response.imageUrl,
        createdAt: response.createdAt,
      );
    } catch (e) {
      throw RepositoryError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }
}

class TaskImplSseRepository implements TaskSseRepository {
  TaskImplSseRepository({required SseDatasourceStream dataSource})
      : _dataSource = dataSource;

  final SseDatasourceStream _dataSource;

  SseDatasourceStream get dataSource => _dataSource;

  @override
  EventSource get() {
    return _dataSource.connect(
      url: '${dotenv.env[ssrUrlEnv]}$taskResourceApi',
    );
  }

  @override
  void closeConnection({required EventSource eventSource}) {
    return _dataSource.closeConnection(eventSource: eventSource);
  }
}
