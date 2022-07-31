import '../../domains/entities/task_get_entity.dart';

class TaskGetRequestControllerModel extends TaskGetRequestEntity {
  const TaskGetRequestControllerModel({
    required String sortBy,
    required String orderBy,
  }) : super(sortBy: sortBy, orderBy: orderBy);
}

class TaskGetResponseControllerModel extends TaskGetResponseEntity {
  const TaskGetResponseControllerModel({
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
