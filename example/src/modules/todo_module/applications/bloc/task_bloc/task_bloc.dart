import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../commons/errors/app_error.dart';
import '../../../../../commons/exceptions/app_exception.dart';
import '../../../domains/entities/task_get_entity.dart';
import '../../../task_impl_usecase.dart';
import '../../models/error_bloc_model.dart';
import '../../models/exception_bloc_model.dart';
import '../../models/task_bloc_models/task_get_bloc_model.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc({required TaskImplUseCase usecase})
      : _usecase = usecase,
        super(TaskInitialState());

  final TaskImplUseCase _usecase;

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is TaskGotEvent) {
      yield* _mapTaskGotEventToState(event: event);
    }
  }

  Stream<TaskState> _mapTaskGotEventToState({
    required TaskGotEvent event,
  }) async* {
    try {
      final List<TaskGetResponseEntity>? responseUseCase = await _usecase.get(
        query: TaskGetRequestEntity(
          sortBy: event.model.sortBy,
          orderBy: event.model.orderBy,
        ),
      );

      final List<TaskGetResponseBlocModel> taskGetResponseBlocModel =
          responseUseCase == null
              ? <TaskGetResponseBlocModel>[]
              : responseUseCase.map((TaskGetResponseEntity task) {
                  return TaskGetResponseBlocModel(title: task.title);
                }).toList();

      yield TaskGetState(
        status: taskStatusState.success,
        data: taskGetResponseBlocModel,
        query: event.model,
      );
    } catch (e) {
      yield TaskGetState(
        status: taskStatusState.failure,
        query: event.model,
        error: e is AppError
            ? ErrorBlocModel(message: e.message, code: e.code)
            : null,
        exception: e is AppException
            ? ExceptionBlocModel(message: e.message, code: e.code)
            : null,
      );
    }
  }
}
