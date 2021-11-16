import 'package:equatable/equatable.dart';

class TaskCreateRequestEntity extends Equatable {
  const TaskCreateRequestEntity({
    required String title,
    required String imageUrl,
  })  : _title = title,
        _imageUrl = imageUrl;

  final String _title;
  final String _imageUrl;

  String get title => _title;

  String get imageUrl => _imageUrl;

  @override
  List<Object?> get props => <Object?>[_title, _imageUrl];
}

class TaskCreateResponseEntity extends Equatable {
  const TaskCreateResponseEntity({
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
