import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_starter_kit/src/commons/constants/api_constant.dart';
import 'package:flutter_starter_kit/src/commons/constants/env_constant.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/commons/errors/datasource_error.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/services/commons/response_json_key.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/services/datasources/api_datasource.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/services/models/task_create_datasource_model.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/services/models/task_delete_datasource_model.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/services/models/task_get_datasource_model.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/services/models/task_update_datasource_model.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_datasource_test.mocks.dart';

@GenerateMocks(<Type>[Dio, ApiDataSource])
void main() {
  final MockDio mockDio = MockDio();
  final ApiDataSource expectApiDataSource = ApiDataSource(http: mockDio);
  late DioError mockResponseCreateErrorFromApi;
  late DioError mockResponseGetErrorFromApi;
  late Response<dynamic> mockResponseCreateUpdateDeleteSuccessFromApi;
  late Response<dynamic> mockResponseGetSuccessFromApi;
  late DioError mockResponseUpdateDeleteErrorFromApi;

  final Map<String, dynamic> expectData = <String, dynamic>{
    idJsonKey: expectTaskGetResponseEntity.id,
    titleJsonKey: expectTaskGetResponseEntity.title,
    imageUrlJsonKey: expectTaskGetResponseEntity.imageUrl,
    isDoneJsonKey: expectTaskGetResponseEntity.isDone,
    createdAtJsonKey: expectTaskGetResponseEntity.createdAt.toString(),
  };

  final List<Map<String, dynamic>> expectErrors = <Map<String, dynamic>>[
    <String, dynamic>{
      titleJsonKey: expectDataSourceError.message,
      codeJsonKey: errorRequireFieldCodeAPI,
      messageJsonKey: expectDataSourceError.message,
    },
    <String, dynamic>{
      titleJsonKey: expectDataSourceError.message,
      codeJsonKey: errorRequireFieldCodeAPI,
      messageJsonKey: expectDataSourceError.message,
    },
  ];

  setUpAll(() {
    dotenv.testLoad();

    mockResponseCreateUpdateDeleteSuccessFromApi = Response<dynamic>(
      requestOptions:
          RequestOptions(path: '${dotenv.env[apiUrlEnv]}$taskResourceApi'),
      data: <String, dynamic>{
        dataJsonKey: expectData,
      },
    );

    mockResponseGetSuccessFromApi = Response<dynamic>(
      requestOptions: RequestOptions(
        path: '''
${dotenv.env[apiUrlEnv]}$taskResourceApi$expectTaskGetRequestDataSourceModelString''',
      ),
      data: <String, dynamic>{
        dataJsonKey: <Map<String, dynamic>>[
          expectData,
          expectData,
        ],
      },
    );

    mockResponseCreateErrorFromApi = DioError(
      requestOptions:
          RequestOptions(path: '${dotenv.env[apiUrlEnv]}$taskResourceApi'),
      response: Response<dynamic>(
        requestOptions:
            RequestOptions(path: '${dotenv.env[apiUrlEnv]}$taskResourceApi'),
        data: <String, dynamic>{
          errorsJsonKey: expectErrors,
        },
        statusCode: HttpStatus.badRequest,
      ),
    );

    mockResponseGetErrorFromApi = DioError(
      requestOptions: RequestOptions(
        path: '''
${dotenv.env[apiUrlEnv]}$taskResourceApi$expectTaskGetRequestDataSourceModelString''',
      ),
      response: Response<dynamic>(
        requestOptions: RequestOptions(
          path: '''
${dotenv.env[apiUrlEnv]}$taskResourceApi$expectTaskGetRequestDataSourceModelString''',
        ),
        data: <String, dynamic>{
          errorsJsonKey: expectErrors,
        },
        statusCode: HttpStatus.badRequest,
      ),
    );

    mockResponseUpdateDeleteErrorFromApi = DioError(
      requestOptions: RequestOptions(
        path: '''
${dotenv.env[apiUrlEnv]}$taskResourceApi${expectTaskGetResponseEntity.id}''',
      ),
      response: Response<dynamic>(
        requestOptions: RequestOptions(
          path: '''
${dotenv.env[apiUrlEnv]}$taskResourceApi${expectTaskGetResponseEntity.id}''',
        ),
        data: <String, dynamic>{
          errorsJsonKey: expectErrors,
        },
        statusCode: HttpStatus.badRequest,
      ),
    );
  });

  tearDown(() {
    clearInteractions(mockDio);
  });

  group('ApiDataSource Class', () {
    test('Should have ApiDataSource Class', () {
      expect(ApiDataSource, ApiDataSource);
    });

    test('Should have mandatory properties', () {
      expect(expectApiDataSource.http, mockDio);
    });
  });

  group('Create method', () {
    test('Should have create method - Success case', () async {
      when(
        mockDio.post(
          '${dotenv.env[apiUrlEnv]}$taskResourceApi',
          data: argThat(isA<String>(), named: 'data'),
        ),
      ).thenAnswer(
        (_) => Future<Response<dynamic>>.value(
          mockResponseCreateUpdateDeleteSuccessFromApi,
        ),
      );

      final TaskCreateResponseDataSourceModel expectApiDataSourceCreate =
          await expectApiDataSource.create(
        task: expectTaskCreateRequestDataSourceModel,
      );

      expect(
        expectApiDataSourceCreate,
        isA<TaskCreateResponseDataSourceModel>(),
      );
      expect(expectApiDataSourceCreate.id, expectData[idJsonKey]);
      expect(expectApiDataSourceCreate.title, expectData[titleJsonKey]);
      expect(expectApiDataSourceCreate.imageUrl, expectData[imageUrlJsonKey]);
      expect(expectApiDataSourceCreate.isDone, expectData[isDoneJsonKey]);
      expect(
        expectApiDataSourceCreate.createdAt,
        DateTime.parse(expectData[createdAtJsonKey] as String),
      );
    });

    test('Should have create method - Failure case (error from API)', () async {
      const TaskCreateRequestDataSourceModel
          expectTaskCreateRequestDataSourceModel =
          TaskCreateRequestDataSourceModel(
        title: '',
        imageUrl: '',
      );

      when(
        mockDio.post(
          '${dotenv.env[apiUrlEnv]}$taskResourceApi',
          data: argThat(isA<String>(), named: 'data'),
        ),
      ).thenThrow(mockResponseCreateErrorFromApi);

      expect(
        () async => expectApiDataSource.create(
          task: expectTaskCreateRequestDataSourceModel,
        ),
        throwsA(isA<DataSourceError>()),
      );

      expect(
        () async => expectApiDataSource.create(
          task: expectTaskCreateRequestDataSourceModel,
        ),
        throwsA(
          predicate(
            (Error e) =>
                e is DataSourceError &&
                e.toString().contains(
                  '''
${expectDataSourceErrorRequiredField.message}, ${expectDataSourceErrorRequiredField.message}''',
                ),
          ),
        ),
      );

      verify(
        mockDio.post(
          '${dotenv.env[apiUrlEnv]}$taskResourceApi',
          data: argThat(isA<String>(), named: 'data'),
        ),
      ).called(2);
    });

    test('Should have create method - Failure case (other error)', () async {
      when(
        mockDio.post(
          '${dotenv.env[apiUrlEnv]}$taskResourceApi',
          data: argThat(isA<String>(), named: 'data'),
        ),
      ).thenThrow(faker.person.name());

      expect(
        () async => expectApiDataSource.create(
          task: expectTaskCreateRequestDataSourceModel,
        ),
        throwsA(isA<DataSourceError>()),
      );

      verify(
        mockDio.post(
          '${dotenv.env[apiUrlEnv]}$taskResourceApi',
          data: argThat(isA<String>(), named: 'data'),
        ),
      ).called(1);
    });
  });

  group('Get method', () {
    test('Should have get method - Success case', () async {
      when(
        mockDio.get(
          '''
${dotenv.env[apiUrlEnv]}$taskResourceApi$expectTaskGetRequestDataSourceModelString''',
        ),
      ).thenAnswer(
        (_) => Future<Response<dynamic>>.value(
          mockResponseGetSuccessFromApi,
        ),
      );

      final List<TaskGetResponseDataSourceModel>? expectValue =
          await expectApiDataSource.get(
        query: expectTaskGetRequestDataSourceModel,
      );

      expectValue?.forEach((TaskGetResponseDataSourceModel task) {
        expect(task, isA<TaskGetResponseDataSourceModel>());
        expect(task.id, expectData[idJsonKey]);
        expect(task.title, expectData[titleJsonKey]);
        expect(task.imageUrl, expectData[imageUrlJsonKey]);
        expect(task.isDone, expectData[isDoneJsonKey]);
        expect(
          task.createdAt,
          DateTime.parse(
            expectData[createdAtJsonKey] as String,
          ),
        );
      });
    });

    test('Should have get method - Failure case (error from API)', () async {
      when(
        mockDio.get(
          '''
${dotenv.env[apiUrlEnv]}$taskResourceApi$expectTaskGetRequestDataSourceModelString''',
        ),
      ).thenThrow(mockResponseGetErrorFromApi);

      expect(
        () async => expectApiDataSource.get(
          query: expectTaskGetRequestDataSourceModel,
        ),
        throwsA(isA<DataSourceError>()),
      );

      expect(
        () async =>
            expectApiDataSource.get(query: expectTaskGetRequestDataSourceModel),
        throwsA(
          predicate(
            (Error e) =>
                e is DataSourceError &&
                e.toString().contains(expectDataSourceError.toString()),
          ),
        ),
      );

      verify(
        mockDio.get(
          '''
${dotenv.env[apiUrlEnv]}$taskResourceApi$expectTaskGetRequestDataSourceModelString''',
        ),
      ).called(2);
    });

    test('Should have get method - Failure case (other error)', () async {
      when(
        mockDio.post(
          '''
${dotenv.env[apiUrlEnv]}$taskResourceApi$expectTaskGetRequestDataSourceModelString''',
          data: argThat(isA<String>(), named: 'data'),
        ),
      ).thenThrow(faker.person.name());

      expect(
        () async =>
            expectApiDataSource.get(query: expectTaskGetRequestDataSourceModel),
        throwsA(isA<DataSourceError>()),
      );

      verify(
        mockDio.get(
          '''
${dotenv.env[apiUrlEnv]}$taskResourceApi$expectTaskGetRequestDataSourceModelString''',
        ),
      ).called(1);
    });
  });

  group('Update method', () {
    test('Should have update method', () async {
      when(
        mockDio.patch(
          '${dotenv.env[apiUrlEnv]}$taskResourceApi/${expectTaskGetResponseEntity.id}',
          data: argThat(isA<String>(), named: 'data'),
        ),
      ).thenAnswer(
        (_) => Future<Response<dynamic>>.value(
          mockResponseCreateUpdateDeleteSuccessFromApi,
        ),
      );

      final TaskUpdateResponseDataSourceModel expectApiDataSourceUpdate =
          await expectApiDataSource.update(
        task: expectTaskUpdateRequestDataSourceModel,
        queryParams: expectTaskUpdateQueryParamsRequestDataSourceModel,
      );

      expect(expectApiDataSourceUpdate.id, expectTaskGetResponseEntity.id);
      expect(
        expectApiDataSourceUpdate.title,
        expectTaskGetResponseEntity.title,
      );
      expect(
        expectApiDataSourceUpdate.imageUrl,
        expectTaskGetResponseEntity.imageUrl,
      );
      expect(
        expectApiDataSourceUpdate.isDone,
        expectTaskGetResponseEntity.isDone,
      );
      expect(
        expectApiDataSourceUpdate.createdAt,
        expectTaskGetResponseEntity.createdAt,
      );
    });

    test('Should have update method - Failure case', () async {
      const TaskUpdateRequestDataSourceModel
          expectTaskUpdateRequestDataSourceModel =
          TaskUpdateRequestDataSourceModel(
        title: '',
        imageUrl: '',
      );

      when(
        mockDio.patch(
          '${dotenv.env[apiUrlEnv]}$taskResourceApi/${expectTaskGetResponseEntity.id}',
          data: argThat(isA<String>(), named: 'data'),
        ),
      ).thenThrow(mockResponseUpdateDeleteErrorFromApi);

      expect(
        () async => expectApiDataSource.update(
          task: expectTaskUpdateRequestDataSourceModel,
          queryParams: expectTaskUpdateQueryParamsRequestDataSourceModel,
        ),
        throwsA(isA<DataSourceError>()),
      );

      expect(
        () async => expectApiDataSource.update(
          task: expectTaskUpdateRequestDataSourceModel,
          queryParams: expectTaskUpdateQueryParamsRequestDataSourceModel,
        ),
        throwsA(
          predicate(
            (Error e) =>
                e is DataSourceError &&
                e.toString().contains(expectDataSourceError.message),
          ),
        ),
      );

      verify(
        mockDio.patch(
          '${dotenv.env[apiUrlEnv]}$taskResourceApi/${expectTaskGetResponseEntity.id}',
          data: argThat(isA<String>(), named: 'data'),
        ),
      ).called(2);
    });
  });

  group('Delete method', () {
    test('Should have delete method - Failure case', () async {
      const TaskDeleteQueryParamsRequestDataSourceModel
          expectTaskDeleteQueryParamsRequestDataSourceModel =
          TaskDeleteQueryParamsRequestDataSourceModel(
        id: '',
      );

      when(mockDio.delete('${dotenv.env[apiUrlEnv]}$taskResourceApi/'))
          .thenThrow(mockResponseUpdateDeleteErrorFromApi);

      expect(
        () async => expectApiDataSource.delete(
          queryParams: expectTaskDeleteQueryParamsRequestDataSourceModel,
        ),
        throwsA(isA<DataSourceError>()),
      );

      expect(
        () async => expectApiDataSource.delete(
          queryParams: expectTaskDeleteQueryParamsRequestDataSourceModel,
        ),
        throwsA(
          predicate(
            (Error e) =>
                e is DataSourceError &&
                e.toString().contains(expectDataSourceError.message),
          ),
        ),
      );

      verify(mockDio.delete('${dotenv.env[apiUrlEnv]}$taskResourceApi/'))
          .called(2);
    });
  });
}
