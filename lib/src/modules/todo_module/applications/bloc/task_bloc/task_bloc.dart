import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../commons/errors/app_error.dart';
import '../../../../../commons/exceptions/app_exception.dart';
import '../../../domains/entities/task_create_entity.dart';
import '../../../domains/entities/task_delete_entity.dart';
import '../../../domains/entities/task_get_entity.dart';
import '../../../domains/entities/task_update_entity.dart';
import '../../../task_impl_usecase.dart';
import '../../models/error_bloc_model.dart';
import '../../models/exception_bloc_model.dart';
import '../../models/task_bloc_models/task_create_bloc_model.dart';
import '../../models/task_bloc_models/task_delete_bloc_model.dart';
import '../../models/task_bloc_models/task_get_bloc_model.dart';
import '../../models/task_bloc_models/task_update_bloc_model.dart';

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
    } else if (event is TaskCreatedEvent) {
      yield* _mapTaskCreatedEventToState(event: event);
    } else if (event is TaskUpdatedEvent) {
      yield* _mapTaskUpdatedEventToState(event: event);
    } else if (event is TaskSelectedToUpdatedEvent) {
      yield* _mapTaskSelectedToUpdateEventToState(event: event);
    } else if (event is TaskDeletedEvent) {
      yield* _mapTaskDeletedEventToState(event: event);
    }
  }

  Stream<TaskState> _mapTaskCreatedEventToState({
    required TaskCreatedEvent event,
  }) async* {
    try {
      await _usecase.create(
        task: TaskCreateRequestEntity(
          title: event.task.title,
          imageUrl: event.task.imageUrl,
        ),
      );

      yield const TaskCreateState(status: taskStatusState.success);
    } catch (e) {
      yield TaskCreateState(
        error: e is AppError
            ? ErrorBlocModel(message: e.message, code: e.code)
            : null,
        exception: e is AppException
            ? ExceptionBlocModel(message: e.message, code: e.code)
            : null,
        status: taskStatusState.failure,
      );
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
                  return TaskGetResponseBlocModel(
                    id: task.id,
                    title: task.title,
                    isDone: task.isDone,
                    imageUrl: task.imageUrl,
                    createdAt: task.createdAt,
                  );
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

  Stream<TaskState> _mapTaskSelectedToUpdateEventToState({
    required TaskSelectedToUpdatedEvent event,
  }) async* {
    yield TaskUpdateState(
      data: TaskUpdateBlocModel(
        id: event.model.id,
        title: event.model.title,
        isDone: event.model.isDone,
        imageUrl: event.model.imageUrl,
      ),
    );
  }

  Stream<TaskState> _mapTaskUpdatedEventToState({
    required TaskUpdatedEvent event,
  }) async* {
    try {
      final TaskUpdateBodyRequestEntity taskUpdateRequestEntity =
          TaskUpdateBodyRequestEntity(
        title: event.model.title,
        imageUrl: event.model.imageUrl,
        isDone: event.model.isDone,
      );

      final TaskUpdateQueryParamsRequestEntity
          taskUpdateQueryParamRequestEntity =
          TaskUpdateQueryParamsRequestEntity(
        id: event.queryParams.id,
      );

      await _usecase.update(
        queryParams: taskUpdateQueryParamRequestEntity,
        task: taskUpdateRequestEntity,
      );

      yield const TaskUpdateState(
        status: taskStatusState.success,
      );
    } catch (e) {
      yield TaskUpdateState(
        status: taskStatusState.failure,
        error: e is AppError
            ? ErrorBlocModel(message: e.message, code: e.code)
            : null,
        exception: e is AppException
            ? ExceptionBlocModel(message: e.message, code: e.code)
            : null,
      );
    }
  }

  Stream<TaskState> _mapTaskDeletedEventToState({
    required TaskDeletedEvent event,
  }) async* {
    try {
      final TaskDeleteQueryParamsRequestEntity
          taskDeleteQueryParamsRequestEntity =
          TaskDeleteQueryParamsRequestEntity(
        id: event.queryParams.id,
      );

      await _usecase.delete(
        queryParams: taskDeleteQueryParamsRequestEntity,
      );

      yield const TaskDeleteState(
        status: taskStatusState.success,
      );
    } catch (e) {
      yield TaskDeleteState(
        status: taskStatusState.failure,
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
