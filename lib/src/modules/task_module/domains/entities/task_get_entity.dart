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
    required String id,
    required String title,
    required String imageUrl,
    required bool isDone,
    required DateTime createdAt,
  })  : _id = id,
        _title = title,
        _imageUrl = imageUrl,
        _isDone = isDone,
        _createdAt = createdAt;

  final String _id;
  final String _title;
  final String _imageUrl;
  final bool _isDone;
  final DateTime _createdAt;

  String get id => _id;

  String get title => _title;

  String get imageUrl => _imageUrl;

  bool get isDone => _isDone;

  DateTime get createdAt => _createdAt;

  @override
  List<Object?> get props => <Object?>[
        _id,
        _title,
        _imageUrl,
        _isDone,
        _createdAt,
      ];
}
