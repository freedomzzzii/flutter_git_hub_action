import '../../../domains/entities/task_update_entity.dart';

class TaskUpdateBodyRequestBlocModel extends TaskUpdateBodyRequestEntity {
  const TaskUpdateBodyRequestBlocModel({
    String? title,
    bool? isDone,
    String? imageUrl,
  }) : super(title: title, isDone: isDone, imageUrl: imageUrl);
}

class TaskUpdateQueryParamsRequestBlocModel
    extends TaskUpdateQueryParamsRequestEntity {
  const TaskUpdateQueryParamsRequestBlocModel({required String id})
      : super(id: id);
}

class TaskUpdateResponseBlocModel extends TaskUpdateResponseEntity {
  const TaskUpdateResponseBlocModel({
    required String id,
    required String title,
    required bool isDone,
    required String imageUrl,
    required DateTime createdAt,
  }) : super(
          id: id,
          title: title,
          isDone: isDone,
          imageUrl: imageUrl,
          createdAt: createdAt,
        );
}

class TaskUpdateBlocModel extends TaskUpdateEntity {
  const TaskUpdateBlocModel({
    required String id,
    required String title,
    required bool isDone,
    required String imageUrl,
  }) : super(
          id: id,
          title: title,
          isDone: isDone,
          imageUrl: imageUrl,
        );
}
