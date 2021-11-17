import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poc_clean_arch/src/commons/constants/api_constant.dart';
import 'package:poc_clean_arch/src/commons/constants/env_constant.dart';
import 'package:poc_clean_arch/src/modules/todo_module/services/commons/response_json_key.dart';
import 'package:poc_clean_arch/src/modules/todo_module/services/models/task_get_datasource_model.dart';

import '../../../../../test_data/mock_test_data.dart';

void main() {
  setUpAll(() {
    dotenv.testLoad();
  });

  group('TaskGetRequestDataSourceModel Class', () {
    test('Should have TaskGetRequestDataSourceModel Class', () {
      expect(TaskGetRequestDataSourceModel, TaskGetRequestDataSourceModel);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskGetRequestDataSourceModel.sortBy,
        expectTaskGetRequestEntity.sortBy,
      );
      expect(
        expectTaskGetRequestDataSourceModel.orderBy,
        expectTaskGetRequestEntity.orderBy,
      );
    });
  });

  group('TaskGetResponseDataSourceModel Class', () {
    test('Should have TaskGetResponseDataSourceModel Class', () {
      expect(TaskGetResponseDataSourceModel, TaskGetResponseDataSourceModel);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskGetResponseDataSourceModel.title,
        expectTaskGetResponseEntity.title,
      );
      expect(
        expectTaskGetResponseDataSourceModel.imageUrl,
        expectTaskGetResponseEntity.imageUrl,
      );
    });

    test('Should convert json to TaskGetResponseDataSourceModel', () {
      final Map<String, dynamic> expectData = <String, dynamic>{
        idJsonKey: expectTaskGetResponseEntity.id,
        titleJsonKey: expectTaskGetResponseEntity.title,
        imageUrlJsonKey: expectTaskGetResponseEntity.imageUrl,
        isDoneJsonKey: expectTaskGetResponseEntity.isDone,
        createdAtJsonKey: expectTaskGetResponseEntity.createdAt.toString(),
      };
      final Response<dynamic> mockResponseFromApi = Response<dynamic>(
        requestOptions:
            RequestOptions(path: '${dotenv.env[apiUrlEnv]}$taskResourceApi'),
        data: <String, dynamic>{
          dataJsonKey: <Map<String, dynamic>>[
            expectData,
            expectData,
          ],
        },
      );

      final List<TaskGetResponseDataSourceModel>
          expectListTaskGetResponseDataSourceModel = mockResponseFromApi
              .data[dataJsonKey]
              ?.map<TaskGetResponseDataSourceModel>(
                  (Map<String, dynamic> data) {
        final TaskGetResponseDataSourceModel
            expectTaskGetResponseDataSourceModel =
            TaskGetResponseDataSourceModel.fromJson(data);

        expect(expectTaskGetResponseDataSourceModel.id, expectData[idJsonKey]);
        expect(
          expectTaskGetResponseDataSourceModel.title,
          expectData[titleJsonKey],
        );
        expect(
          expectTaskGetResponseDataSourceModel.imageUrl,
          expectData[imageUrlJsonKey],
        );
        expect(
          expectTaskGetResponseDataSourceModel.isDone,
          expectData[isDoneJsonKey],
        );
        expect(
          expectTaskGetResponseDataSourceModel.createdAt,
          DateTime.parse(expectData[createdAtJsonKey].toString()),
        );

        return expectTaskGetResponseDataSourceModel;
      }).toList() as List<TaskGetResponseDataSourceModel>;

      expect(
        expectListTaskGetResponseDataSourceModel,
        isInstanceOf<List<TaskGetResponseDataSourceModel>>(),
      );
    });
  });
}
