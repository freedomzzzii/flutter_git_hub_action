import '../../utils/error_code/error_code_util.dart';
import 'commons/errors/usecase_error.dart';
import 'commons/exceptions/usecase_exception.dart';
import 'configs/usecasae_messages/usecase_message_config.dart';
import 'domains/entities/task_create_entity.dart';
import 'domains/entities/task_delete_entity.dart';
import 'domains/entities/task_get_entity.dart';
import 'domains/entities/task_update_entity.dart';
import 'domains/repositories/task_repository.dart';
import 'domains/usecases/task_usecase.dart';

class TaskImplUseCase implements TaskUseCase {
  TaskImplUseCase({required TaskRepository repository})
      : _repository = repository;

  final TaskRepository _repository;

  TaskRepository get repository => _repository;

  @override
  Future<TaskCreateResponseEntity> create({
    required TaskCreateRequestEntity task,
  }) async {
    try {
      if (task.title.isEmpty) {
        throw const FieldValidationException(
          message: requiredTitleMessage,
          code: appErrorCodes.missingRequiredFields,
        );
      } else if (task.imageUrl.isEmpty) {
        throw const FieldValidationException(
          message: requiredImageUrlMessage,
          code: appErrorCodes.missingRequiredFields,
        );
      }

      return await _repository.create(task: task);
    } catch (e) {
      throw TaskCreateUseCaseError(
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
      return await _repository.get(query: query);
    } catch (e) {
      throw TaskGetUseCaseError(
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
      if (queryParams.id.isEmpty) {
        throw const FieldRequiredException(
          message: requiredIdMessage,
          code: appErrorCodes.missingRequiredFields,
        );
      } else if ((task.title == null || task.title!.isEmpty) &&
          task.isDone == null &&
          (task.imageUrl == null || task.imageUrl!.isEmpty)) {
        throw const FieldValidationException(
          message: requiredAtLeastOneMessage,
          code: appErrorCodes.missingRequiredFields,
        );
      }
      return await _repository.update(queryParams: queryParams, task: task);
    } catch (e) {
      throw TaskUpdateUseCaseError(message: e.toString());
    }
  }

  @override
  Future<void> delete({
    required TaskDeleteQueryParamsRequestEntity queryParams,
  }) async {
    try {
      if (queryParams.id.isEmpty) {
        throw const FieldRequiredException(
          message: requiredIdMessage,
          code: appErrorCodes.missingRequiredFields,
        );
      }

      await _repository.delete(queryParams: queryParams);
    } catch (e) {
      throw TaskDeleteUseCaseError(message: e.toString());
    }
  }
}
