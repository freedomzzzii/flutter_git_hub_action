import '../../utils/error_code/error_code_util.dart';
import 'commons/errors/repository_error.dart';
import 'domains/datasources/datasource.dart';
import 'domains/entities/task_create_entity.dart';
import 'domains/entities/task_delete_entity.dart';
import 'domains/entities/task_get_entity.dart';
import 'domains/entities/task_update_entity.dart';
import 'domains/repositories/task_repository.dart';
import 'services/datasources/api_datasource.dart';
import 'services/datasources/grpc_datasource.dart';
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
          await (_dataSource as ApiDataSource).create(
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
        code: AppErrorCodes.unknownError,
      );
    }
  }

  @override
  Future<List<TaskGetResponseEntity>?> get({
    required TaskGetRequestEntity query,
  }) async {
    try {
      final List<TaskGetResponseDataSourceModel>? response =
          await ((_dataSource is ApiDataSource)
                  ? _dataSource as ApiDataSource
                  : _dataSource is GprcDataSource
                      ? _dataSource as GprcDataSource
                      : _dataSource as ApiDataSource)
              .get(
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
        code: AppErrorCodes.unknownError,
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

      await (_dataSource as ApiDataSource).delete(
        queryParams: queryParam,
      );
    } catch (e) {
      throw RepositoryError(
        message: e.toString(),
        code: AppErrorCodes.unknownError,
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
          await (_dataSource as ApiDataSource).update(
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
        code: AppErrorCodes.unknownError,
      );
    }
  }

}
