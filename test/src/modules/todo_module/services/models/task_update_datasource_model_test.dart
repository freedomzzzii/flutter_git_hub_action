import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poc_clean_arch/src/modules/todo_module/services/commons/response_json_key.dart';
import 'package:poc_clean_arch/src/modules/todo_module/services/models/task_update_datasource_model.dart';

import '../../../../../test_data/mock_test_data.dart';

void main() {
  group('Test TaskUpdateRequestDataSourceModel', () {
    setUpAll(() {
      dotenv.testLoad();
    });
    test('Should have TaskUpdateRequestDataSourceModel', () {
      expect(
        TaskUpdateRequestDataSourceModel,
        TaskUpdateRequestDataSourceModel,
      );
    });

    test('''
Should convert TaskUpdateRequestEntity to TaskUpdateRequestDataSourceModel''',
        () {
      final String expectTaskUpdateRequestApiModelJson =
          expectTaskUpdateRequestDataSourceModel.toJsonString();

      expect(
        expectTaskUpdateRequestApiModelJson
            .contains(expectTaskGetResponseEntity.title),
        true,
      );
      expect(
        expectTaskUpdateRequestApiModelJson
            .contains(expectTaskGetResponseEntity.isDone.toString()),
        true,
      );
      expect(
        expectTaskUpdateRequestApiModelJson
            .contains(expectTaskGetResponseEntity.imageUrl),
        true,
      );
    });

    test('Should not have null data', () {
      final String expectNoneNullTaskUpdateRequestApiModelJson =
          TaskUpdateRequestDataSourceModel(
        title: expectTaskGetResponseEntity.title,
        isDone: expectTaskGetResponseEntity.isDone,
      ).toJsonString();

      expect(
        expectNoneNullTaskUpdateRequestApiModelJson.contains('title'),
        true,
      );
      expect(
        expectNoneNullTaskUpdateRequestApiModelJson
            .contains(expectTaskGetResponseEntity.title),
        true,
      );
      expect(
        expectNoneNullTaskUpdateRequestApiModelJson.contains('isDone'),
        true,
      );
      expect(
        expectNoneNullTaskUpdateRequestApiModelJson
            .contains(expectTaskGetResponseEntity.isDone.toString()),
        true,
      );
      expect(
        expectNoneNullTaskUpdateRequestApiModelJson.contains('imageUrl'),
        false,
      );
    });
  });

  group('Test TaskUpdateQueryParamsRequestDataSourceModel', () {
    test('Should have TaskUpdateQueryParamsRequestDataSourceModel', () {
      expect(
        TaskUpdateQueryParamsRequestDataSourceModel,
        TaskUpdateQueryParamsRequestDataSourceModel,
      );
    });
  });

  group('Test TaskUpdateResponseDataSourceModel', () {
    final Map<String, Object> expectData = <String, Object>{
      idJsonKey: expectTaskGetResponseEntity.id,
      titleJsonKey: expectTaskGetResponseEntity.title,
      imageUrlJsonKey: expectTaskGetResponseEntity.imageUrl,
      isDoneJsonKey: expectTaskGetResponseEntity.isDone,
      createdAtJsonKey: expectTaskGetResponseEntity.createdAt.toString(),
    };
    final Response<dynamic> mockResponseFromApi = Response<dynamic>(
      requestOptions: RequestOptions(path: '/dummy-path'),
      data: <String, dynamic>{
        dataJsonKey: expectData,
      },
    );
    final TaskUpdateResponseDataSourceModel
        taskUpdateResponseDataSourceModelJson =
        TaskUpdateResponseDataSourceModel.fromJson(
      mockResponseFromApi.data as Map<String, dynamic>,
    );

    final TaskUpdateResponseDataSourceModel
        expectTaskUpdateResponseDataSourceModelJson =
        TaskUpdateResponseDataSourceModel.fromJson(
      mockResponseFromApi.data as Map<String, dynamic>,
    );

    test('Should have TaskUpdateResponseDataSourceModel', () {
      expect(
        TaskUpdateResponseDataSourceModel,
        TaskUpdateResponseDataSourceModel,
      );
    });

    test('Should convert json to TaskUpdateResponseDataSourceModel', () {
      expect(
        expectTaskUpdateResponseDataSourceModelJson,
        isInstanceOf<TaskUpdateResponseDataSourceModel>(),
      );
      expect(
        expectTaskUpdateResponseDataSourceModelJson.id,
        taskUpdateResponseDataSourceModelJson.id,
      );
      expect(
        expectTaskUpdateResponseDataSourceModelJson.title,
        taskUpdateResponseDataSourceModelJson.title,
      );
      expect(
        expectTaskUpdateResponseDataSourceModelJson.imageUrl,
        taskUpdateResponseDataSourceModelJson.imageUrl,
      );
      expect(
        expectTaskUpdateResponseDataSourceModelJson.isDone,
        taskUpdateResponseDataSourceModelJson.isDone,
      );
      expect(
        taskUpdateResponseDataSourceModelJson.createdAt,
        DateTime.parse(
          expectTaskUpdateResponseDataSourceModelJson.createdAt.toString(),
        ),
      );
    });
  });
}
