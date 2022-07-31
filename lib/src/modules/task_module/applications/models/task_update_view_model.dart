import '../../domains/entities/task_update_entity.dart';

class TaskUpdateBodyRequestControllerModel extends TaskUpdateBodyRequestEntity {
  const TaskUpdateBodyRequestControllerModel({
    String? title,
    bool? isDone,
    String? imageUrl,
  }) : super(title: title, isDone: isDone, imageUrl: imageUrl);
}

class TaskUpdateQueryParamsRequestControllerModel
    extends TaskUpdateQueryParamsRequestEntity {
  const TaskUpdateQueryParamsRequestControllerModel({required String id})
      : super(id: id);
}

class TaskUpdateResponseControllerModel extends TaskUpdateResponseEntity {
  const TaskUpdateResponseControllerModel({
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

class TaskUpdateControllerModel extends TaskUpdateEntity {
  const TaskUpdateControllerModel({
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
