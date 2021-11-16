import '../entities/task_get_entity.dart';

abstract class TaskRepository {
  Future<List<TaskGetResponseEntity>?> get({
    required TaskGetRequestEntity query,
  });
}
