part of 'task_bloc.dart';

enum taskStatusState { initial, loading, success, failure }

abstract class TaskState extends Equatable {
  const TaskState({ WebSocketChannel? channel,}) : _channel = channel;

  final WebSocketChannel? _channel;

  WebSocketChannel? get channel => _channel;

  @override
  List<Object?> get props => <Object?>[_channel];
}

class TaskInitialState extends TaskState {
  final taskStatusState _status = taskStatusState.initial;

  taskStatusState get status => _status;

  @override
  List<Object> get props => <Object>[_status];
}

class TaskLoadingState extends TaskState {
  final taskStatusState _status = taskStatusState.loading;

  taskStatusState get status => _status;

  @override
  List<Object> get props => <Object>[_status];
}

class TaskCreateState extends TaskState {
  const TaskCreateState({
    ErrorBlocModel? error,
    ExceptionBlocModel? exception,
    required taskStatusState status,
  })  : _error = error,
        _exception = exception,
        _status = status;

  final ErrorBlocModel? _error;
  final ExceptionBlocModel? _exception;
  final taskStatusState _status;

  ErrorBlocModel? get error => _error;

  ExceptionBlocModel? get exception => _exception;

  taskStatusState get status => _status;

  @override
  List<Object?> get props => <Object?>[_error, _exception, _status];
}

class TaskGetState extends TaskState {
  const TaskGetState({
    required taskStatusState status,
    required TaskGetRequestBlocModel query,
    List<TaskGetResponseBlocModel>? data,
    ErrorBlocModel? error,
    ExceptionBlocModel? exception,
  })  : _status = status,
        _query = query,
        _data = data,
        _error = error,
        _exception = exception;

  final taskStatusState _status;
  final TaskGetRequestBlocModel _query;
  final List<TaskGetResponseBlocModel>? _data;
  final ErrorBlocModel? _error;
  final ExceptionBlocModel? _exception;

  taskStatusState get status => _status;

  TaskGetRequestBlocModel get query => _query;

  List<TaskGetResponseBlocModel>? get data => _data;

  ErrorBlocModel? get error => _error;

  ExceptionBlocModel? get exception => _exception;

  @override
  List<Object?> get props =>
      <Object?>[_status, _data, _query, _error, _exception];
}

class TaskUpdateState extends TaskState {
  const TaskUpdateState({
    taskStatusState status = taskStatusState.initial,
    TaskUpdateBlocModel? data,
    ErrorBlocModel? error,
    ExceptionBlocModel? exception,
  })  : _status = status,
        _data = data,
        _error = error,
        _exception = exception;

  final taskStatusState _status;
  final TaskUpdateBlocModel? _data;
  final ErrorBlocModel? _error;
  final ExceptionBlocModel? _exception;

  taskStatusState get status => _status;

  TaskUpdateBlocModel? get data => _data;

  ErrorBlocModel? get error => _error;

  ExceptionBlocModel? get exception => _exception;

  @override
  List<Object?> get props => <Object?>[_status, _data, _error, _exception];
}

class TaskDeleteState extends TaskState {
  const TaskDeleteState({
    taskStatusState status = taskStatusState.initial,
    ErrorBlocModel? error,
    ExceptionBlocModel? exception,
  })  : _status = status,
        _error = error,
        _exception = exception;

  final taskStatusState _status;
  final ErrorBlocModel? _error;
  final ExceptionBlocModel? _exception;

  taskStatusState get status => _status;

  ErrorBlocModel? get error => _error;

  ExceptionBlocModel? get exception => _exception;

  @override
  List<Object?> get props => <Object?>[_status, _error, _exception];
}

class TaskStreamSubscriptionState extends TaskState {
  const TaskStreamSubscriptionState({
    taskStatusState status = taskStatusState.initial,
    WebSocketChannel? channel,
    ErrorBlocModel? error,
    ExceptionBlocModel? exception,
  })  : _status = status,
        _error = error,
        _exception = exception,
        super(channel: channel);

  final taskStatusState _status;

  final ErrorBlocModel? _error;

  final ExceptionBlocModel? _exception;

  taskStatusState get status => _status;

  ErrorBlocModel? get error => _error;

  ExceptionBlocModel? get exception => _exception;

  @override
  List<Object?> get props => <Object?>[_status, _channel, _error, _exception];
}

class TaskStreamGetState extends TaskState {
  const TaskStreamGetState({
    taskStatusState status = taskStatusState.initial,
    List<TaskGetResponseBlocModel>? data,
    WebSocketChannel? channel,
    ErrorBlocModel? error,
    ExceptionBlocModel? exception,
  })  : _status = status,
        _data = data,
        _error = error,
        _exception = exception,
        super(channel: channel);

  final taskStatusState _status;

  final List<TaskGetResponseBlocModel>? _data;

  final ErrorBlocModel? _error;

  final ExceptionBlocModel? _exception;

  taskStatusState get status => _status;

  List<TaskGetResponseBlocModel>? get data => _data;

  ErrorBlocModel? get error => _error;

  ExceptionBlocModel? get exception => _exception;

  @override
  List<Object?> get props => <Object?>[_status, _data, _error, _exception];
}

class TaskRefreshStreamGetState extends TaskState {
  const TaskRefreshStreamGetState({
    taskStatusState status = taskStatusState.initial,
    WebSocketChannel? channel,
    ErrorBlocModel? error,
    ExceptionBlocModel? exception,
  })  : _status = status,
        _error = error,
        _exception = exception,
        super(channel: channel);


  final taskStatusState _status;

  final ErrorBlocModel? _error;

  final ExceptionBlocModel? _exception;

  taskStatusState get status => _status;

  ErrorBlocModel? get error => _error;

  ExceptionBlocModel? get exception => _exception;

  @override
  List<Object?> get props => <Object?>[_status, _error, _exception];
}

class TaskDisconnectStreamGetState extends TaskState {
  const TaskDisconnectStreamGetState({
    taskStatusState status = taskStatusState.initial,
    WebSocketChannel? channel,
    ErrorBlocModel? error,
    ExceptionBlocModel? exception,
  })  : _status = status,
        _error = error,
        _exception = exception,
        super(channel: channel);


  final taskStatusState _status;

  final ErrorBlocModel? _error;

  final ExceptionBlocModel? _exception;

  taskStatusState get status => _status;

  ErrorBlocModel? get error => _error;

  ExceptionBlocModel? get exception => _exception;

  @override
  List<Object?> get props => <Object?>[_status, _error, _exception];
}
