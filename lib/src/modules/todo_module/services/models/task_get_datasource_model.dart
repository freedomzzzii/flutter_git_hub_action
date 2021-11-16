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
    required String id,
    required String title,
    required String imageUrl,
    required bool isDone,
    required DateTime createdAt,
  }) : super(
          id: id,
          title: title,
          imageUrl: imageUrl,
          isDone: isDone,
          createdAt: createdAt,
        );

  factory TaskGetResponseDataSourceModel.fromJson(Map<String, dynamic> json) {
    return TaskGetResponseDataSourceModel(
      id: json[idJsonKey] as String,
      title: json[titleJsonKey] as String,
      imageUrl: json[imageUrlJsonKey] as String,
      isDone: json[isDoneJsonKey] as bool,
      createdAt: DateTime.parse(json[createdAtJsonKey] as String),
    );
  }
}
