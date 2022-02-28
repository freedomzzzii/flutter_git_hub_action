part of 'task_sse_bloc.dart';

enum taskSseStatusState { initial, loading, success, failure }

class TaskSseState extends Equatable {
  const TaskSseState({
    EventSource? eventSource,
  }) : _eventSource = eventSource;

  final EventSource? _eventSource;

  EventSource? get eventSource => _eventSource;

  @override
  List<Object?> get props => <Object?>[_eventSource];
}

class TaskSseInitialState extends TaskSseState {
  final taskSseStatusState _status = taskSseStatusState.initial;

  taskSseStatusState get status => _status;

  @override
  List<Object> get props => <Object>[_status];
}

class TaskSseConnectGetTaskState extends TaskSseState {
  const TaskSseConnectGetTaskState({
    taskSseStatusState status = taskSseStatusState.initial,
    EventSource? eventSource,
    ErrorBlocModel? error,
    ExceptionBlocModel? exception,
  })  : _status = status,
        _error = error,
        _exception = exception,
        super(eventSource: eventSource);

  final taskSseStatusState _status;

  final ErrorBlocModel? _error;

  final ExceptionBlocModel? _exception;

  taskSseStatusState get status => _status;

  ErrorBlocModel? get error => _error;

  ExceptionBlocModel? get exception => _exception;

  @override
  List<Object?> get props => <Object?>[_status, _error, _exception];
}

class TaskSseCloseConnectState extends TaskSseState {
  const TaskSseCloseConnectState({
    taskSseStatusState status = taskSseStatusState.initial,
    ErrorBlocModel? error,
    ExceptionBlocModel? exception,
  })  : _status = status,
        _error = error,
        _exception = exception,
        super();

  final taskSseStatusState _status;

  final ErrorBlocModel? _error;

  final ExceptionBlocModel? _exception;

  taskSseStatusState get status => _status;

  ErrorBlocModel? get error => _error;

  ExceptionBlocModel? get exception => _exception;

  @override
  List<Object?> get props => <Object?>[_status, _error, _exception];
}

class TaskSseGetTaskState extends TaskSseState {
  const TaskSseGetTaskState({
    taskSseStatusState status = taskSseStatusState.initial,
    List<TaskGetResponseBlocModel>? data,
    EventSource? eventSource,
    ErrorBlocModel? error,
    ExceptionBlocModel? exception,
  })  : _status = status,
        _data = data,
        _error = error,
        _exception = exception,
        super(eventSource: eventSource);

  final taskSseStatusState _status;

  final List<TaskGetResponseBlocModel>? _data;

  final ErrorBlocModel? _error;

  final ExceptionBlocModel? _exception;

  taskSseStatusState get status => _status;

  List<TaskGetResponseBlocModel>? get data => _data;

  ErrorBlocModel? get error => _error;

  ExceptionBlocModel? get exception => _exception;

  @override
  List<Object?> get props => <Object?>[_status, _data, _error, _exception];
}
