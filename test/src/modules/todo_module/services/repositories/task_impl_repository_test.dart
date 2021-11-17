import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poc_clean_arch/src/modules/todo_module/commons/errors/repository_error.dart';
import 'package:poc_clean_arch/src/modules/todo_module/domains/entities/task_create_entity.dart';
import 'package:poc_clean_arch/src/modules/todo_module/domains/entities/task_get_entity.dart';
import 'package:poc_clean_arch/src/modules/todo_module/domains/entities/task_update_entity.dart';
import 'package:poc_clean_arch/src/modules/todo_module/services/datasources/api_datasource.dart';
import 'package:poc_clean_arch/src/modules/todo_module/services/models/task_create_datasource_model.dart';
import 'package:poc_clean_arch/src/modules/todo_module/services/models/task_delete_datasource_model.dart';
import 'package:poc_clean_arch/src/modules/todo_module/services/models/task_get_datasource_model.dart';
import 'package:poc_clean_arch/src/modules/todo_module/services/models/task_update_datasource_model.dart';
import 'package:poc_clean_arch/src/modules/todo_module/services/repositories/task_impl_repository.dart';

import '../../../../../test_data/mock_test_data.dart';
import '../datasources/api_datasource_test.mocks.dart';

@GenerateMocks(<Type>[TaskImplRepository])
void main() {
  final MockApiDataSource mockDataSource = MockApiDataSource();
  final TaskImplRepository expectTaskImplRepository =
      TaskImplRepository(dataSource: mockDataSource);

  setUpAll(() {
    dotenv.testLoad();
  });

  group('TaskImplRepository Class', () {
    test('Should have TaskImplRepository Class', () {
      expect(TaskImplRepository, TaskImplRepository);
    });

    test('Should have mandatory properties', () {
      final MockDio mockDio = MockDio();
      final ApiDataSource expectApiDataSource = ApiDataSource(http: mockDio);
      final TaskImplRepository expectTaskImplRepository =
          TaskImplRepository(dataSource: expectApiDataSource);

      expect(expectTaskImplRepository.dataSource, expectApiDataSource);
    });
  });

  group('Create method', () {
    test('Should have create method - Success case', () async {
      when(
        mockDataSource.create(
          task: argThat(
            isA<TaskCreateRequestDataSourceModel>(),
            named: 'task',
          ),
        ),
      ).thenAnswer(
        (_) => Future<TaskCreateResponseDataSourceModel>.value(
          expectTaskCreateResponseDataSourceModel,
        ),
      );

      final TaskCreateResponseEntity expectValue =
          await expectTaskImplRepository.create(
        task: expectTaskCreateRequestEntity,
      );

      expect(expectValue.id, expectTaskCreateResponseDataSourceModel.id);
      expect(expectValue.title, expectTaskCreateResponseDataSourceModel.title);
      expect(
        expectValue.imageUrl,
        expectTaskCreateResponseDataSourceModel.imageUrl,
      );
      expect(
        expectValue.isDone,
        expectTaskCreateResponseDataSourceModel.isDone,
      );
      expect(
        expectValue.createdAt,
        expectTaskCreateResponseDataSourceModel.createdAt,
      );
    });

    test('Should have create method - Failure case', () async {
      when(
        mockDataSource.create(
          task: argThat(
            isA<TaskCreateRequestDataSourceModel>(),
            named: 'task',
          ),
        ),
      ).thenThrow(expectDataSourceErrorRequiredField.message);

      expect(
        () async => expectTaskImplRepository.create(
          task: expectTaskCreateRequestEntity,
        ),
        throwsA(isA<RepositoryError>()),
      );

      expect(
        () async => expectTaskImplRepository.create(
          task: expectTaskCreateRequestEntity,
        ),
        throwsA(
          predicate(
            (Error e) =>
                e is RepositoryError &&
                e.toString().contains(
                      expectDataSourceErrorRequiredField.message,
                    ),
          ),
        ),
      );
    });
  });

  group('Get method', () {
    test('Should have get method - Success case', () async {
      when(
        mockDataSource.get(
          query: argThat(
            isA<TaskGetRequestEntity>(),
            named: 'query',
          ),
        ),
      ).thenAnswer(
        (_) => Future<List<TaskGetResponseDataSourceModel>>.value(
          expectTaskGetResponseDataSourceModelList,
        ),
      );

      final List<TaskGetResponseEntity>? expectValue =
          await expectTaskImplRepository.get(query: expectTaskGetRequestEntity);

      expectValue?.forEach((TaskGetResponseEntity task) {
        expect(task.id, expectTaskGetResponseDataSourceModel.id);
        expect(task.title, expectTaskGetResponseDataSourceModel.title);
        expect(task.imageUrl, expectTaskGetResponseDataSourceModel.imageUrl);
        expect(task.isDone, expectTaskGetResponseDataSourceModel.isDone);
        expect(task.createdAt, expectTaskGetResponseDataSourceModel.createdAt);
      });
    });

    test('Should have get method - Failure case', () async {
      when(
        mockDataSource.get(
          query: argThat(isA<TaskGetRequestEntity>(), named: 'query'),
        ),
      ).thenThrow(expectDataSourceError.message);

      expect(
        () async =>
            expectTaskImplRepository.get(query: expectTaskGetRequestEntity),
        throwsA(isA<RepositoryError>()),
      );

      expect(
        () async =>
            expectTaskImplRepository.get(query: expectTaskGetRequestEntity),
        throwsA(
          predicate(
            (Error e) =>
                e is RepositoryError &&
                e.toString().contains(expectDataSourceError.message),
          ),
        ),
      );
    });
  });

  group('Delete method', () {
    test('Should have delete method - Failure case', () async {
      when(
        mockDataSource.delete(
          queryParams: argThat(
            isA<TaskDeleteQueryParamsRequestDataSourceModel>(),
            named: 'queryParams',
          ),
        ),
      ).thenThrow(expectRepositoryError);

      expect(
        () async => expectTaskImplRepository.delete(
          queryParams: expectTaskDeleteQueryParamsRequestEntity,
        ),
        throwsA(isA<RepositoryError>()),
      );

      expect(
        () async => expectTaskImplRepository.delete(
          queryParams: expectTaskDeleteQueryParamsRequestEntity,
        ),
        throwsA(
          predicate(
            (Error e) => e.toString().contains(expectDataSourceError.message),
          ),
        ),
      );
    });
  });

  group('Update method', () {
    test('Should have update method', () async {
      when(
        mockDataSource.update(
          task: anyNamed('task'),
          queryParams: anyNamed('queryParams'),
        ),
      ).thenAnswer(
        (_) => Future<TaskUpdateResponseDataSourceModel>.value(
          expectTaskUpdateResponseDataSourceModel,
        ),
      );

      final TaskUpdateResponseEntity expectValue =
          await expectTaskImplRepository.update(
        task: expectTaskUpdateRequestEntity,
        queryParams: expectTaskUpdateQueryParamsRequestEntity,
      );

      expect(expectValue.id, expectTaskUpdateResponseDataSourceModel.id);
      expect(expectValue.title, expectTaskUpdateResponseDataSourceModel.title);
      expect(
        expectValue.isDone,
        expectTaskUpdateResponseDataSourceModel.isDone,
      );
      expect(
        expectValue.imageUrl,
        expectTaskUpdateResponseDataSourceModel.imageUrl,
      );
      expect(
        expectValue.createdAt,
        expectTaskUpdateResponseDataSourceModel.createdAt,
      );
    });

    test('Should have update method - Failure case', () async {
      when(
        mockDataSource.update(
          task: argThat(
            isA<TaskUpdateRequestDataSourceModel>(),
            named: 'task',
          ),
          queryParams: argThat(
            isA<TaskUpdateQueryParamsRequestDataSourceModel>(),
            named: 'queryParams',
          ),
        ),
      ).thenThrow(expectRepositoryError);

      expect(
        () async => expectTaskImplRepository.update(
          task: expectTaskUpdateRequestEntity,
          queryParams: expectTaskUpdateQueryParamsRequestEntity,
        ),
        throwsA(
          isA<RepositoryError>(),
        ),
      );

      expect(
        () async => expectTaskImplRepository.update(
          task: expectTaskUpdateRequestEntity,
          queryParams: expectTaskUpdateQueryParamsRequestEntity,
        ),
        throwsA(
          predicate(
            (Error e) => e.toString().contains(expectDataSourceError.message),
          ),
        ),
      );
    });
  });
}
