import '../entities/task_get_entity.dart';

abstract class TaskUseCase {
  Future<List<TaskGetResponseEntity>?> get({
    required TaskGetRequestEntity query,
  });
}
