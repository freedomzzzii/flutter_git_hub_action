import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_starter_kit/src/commons/constants/api_constant.dart';
import 'package:flutter_starter_kit/src/commons/constants/env_constant.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/services/commons/response_json_key.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/services/models/task_create_datasource_model.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    dotenv.testLoad();
  });

  group('TaskCreateRequestDataSourceModel Class', () {
    test('Should have TaskCreateRequestDataSourceModel Class', () {
      expect(
        TaskCreateRequestDataSourceModel,
        TaskCreateRequestDataSourceModel,
      );
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskCreateRequestDataSourceModel.title,
        expectTaskCreateResponseEntity.title,
      );
      expect(
        expectTaskCreateRequestDataSourceModel.imageUrl,
        expectTaskCreateResponseEntity.imageUrl,
      );
    });
  });

  group('TaskCreateResponseDataSourceModel Class', () {
    test('Should have TaskCreateResponseDataSourceModel Class', () {
      expect(
        TaskCreateResponseDataSourceModel,
        TaskCreateResponseDataSourceModel,
      );
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskCreateResponseDataSourceModel.id,
        expectTaskCreateResponseEntity.id,
      );
      expect(
        expectTaskCreateResponseDataSourceModel.title,
        expectTaskCreateResponseEntity.title,
      );
      expect(
        expectTaskCreateResponseDataSourceModel.imageUrl,
        expectTaskCreateResponseEntity.imageUrl,
      );
      expect(
        expectTaskCreateResponseDataSourceModel.isDone,
        expectTaskCreateResponseEntity.isDone,
      );
      expect(
        expectTaskCreateResponseDataSourceModel.createdAt,
        expectTaskCreateResponseEntity.createdAt,
      );
    });

    test('Should convert json to TaskCreateResponseDataSourceModel', () {
      final Map<String, dynamic> expectData = <String, dynamic>{
        idJsonKey: expectTaskCreateResponseEntity.id,
        titleJsonKey: expectTaskCreateResponseEntity.title,
        imageUrlJsonKey: expectTaskCreateResponseEntity.imageUrl,
        isDoneJsonKey: expectTaskCreateResponseEntity.isDone,
        createdAtJsonKey: expectTaskCreateResponseEntity.createdAt.toString(),
      };
      final Response<dynamic> mockResponseFromApi = Response<dynamic>(
        requestOptions:
            RequestOptions(path: '${dotenv.env[apiUrlEnv]}$taskResourceApi'),
        data: <String, dynamic>{
          dataJsonKey: expectData,
        },
      );
      final TaskCreateResponseDataSourceModel
          expectTaskCreateResponseApiModelJson =
          TaskCreateResponseDataSourceModel.fromJson(
        mockResponseFromApi.data as Map<String, dynamic>,
      );

      expect(
        expectTaskCreateResponseApiModelJson,
        isInstanceOf<TaskCreateResponseDataSourceModel>(),
      );
      expect(expectTaskCreateResponseApiModelJson.id, expectData[idJsonKey]);
      expect(
        expectTaskCreateResponseApiModelJson.title,
        expectData[titleJsonKey],
      );
      expect(
        expectTaskCreateResponseApiModelJson.imageUrl,
        expectData[imageUrlJsonKey],
      );
      expect(
        expectTaskCreateResponseApiModelJson.isDone,
        expectData[isDoneJsonKey],
      );
      expect(
        expectTaskCreateResponseApiModelJson.createdAt,
        DateTime.parse(expectData[createdAtJsonKey].toString()),
      );
    });
  });
}
