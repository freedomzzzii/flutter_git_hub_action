part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class TaskGotEvent extends TaskEvent {
  const TaskGotEvent({
    required TaskGetRequestBlocModel model,
  }) : _model = model;

  final TaskGetRequestBlocModel _model;

  @override
  List<Object?> get props => <Object?>[_model];

  TaskGetRequestBlocModel get model => _model;
}
