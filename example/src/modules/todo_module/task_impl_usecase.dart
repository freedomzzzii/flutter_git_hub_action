import '../../utils/error_code/error_code_util.dart';
import 'commons/errors/usecase_error.dart';
import 'domains/entities/task_get_entity.dart';
import 'domains/repositories/task_repository.dart';
import 'domains/usecases/task_usecase.dart';

class TaskImplUseCase implements TaskUseCase {
  TaskImplUseCase({required TaskRepository repository})
      : _repository = repository;

  final TaskRepository _repository;

  TaskRepository get repository => _repository;

  @override
  Future<List<TaskGetResponseEntity>?> get({
    required TaskGetRequestEntity query,
  }) async {
    try {
      return await _repository.get(query: query);
    } catch (e) {
      throw TaskGetUseCaseError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }
}
