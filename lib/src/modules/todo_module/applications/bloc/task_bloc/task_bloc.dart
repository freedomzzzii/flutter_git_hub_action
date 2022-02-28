import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_starter_kit/src/commons/constants/env_constant.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/services/models/task_get_datasource_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
    } else if (event is TaskStreamSubscriptionEvent) {
      yield* _mapTaskStreamSubscriptionEventToState(event: event);
    } else if (event is TaskStreamGotEvent) {
      yield* _mapGetStreamEventToState(event: event);
    } else if (event is TaskRefreshStreamGetEvent) {
      yield* _mapTaskRefreshStreamGetEventToState(event: event);
    } else if (event is TaskDisconnectStreamGetEvent) {
      yield* _mapTaskDisconnectStreamGetEventToState(event: event);
    }
  }

  void _subscribe(WebSocketChannel channel) {
    channel.stream.listen((dynamic data) {
      _convertData(data);
    });
  }

  List<dynamic>? _convertData(dynamic data) {
    final dynamic body = json.decode(data as String);
    final List<TaskGetResponseDataSourceModel>? result =
    (body['data'] as List<dynamic>?)?.map((dynamic data) {
      return TaskGetResponseDataSourceModel.fromJson(
        data as Map<String, dynamic>,
      );
    }).toList();

    final List<TaskGetResponseBlocModel> taskGetResponseBlocModel =
    result == null
        ? <TaskGetResponseBlocModel>[]
        : result.map((TaskGetResponseDataSourceModel task) {
      return TaskGetResponseBlocModel(
        id: task.id,
        title: task.title,
        isDone: task.isDone,
        imageUrl: task.imageUrl,
        createdAt: task.createdAt,
      );
    }).toList();
    add(TaskStreamGotEvent(model: taskGetResponseBlocModel));
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
      yield TaskLoadingState();

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

  Stream<TaskState> _mapTaskStreamSubscriptionEventToState({
    required TaskStreamSubscriptionEvent event,
  }) async* {
    try {
      final WebSocketChannel channel =
      _usecase.streamGet(url: '${dotenv.env[webSocketUrlEnv]}');
      _subscribe(channel);
      yield TaskStreamSubscriptionState(
        status: taskStatusState.success,
        channel: channel,
      );
    } catch (e) {
      yield TaskStreamSubscriptionState(
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

  Stream<TaskState> _mapGetStreamEventToState({
    required TaskStreamGotEvent event,
  }) async* {
    yield TaskStreamGetState(
      status: taskStatusState.success,
      data: event.model,
      channel: state.channel,
    );
  }

  Stream<TaskState> _mapTaskRefreshStreamGetEventToState({
    required TaskRefreshStreamGetEvent event,
  }) async* {
    try {
      if (state.channel != null) {
        _usecase.sendData(channel: state.channel!, data: 'data');
        yield const TaskRefreshStreamGetState(
          status: taskStatusState.success,
        );
      } else {
        yield const TaskRefreshStreamGetState(
          status: taskStatusState.failure,
        );
      }
    } catch (e) {
      yield TaskRefreshStreamGetState(
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

  Stream<TaskState> _mapTaskDisconnectStreamGetEventToState({
    required TaskDisconnectStreamGetEvent event,
  }) async* {
    try {
      if (state.channel != null) {
        await _usecase.disconnect(channel: state.channel!);
        yield const TaskDisconnectStreamGetState(
          status: taskStatusState.success,
        );
      } else {
        yield const TaskDisconnectStreamGetState(
          status: taskStatusState.failure,
        );
      }
    } catch (e) {
      yield TaskDisconnectStreamGetState(
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
}
