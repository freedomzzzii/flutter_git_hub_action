import 'package:get/get.dart';

import '../../../../commons/errors/app_error.dart';
import '../../../../commons/exceptions/app_exception.dart';
import '../../domains/entities/task_create_entity.dart';
import '../../task_impl_usecase.dart';
import '../models/error_view_model.dart';
import '../models/exception_view_model.dart';
import '../models/task_create_view_model.dart';
import '../models/task_status_view_model.dart';

class TaskCreateController extends GetxController {
  TaskCreateController({required TaskImplUseCase usecase}) : _usecase = usecase;

  final TaskImplUseCase _usecase;
  TaskStatusViewModel _status = TaskStatusViewModel.initial;
  ErrorViewModel? _error;
  ExceptionViewModel? _exception;

  TaskStatusViewModel get status => _status;

  ErrorViewModel? get error => _error;

  ExceptionViewModel? get exception => _exception;

  TaskImplUseCase get usecase => _usecase;

  Future<void> createTask({
    required TaskCreateRequestControllerModel task,
  }) async {
    try {
      await _usecase.create(
        task: TaskCreateRequestEntity(
          title: task.title,
          imageUrl: task.imageUrl,
        ),
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
