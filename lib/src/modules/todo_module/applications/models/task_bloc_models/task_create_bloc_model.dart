import '../../../domains/entities/task_create_entity.dart';

class TaskCreateRequestBlocModel extends TaskCreateRequestEntity {
  const TaskCreateRequestBlocModel({
    required String title,
    required String imageUrl,
  }) : super(title: title, imageUrl: imageUrl);
}

class TaskCreateResponseBlocModel extends TaskCreateResponseEntity {
  const TaskCreateResponseBlocModel({
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
