import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:universal_html/html.dart';

import '../../../../../commons/errors/app_error.dart';
import '../../../../../commons/exceptions/app_exception.dart';
import '../../../domains/usecases/task_sse_usecase.dart';
import '../../../services/models/task_get_datasource_model.dart';
import '../../models/error_bloc_model.dart';
import '../../models/exception_bloc_model.dart';
import '../../models/task_bloc_models/task_get_bloc_model.dart';

part 'task_sse_event.dart';

part 'task_sse_state.dart';

class TaskSseBloc extends Bloc<TaskSseEvent, TaskSseState> {
  TaskSseBloc({required TaskSseUseCase usecase})
      : _usecase = usecase,
        super(TaskSseInitialState());

  final TaskSseUseCase _usecase;

  @override
  Stream<TaskSseState> mapEventToState(TaskSseEvent event) async* {
    if (event is TaskConnectedGetTaskEvent) {
      yield* _mapTaskConnectedGetTaskEventToState();
    } else if (event is TaskClosedConnectionEvent) {
      yield* _mapTaskClosedConnectionEventToState();
    } else if (event is TaskGotEvent) {
      yield* _mapTaskGotEventToState(event: event);
    }
  }

  void _subscribe(EventSource eventSource) {
    eventSource.onMessage.listen((MessageEvent event) {
      add(TaskGotEvent(response: event.data));
    });
  }

  Stream<TaskSseState> _mapTaskConnectedGetTaskEventToState() async* {
    final EventSource eventDatasource = _usecase.get();
    _subscribe(eventDatasource);
    yield TaskSseConnectGetTaskState(
      status: taskSseStatusState.success,
      eventSource: eventDatasource,
    );
  }

  Stream<TaskSseState> _mapTaskClosedConnectionEventToState() async* {
    if (state.eventSource != null) {
      _usecase.closeConnection(eventSource: state.eventSource!);
    }

    yield const TaskSseCloseConnectState(
      status: taskSseStatusState.success,
    );
  }

  Stream<TaskSseState> _mapTaskGotEventToState({
    required TaskGotEvent event,
  }) async* {
    try {
      final dynamic body = json.decode(event.response as String);

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

      yield TaskSseGetTaskState(
        eventSource: state.eventSource,
        status: taskSseStatusState.success,
        data: taskGetResponseBlocModel,
      );
    } catch (e) {
      yield TaskSseGetTaskState(
        error: e is AppError
            ? ErrorBlocModel(message: e.message, code: e.code)
            : null,
        exception: e is AppException
            ? ExceptionBlocModel(message: e.message, code: e.code)
            : null,
        status: taskSseStatusState.failure,
      );
    }
  }
}
