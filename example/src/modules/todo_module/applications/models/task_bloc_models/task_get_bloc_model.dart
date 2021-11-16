import '../../../domains/entities/task_get_entity.dart';

class TaskGetRequestBlocModel extends TaskGetRequestEntity {
  const TaskGetRequestBlocModel({
    required String sortBy,
    required String orderBy,
  }) : super(sortBy: sortBy, orderBy: orderBy);
}

class TaskGetResponseBlocModel extends TaskGetResponseEntity {
  const TaskGetResponseBlocModel({
    required String title,
  }) : super(title: title);
}
