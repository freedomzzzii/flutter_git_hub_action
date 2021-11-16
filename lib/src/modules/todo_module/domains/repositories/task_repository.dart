import '../entities/task_create_entity.dart';
import '../entities/task_delete_entity.dart';
import '../entities/task_get_entity.dart';
import '../entities/task_update_entity.dart';

abstract class TaskRepository {
  Future<TaskCreateResponseEntity> create({
    required TaskCreateRequestEntity task,
  });

  Future<List<TaskGetResponseEntity>?> get({
    required TaskGetRequestEntity query,
  });

  Future<TaskUpdateResponseEntity> update({
    required TaskUpdateBodyRequestEntity task,
    required TaskUpdateQueryParamsRequestEntity queryParams,
  });

  Future<void> delete({
    required TaskDeleteQueryParamsRequestEntity queryParams,
  });
}
