import '../../../domains/entities/task_get_entity.dart';

class TaskGetRequestBlocModel extends TaskGetRequestEntity {
  const TaskGetRequestBlocModel({
    required String sortBy,
    required String orderBy,
  }) : super(sortBy: sortBy, orderBy: orderBy);
}

class TaskGetResponseBlocModel extends TaskGetResponseEntity {
  const TaskGetResponseBlocModel({
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
