import '../../domains/entities/task_get_entity.dart';
import '../commons/response_json_key.dart';

class TaskGetRequestDataSourceModel extends TaskGetRequestEntity {
  const TaskGetRequestDataSourceModel({
    required String sortBy,
    required String orderBy,
  }) : super(sortBy: sortBy, orderBy: orderBy);

  String toQueryString() => '?sortBy=$sortBy&orderBy=$orderBy';
}

class TaskGetResponseDataSourceModel extends TaskGetResponseEntity {
  const TaskGetResponseDataSourceModel({
    required String title,
  }) : super(title: title);

  factory TaskGetResponseDataSourceModel.fromJson(Map<String, dynamic> json) {
    return TaskGetResponseDataSourceModel(
      title: json[titleJsonKey] as String,
    );
  }
}
