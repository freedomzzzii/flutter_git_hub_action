import '../../domains/entities/task_create_entity.dart';

class TaskCreateRequestControllerModel extends TaskCreateRequestEntity {
  const TaskCreateRequestControllerModel({
    required String title,
    required String imageUrl,
  }) : super(title: title, imageUrl: imageUrl);
}

class TaskCreateResponseControllerModel extends TaskCreateResponseEntity {
  const TaskCreateResponseControllerModel({
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
