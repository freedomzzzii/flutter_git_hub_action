import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../commons/errors/app_error.dart';
import '../../../../commons/exceptions/app_exception.dart';
import '../../domains/entities/task_delete_entity.dart';
import '../../task_impl_usecase.dart';
import '../models/error_view_model.dart';
import '../models/exception_view_model.dart';
import '../models/task_delete_view_model.dart';
import '../models/task_status_view_model.dart';

class TaskDeleteController extends GetxController {
  TaskDeleteController({required TaskImplUseCase usecase}) : _usecase = usecase;

  final TaskImplUseCase _usecase;
  TaskStatusViewModel _status = TaskStatusViewModel.initial;
  ErrorViewModel? _error;
  ExceptionViewModel? _exception;

  TaskStatusViewModel get status => _status;

  ErrorViewModel? get error => _error;

  ExceptionViewModel? get exception => _exception;

  TaskImplUseCase get usecase => _usecase;

  Future<void> deleteTask({
    required TaskDeleteQueryParamsRequestControllerModel queryParams,
  }) async {
    try {
      final TaskDeleteQueryParamsRequestEntity
          taskDeleteQueryParamsRequestEntity =
          TaskDeleteQueryParamsRequestEntity(
        id: queryParams.id,
      );

      await _usecase.delete(
        queryParams: taskDeleteQueryParamsRequestEntity,
      );

      _status = TaskStatusViewModel.success;

      update();
    } catch (e) {
      _status = TaskStatusViewModel.failure;

      if (e is AppError) {
        _error = ErrorViewModel(message: e.message, code: e.code);
      } else if (e is AppException) {
        _exception = ExceptionViewModel(message: e.message, code: e.code);
      }

      update();
    }
  }
}
