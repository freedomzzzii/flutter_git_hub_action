import 'package:equatable/equatable.dart';

class TaskDeleteQueryParamsRequestEntity extends Equatable {
  const TaskDeleteQueryParamsRequestEntity({
    required String id,
  }) : _id = id;

  final String _id;

  String get id => _id;

  @override
  List<Object> get props => <Object>[_id];
}
