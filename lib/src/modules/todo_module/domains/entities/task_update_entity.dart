import 'package:equatable/equatable.dart';

class TaskUpdateBodyRequestEntity extends Equatable {
  const TaskUpdateBodyRequestEntity({
    String? title,
    bool? isDone,
    String? imageUrl,
  })  : _title = title,
        _isDone = isDone,
        _imageUrl = imageUrl;

  final String? _title;
  final bool? _isDone;
  final String? _imageUrl;

  String? get title => _title;

  bool? get isDone => _isDone;

  String? get imageUrl => _imageUrl;

  @override
  List<Object?> get props => <Object?>[_title, _isDone, _imageUrl];
}

class TaskUpdateQueryParamsRequestEntity extends Equatable {
  const TaskUpdateQueryParamsRequestEntity({
    required String id,
  }) : _id = id;

  final String _id;

  String get id => _id;

  @override
  List<Object> get props => <Object>[_id];
}

class TaskUpdateResponseEntity extends Equatable {
  const TaskUpdateResponseEntity({
    required String id,
    required String title,
    required bool isDone,
    required String imageUrl,
    required DateTime createdAt,
  })  : _id = id,
        _title = title,
        _isDone = isDone,
        _imageUrl = imageUrl,
        _createdAt = createdAt;

  final String _id;
  final String _title;
  final bool _isDone;
  final String _imageUrl;
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

class TaskUpdateEntity extends Equatable {
  const TaskUpdateEntity({
    required String id,
    required String title,
    required bool isDone,
    required String imageUrl,
  })  : _id = id,
        _title = title,
        _isDone = isDone,
        _imageUrl = imageUrl;

  final String _id;
  final String _title;
  final bool _isDone;
  final String _imageUrl;

  String get id => _id;

  String get title => _title;

  String get imageUrl => _imageUrl;

  bool get isDone => _isDone;

  @override
  List<Object?> get props => <Object?>[
        _id,
        _title,
        _imageUrl,
        _isDone,
      ];
}
