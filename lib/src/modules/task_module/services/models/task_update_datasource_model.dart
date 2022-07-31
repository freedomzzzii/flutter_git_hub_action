import 'dart:convert';

import '../../domains/entities/task_update_entity.dart';
import '../commons/response_json_key.dart';

class TaskUpdateRequestDataSourceModel extends TaskUpdateBodyRequestEntity {
  const TaskUpdateRequestDataSourceModel({
    String? title,
    bool? isDone,
    String? imageUrl,
  }) : super(title: title, isDone: isDone, imageUrl: imageUrl);

  String toJsonString() => json.encode(
        <String, dynamic>{
          titleJsonKey: title,
          isDoneJsonKey: isDone,
          imageUrlJsonKey: imageUrl,
        }..removeWhere(
            (dynamic key, dynamic value) => key == null || value == null,
          ),
      );
}

class TaskUpdateQueryParamsRequestDataSourceModel
    extends TaskUpdateQueryParamsRequestEntity {
  const TaskUpdateQueryParamsRequestDataSourceModel({
    required String id,
  }) : super(id: id);
}

class TaskUpdateResponseDataSourceModel extends TaskUpdateResponseEntity {
  const TaskUpdateResponseDataSourceModel({
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

  factory TaskUpdateResponseDataSourceModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TaskUpdateResponseDataSourceModel(
      id: json[dataJsonKey]?[idJsonKey] as String,
      title: json[dataJsonKey]?[titleJsonKey] as String,
      isDone: json[dataJsonKey]?[isDoneJsonKey] as bool,
      imageUrl: json[dataJsonKey]?[imageUrlJsonKey] as String,
      createdAt: DateTime.parse(json[dataJsonKey]?[createdAtJsonKey] as String),
    );
  }
}
