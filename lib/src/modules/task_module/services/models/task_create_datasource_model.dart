import 'dart:convert';

import '../../domains/entities/task_create_entity.dart';
import '../commons/response_json_key.dart';

class TaskCreateRequestDataSourceModel extends TaskCreateRequestEntity {
  const TaskCreateRequestDataSourceModel({
    required String title,
    required String imageUrl,
  }) : super(title: title, imageUrl: imageUrl);

  String toJsonString() => json.encode(<String, String>{
        titleJsonKey: title,
        imageUrlJsonKey: imageUrl,
      });
}

class TaskCreateResponseDataSourceModel extends TaskCreateResponseEntity {
  const TaskCreateResponseDataSourceModel({
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

  factory TaskCreateResponseDataSourceModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TaskCreateResponseDataSourceModel(
      id: json[dataJsonKey]?[idJsonKey] as String,
      title: json[dataJsonKey]?[titleJsonKey] as String,
      imageUrl: json[dataJsonKey]?[imageUrlJsonKey] as String,
      isDone: json[dataJsonKey]?[isDoneJsonKey] as bool,
      createdAt: DateTime.parse(json[dataJsonKey]?[createdAtJsonKey] as String),
    );
  }
}
