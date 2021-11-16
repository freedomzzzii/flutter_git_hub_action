import '../../utils/error_code/error_code_util.dart';
import 'commons/errors/repository_error.dart';
import 'domains/datasources/datasource.dart';
import 'domains/entities/task_get_entity.dart';
import 'domains/repositories/task_repository.dart';
import 'services/models/task_get_datasource_model.dart';

class TaskImplRepository implements TaskRepository {
  TaskImplRepository({required DataSource dataSource})
      : _dataSource = dataSource;

  final DataSource _dataSource;

  DataSource get dataSource => _dataSource;

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
              return TaskGetResponseEntity(title: task.title);
            }).toList();
    } catch (e) {
      throw RepositoryError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }
}
