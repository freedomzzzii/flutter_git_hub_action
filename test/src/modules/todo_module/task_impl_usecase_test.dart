import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/commons/errors/usecase_error.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/commons/exceptions/usecase_exception.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/configs/usecasae_messages/usecase_message_config.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/domains/entities/task_create_entity.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/domains/entities/task_delete_entity.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/domains/entities/task_get_entity.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/domains/entities/task_update_entity.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/task_impl_usecase.dart';
import 'package:flutter_starter_kit/src/utils/error_code/error_code_util.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:universal_html/html.dart';

import 'task_impl_repository_test.dart';
import 'task_impl_repository_test.mocks.dart';

class FakeTaskImplSseUseCase extends Fake implements TaskImplSseUseCase {
  @override
  EventSource get() {
    return expectEventSource;
  }
}

@GenerateMocks(<Type>[TaskImplUseCase])
void main() {
  final MockTaskImplRepository mockTaskImpRepository = MockTaskImplRepository();
  final TaskImplUseCase expectTaskImplUseCase =
      TaskImplUseCase(repository: mockTaskImpRepository);

  setUpAll(() {
    dotenv.testLoad();
  });

  tearDown(() {
    clearInteractions(mockTaskImpRepository);
  });

  group('TaskImplUseCase', () {
    group('TaskImplUseCase Class', () {
      test('Should have TaskImplUseCase Class', () {
        expect(TaskImplUseCase, TaskImplUseCase);
      });

      test('Should have mandatory properties', () async {
        expect(expectTaskImplUseCase.repository, mockTaskImpRepository);
      });
    });

    group('Create method', () {
      test('Should have create method - Success case', () async {
        when(
          mockTaskImpRepository.create(
            task: argThat(isA<TaskCreateRequestEntity>(), named: 'task'),
          ),
        ).thenAnswer(
          (_) => Future<TaskCreateResponseEntity>.value(
            expectTaskCreateResponseEntity,
          ),
        );

        final TaskCreateResponseEntity expectValue =
            await expectTaskImplUseCase.create(
          task: expectTaskCreateRequestEntity,
        );

        verify(
          mockTaskImpRepository.create(
            task: argThat(isA<TaskCreateRequestEntity>(), named: 'task'),
          ),
        ).called(1);

        expect(expectValue.id, expectTaskCreateResponseEntity.id);
        expect(expectValue.title, expectTaskCreateResponseEntity.title);
        expect(expectValue.imageUrl, expectTaskCreateResponseEntity.imageUrl);
        expect(expectValue.isDone, expectTaskCreateResponseEntity.isDone);
        expect(expectValue.createdAt, expectTaskCreateResponseEntity.createdAt);
      });

      test('Should have create method - Failure case (title empty)', () async {
        final TaskCreateRequestEntity expectTaskCreateRequestEntityTitleEmpty =
            TaskCreateRequestEntity(
          imageUrl: faker.image.image(),
          title: '',
        );

        expect(
          () async => expectTaskImplUseCase.create(
            task: expectTaskCreateRequestEntityTitleEmpty,
          ),
          throwsA(isA<TaskCreateUseCaseError>()),
        );

        expect(
          () async => expectTaskImplUseCase.create(
            task: expectTaskCreateRequestEntityTitleEmpty,
          ),
          throwsA(
            predicate(
              (Error e) =>
                  e is TaskCreateUseCaseError &&
                  e.toString().contains(
                        expectTaskFieldValidationExceptionTitleEmpty.toString(),
                      ),
            ),
          ),
        );
      });

      test('Should have create method - Failure case (imageUrl empty)',
          () async {
        final TaskCreateRequestEntity
            expectTaskCreateRequestEntityImageUrlEmpty =
            TaskCreateRequestEntity(
          imageUrl: '',
          title: faker.person.name(),
        );
        const FieldValidationException
            expectTaskFieldValidationExceptionImageUrlEmpty =
            FieldValidationException(
          message: requiredImageUrlMessage,
          code: appErrorCodes.missingRequiredFields,
        );

        expect(
          () async => expectTaskImplUseCase.create(
            task: expectTaskCreateRequestEntityImageUrlEmpty,
          ),
          throwsA(isA<TaskCreateUseCaseError>()),
        );

        expect(
          () async => expectTaskImplUseCase.create(
            task: expectTaskCreateRequestEntityImageUrlEmpty,
          ),
          throwsA(
            predicate(
              (Error e) =>
                  e is TaskCreateUseCaseError &&
                  e.toString().contains(
                        expectTaskFieldValidationExceptionImageUrlEmpty
                            .toString(),
                      ),
            ),
          ),
        );
      });

      test('''
Should have create method - Failure case (throw error from repository)''',
          () async {
        when(
          mockTaskImpRepository.create(
            task: argThat(isA<TaskCreateRequestEntity>(), named: 'task'),
          ),
        ).thenThrow(expectRepositoryError);

        expect(
          () async => expectTaskImplUseCase.create(
            task: expectTaskCreateRequestEntity,
          ),
          throwsA(isA<TaskCreateUseCaseError>()),
        );

        expect(
          () async => expectTaskImplUseCase.create(
            task: expectTaskCreateRequestEntity,
          ),
          throwsA(
            predicate(
              (Error e) =>
                  e is TaskCreateUseCaseError &&
                  e.toString().contains(expectRepositoryError.toString()),
            ),
          ),
        );

        verify(
          mockTaskImpRepository.create(
            task: argThat(isA<TaskCreateRequestEntity>(), named: 'task'),
          ),
        ).called(2);
      });
    });

    group('Get method', () {
      test('Should have get method - Success case', () async {
        when(
          mockTaskImpRepository.get(
            query: argThat(isA<TaskGetRequestEntity>(), named: 'query'),
          ),
        ).thenAnswer(
          (_) => Future<List<TaskGetResponseEntity>>.value(
            expectTaskGetResponseEntityList,
          ),
        );

        final List<TaskGetResponseEntity>? expectValue =
            await expectTaskImplUseCase.get(query: expectTaskGetRequestEntity);

        verify(
          mockTaskImpRepository.get(
            query: argThat(isA<TaskGetRequestEntity>(), named: 'query'),
          ),
        ).called(1);

        expectValue?.forEach((TaskGetResponseEntity task) {
          expect(task.id, expectTaskGetResponseEntity.id);
          expect(task.title, expectTaskGetResponseEntity.title);
          expect(task.imageUrl, expectTaskGetResponseEntity.imageUrl);
          expect(task.isDone, expectTaskGetResponseEntity.isDone);
          expect(task.createdAt, expectTaskGetResponseEntity.createdAt);
        });
      });

      test('Should have create method - Failure case', () async {
        when(
          mockTaskImpRepository.get(
            query: argThat(isA<TaskGetRequestEntity>(), named: 'query'),
          ),
        ).thenThrow(expectRepositoryError);

        expect(
          () async => expectTaskImplUseCase.get(
            query: expectTaskGetRequestEntity,
          ),
          throwsA(isA<TaskGetUseCaseError>()),
        );

        expect(
          () async => expectTaskImplUseCase.get(
            query: expectTaskGetRequestEntity,
          ),
          throwsA(
            predicate(
              (Error e) =>
                  e is TaskGetUseCaseError &&
                  e.toString().contains(expectRepositoryError.toString()),
            ),
          ),
        );

        verify(
          mockTaskImpRepository.get(
            query: argThat(isA<TaskGetRequestEntity>(), named: 'query'),
          ),
        ).called(2);
      });
    });

    group('Update method', () {
      test('Should have update method - Success case', () async {
        when(
          mockTaskImpRepository.update(
            task: argThat(isA<TaskUpdateBodyRequestEntity>(), named: 'task'),
            queryParams: argThat(
              isA<TaskUpdateQueryParamsRequestEntity>(),
              named: 'queryParams',
            ),
          ),
        ).thenAnswer(
          (_) => Future<TaskUpdateResponseEntity>.value(
            expectTaskUpdateResponseEntity,
          ),
        );

        final TaskUpdateResponseEntity expectValue =
            await expectTaskImplUseCase.update(
          task: expectTaskUpdateRequestEntity,
          queryParams: expectTaskUpdateQueryParamsRequestEntity,
        );

        verify(
          expectTaskImplUseCase.update(
            task: expectTaskUpdateRequestEntity,
            queryParams: expectTaskUpdateQueryParamsRequestEntity,
          ),
        ).called(1);

        expect(expectValue, expectTaskUpdateResponseEntity);
      });

      test('''
Should have update method - Failure case (title empty string and image null and isDone empty string)''',
          () async {
        const TaskUpdateBodyRequestEntity emptyValue =
            TaskUpdateBodyRequestEntity(
          title: '',
          imageUrl: '',
        );

        when(
          mockTaskImpRepository.update(
            task: argThat(isA<TaskUpdateBodyRequestEntity>(), named: 'task'),
            queryParams: argThat(
              isA<TaskUpdateQueryParamsRequestEntity>(),
              named: 'queryParams',
            ),
          ),
        ).thenThrow(expectFieldValidationExceptionAtLeastOne);

        expect(
          () async => expectTaskImplUseCase.update(
            task: emptyValue,
            queryParams: expectTaskUpdateQueryParamsRequestEntity,
          ),
          throwsA(isA<TaskUpdateUseCaseError>()),
        );

        expect(
          () async => expectTaskImplUseCase.update(
            task: emptyValue,
            queryParams: expectTaskUpdateQueryParamsRequestEntity,
          ),
          throwsA(
            predicate(
              (Error e) =>
                  e is TaskUpdateUseCaseError &&
                  e.toString().contains(
                        expectFieldValidationExceptionAtLeastOne.toString(),
                      ),
            ),
          ),
        );

        verifyNever(
          mockTaskImpRepository.update(
            task: emptyValue,
            queryParams: expectTaskUpdateQueryParamsRequestEntity,
          ),
        );
      });

      test('''
Should have update method - Failure case (title imageUrl isDone is null)''',
          () async {
        const TaskUpdateBodyRequestEntity emptyValue =
            TaskUpdateBodyRequestEntity();

        when(
          mockTaskImpRepository.update(
            task: argThat(isA<TaskUpdateBodyRequestEntity>(), named: 'task'),
            queryParams: argThat(
              isA<TaskUpdateQueryParamsRequestEntity>(),
              named: 'queryParams',
            ),
          ),
        ).thenThrow(expectFieldValidationExceptionAtLeastOne);

        expect(
          () async => expectTaskImplUseCase.update(
            task: emptyValue,
            queryParams: expectTaskUpdateQueryParamsRequestEntity,
          ),
          throwsA(isA<TaskUpdateUseCaseError>()),
        );

        expect(
          () async => expectTaskImplUseCase.update(
            task: emptyValue,
            queryParams: expectTaskUpdateQueryParamsRequestEntity,
          ),
          throwsA(
            predicate(
              (Error e) =>
                  e is TaskUpdateUseCaseError &&
                  e.toString().contains(
                        expectFieldValidationExceptionAtLeastOne.toString(),
                      ),
            ),
          ),
        );

        verifyNever(
          mockTaskImpRepository.update(
            task: emptyValue,
            queryParams: expectTaskUpdateQueryParamsRequestEntity,
          ),
        );
      });

      test('Should have update method - Failure case (id empty)', () async {
        const TaskUpdateBodyRequestEntity requestValue =
            TaskUpdateBodyRequestEntity(
          title: 'expect_title',
          imageUrl: 'expect_img_url',
        );

        const TaskUpdateQueryParamsRequestEntity
            noValueIdInTaskUpdateQueryParamsRequestEntity =
            TaskUpdateQueryParamsRequestEntity(
          id: '',
        );

        when(
          mockTaskImpRepository.update(
            task: requestValue,
            queryParams: noValueIdInTaskUpdateQueryParamsRequestEntity,
          ),
        ).thenThrow(expectFieldRequiredExceptionId);

        expect(
          () async => expectTaskImplUseCase.update(
            task: requestValue,
            queryParams: noValueIdInTaskUpdateQueryParamsRequestEntity,
          ),
          throwsA(isA<TaskUpdateUseCaseError>()),
        );

        expect(
          () async => expectTaskImplUseCase.update(
            task: requestValue,
            queryParams: noValueIdInTaskUpdateQueryParamsRequestEntity,
          ),
          throwsA(
            predicate(
              (Error e) =>
                  e is TaskUpdateUseCaseError &&
                  e
                      .toString()
                      .contains(expectFieldRequiredExceptionId.toString()),
            ),
          ),
        );

        verifyNever(
          mockTaskImpRepository.update(
            task: requestValue,
            queryParams: noValueIdInTaskUpdateQueryParamsRequestEntity,
          ),
        );
      });
    });

    group('Delete method', () {
      test('Should have delete method - Failure case (id empty)', () async {
        const TaskDeleteQueryParamsRequestEntity
            emptyValueTaskDeleteQueryParamsRequestEntity =
            TaskDeleteQueryParamsRequestEntity(id: '');

        final TaskDeleteUseCaseError expectTaskUpdateRequestEntityErrorNoId =
            TaskDeleteUseCaseError(
          message: expectFieldRequiredExceptionId.toString(),
        );

        when(
          mockTaskImpRepository.delete(
            queryParams: emptyValueTaskDeleteQueryParamsRequestEntity,
          ),
        ).thenThrow(expectTaskUpdateRequestEntityErrorNoId);

        expect(
          () async => expectTaskImplUseCase.delete(
            queryParams: emptyValueTaskDeleteQueryParamsRequestEntity,
          ),
          throwsA(isA<TaskDeleteUseCaseError>()),
        );

        expect(
          () async => expectTaskImplUseCase.delete(
            queryParams: emptyValueTaskDeleteQueryParamsRequestEntity,
          ),
          throwsA(
            predicate(
              (Error e) =>
                  e is TaskDeleteUseCaseError &&
                  e.toString() ==
                      expectTaskUpdateRequestEntityErrorNoId.toString(),
            ),
          ),
        );

        verifyNever(
          mockTaskImpRepository.delete(
            queryParams: emptyValueTaskDeleteQueryParamsRequestEntity,
          ),
        );
      });

      test('Should have call task repository delete method - Success case',
          () async {
        when(
          mockTaskImpRepository.delete(
            queryParams: argThat(
              isA<TaskDeleteQueryParamsRequestEntity>(),
              named: 'queryParams',
            ),
          ),
        ).thenAnswer((_) => Future<void>.value());

        await expectTaskImplUseCase.delete(
          queryParams: expectTaskDeleteQueryParamsRequestEntity,
        );

        verify(
          mockTaskImpRepository.delete(
            queryParams: argThat(
              isA<TaskDeleteQueryParamsRequestEntity>(),
              named: 'queryParams',
            ),
          ),
        ).called(1);
      });
    });
  });

  group('TaskImplSseUseCase', () {
    final FakeTaskImplSseRepository expectFakeTaskImplSseRepository =
        FakeTaskImplSseRepository();
    final TaskImplSseUseCase expectTaskImplSseUseCase = TaskImplSseUseCase(
      repository: expectFakeTaskImplSseRepository,
    );

    group('TaskImplSseUseCase Class', () {
      test('Should have TaskImplSseUseCase Class', () {
        expect(TaskImplSseUseCase, TaskImplSseUseCase);
      });

      test('Should have mandatory properties', () async {
        expect(expectTaskImplSseUseCase.repository,
            expectFakeTaskImplSseRepository,);
      });
    });

    group('Get method', () {
      test('Should have get method - Success case', () {
        expect(expectTaskImplSseUseCase.get(), expectEventSource);
      });
    });
  });
}
