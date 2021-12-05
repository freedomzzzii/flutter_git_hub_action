part of 'task_sse_bloc.dart';

abstract class TaskSseEvent extends Equatable {
  const TaskSseEvent();
}

class TaskConnectedGetTaskEvent extends TaskSseEvent {
  @override
  List<Object?> get props => throw <Object?>[];
}

class TaskClosedConnectionEvent extends TaskSseEvent {
  @override
  List<Object?> get props => throw <Object?>[];
}

class TaskGotEvent extends TaskSseEvent {
  const TaskGotEvent({
    required dynamic response,
  }) : _response = response;

  final dynamic _response;

  @override
  List<Object?> get props => <Object?>[_response];

  dynamic get response => _response;
}
