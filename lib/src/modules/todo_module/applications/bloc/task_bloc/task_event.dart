part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class TaskCreatedEvent extends TaskEvent {
  const TaskCreatedEvent({
    required TaskCreateRequestBlocModel model,
  }) : _model = model;

  final TaskCreateRequestBlocModel _model;

  @override
  List<Object?> get props => <Object?>[_model];

  TaskCreateRequestBlocModel get task => _model;
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

class TaskUpdatedEvent extends TaskEvent {
  const TaskUpdatedEvent({
    required TaskUpdateBodyRequestBlocModel model,
    required TaskUpdateQueryParamsRequestBlocModel queryParams,
  })  : _model = model,
        _queryParams = queryParams;

  final TaskUpdateBodyRequestBlocModel _model;
  final TaskUpdateQueryParamsRequestBlocModel _queryParams;

  @override
  List<Object?> get props => <Object?>[_model, _queryParams];

  TaskUpdateBodyRequestBlocModel get model => _model;

  TaskUpdateQueryParamsRequestBlocModel get queryParams => _queryParams;
}

class TaskSelectedToUpdatedEvent extends TaskEvent {
  const TaskSelectedToUpdatedEvent({
    required TaskUpdateBlocModel model,
  }) : _model = model;

  final TaskUpdateBlocModel _model;

  @override
  List<Object?> get props => <Object?>[_model];

  TaskUpdateBlocModel get model => _model;
}

class TaskDeletedEvent extends TaskEvent {
  const TaskDeletedEvent({
    required TaskDeleteQueryParamsRequestBlocModel queryParams,
  }) : _queryParams = queryParams;

  final TaskDeleteQueryParamsRequestBlocModel _queryParams;

  @override
  List<Object?> get props => <Object?>[_queryParams];

  TaskDeleteQueryParamsRequestBlocModel get queryParams => _queryParams;
}

class TaskStreamSubscriptionEvent extends TaskEvent {
  @override
  List<Object?> get props => throw <Object?>[];
}

class TaskStreamGotEvent extends TaskEvent {
  const TaskStreamGotEvent({
    required List<TaskGetResponseBlocModel> model,
  }) : _model = model;

  final List<TaskGetResponseBlocModel> _model;

  @override
  List<Object?> get props => <Object?>[_model];

  List<TaskGetResponseBlocModel> get model => _model;
}

class TaskRefreshStreamGetEvent extends TaskEvent {
  @override
  List<Object?> get props => throw <Object?>[];
}

class TaskDisconnectStreamGetEvent extends TaskEvent {
  @override
  List<Object?> get props => throw <Object?>[];
}
