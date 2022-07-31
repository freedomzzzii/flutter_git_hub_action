import 'package:get/get.dart';

import '../../../../commons/errors/app_error.dart';
import '../../domains/entities/task_get_entity.dart';
import '../../services/commons/request_query.dart';
import '../../task_impl_usecase.dart';
import '../models/error_view_model.dart';
import '../models/task_get_view_model.dart';
import '../models/task_status_view_model.dart';

class TaskGetController extends GetxController {
  TaskGetController({required TaskImplUseCase usecase}) : _usecase = usecase;

  final TaskImplUseCase _usecase;
  TaskStatusViewModel _status = TaskStatusViewModel.initial;
  List<TaskGetResponseControllerModel> _tasks =
      <TaskGetResponseControllerModel>[];
  TaskGetRequestControllerModel _query = const TaskGetRequestControllerModel(
    sortBy: createdAtQueryValue,
    orderBy: descQueryValue,
  );
  ErrorViewModel? _error;

  List<TaskGetResponseControllerModel> get tasks => _tasks;

  TaskGetRequestControllerModel get query => _query;

  TaskStatusViewModel get status => _status;

  ErrorViewModel? get error => _error;

  TaskImplUseCase get usecase => _usecase;

  Future<void> getTasks({
    required TaskGetRequestControllerModel requestBody,
  }) async {
    try {
      _status = TaskStatusViewModel.loading;
      if (_query != requestBody) {
        _query = requestBody;
      }

      final List<TaskGetResponseEntity>? responseUseCase = await _usecase.get(
        query: TaskGetRequestEntity(
          sortBy: requestBody.sortBy,
          orderBy: requestBody.orderBy,
        ),
      );

      _status = TaskStatusViewModel.success;
      _tasks = responseUseCase == null
          ? <TaskGetResponseControllerModel>[]
          : responseUseCase.map((TaskGetResponseEntity task) {
              return TaskGetResponseControllerModel(
                id: task.id,
                title: task.title,
                isDone: task.isDone,
                imageUrl: task.imageUrl,
                createdAt: task.createdAt,
              );
            }).toList();

      update();
    } catch (e) {
      _status = TaskStatusViewModel.failure;

      if (e is AppError) {
        _error = ErrorViewModel(message: e.message, code: e.code);
      }

      update();
    }
  }
}
