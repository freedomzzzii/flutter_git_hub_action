import 'package:equatable/equatable.dart';

class TaskGetRequestEntity extends Equatable {
  const TaskGetRequestEntity({
    required String sortBy,
    required String orderBy,
  })  : _sortBy = sortBy,
        _orderBy = orderBy;

  final String _sortBy;
  final String _orderBy;

  String get sortBy => _sortBy;

  String get orderBy => _orderBy;

  @override
  List<Object?> get props => <Object?>[_sortBy, _orderBy];
}

class TaskGetResponseEntity extends Equatable {
  const TaskGetResponseEntity({
    required String title,
  }) : _title = title;

  final String _title;

  String get title => _title;

  @override
  List<Object?> get props => <Object?>[
        _title,
      ];
}
