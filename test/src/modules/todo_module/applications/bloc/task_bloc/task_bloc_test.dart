import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/models/error_bloc_model.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/models/exception_bloc_model.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/models/task_bloc_models/task_create_bloc_model.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/models/task_bloc_models/task_delete_bloc_model.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/models/task_bloc_models/task_update_bloc_model.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/domains/entities/task_create_entity.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/domains/entities/task_delete_entity.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/domains/entities/task_get_entity.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/domains/entities/task_update_entity.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/task_impl_usecase.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../services/datasources/api_datasource_test.mocks.dart';
import '../../../task_impl_usecase_test.mocks.dart';

class FakeWebSocketChannel extends Fake implements WebSocketChannel {
  @override
  Stream<dynamic> get stream => FakeStreamView(MockWebSocketImpl());
}

class FakeStreamView extends Fake implements StreamView<dynamic> {
  FakeStreamView(MockWebSocketImpl stream) : _stream = stream;
  final MockWebSocketImpl _stream;
  @override
  StreamSubscription<dynamic> listen(
    void Function(dynamic value)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

class FakeTaskImplUsecase extends Fake implements TaskImplUseCase {
  @override
  Future<dynamic> disconnect({required WebSocketChannel channel}) async {
    return null;
  }
}

@GenerateMocks(<Type>[TaskBloc])
void main() {
  final MockTaskImplUseCase mockTaskImplUseCase = MockTaskImplUseCase();
  final FakeWebSocketChannel mockWebSocketChannel = FakeWebSocketChannel();
  late TaskBloc expectTaskBloc;

  setUp(() {
    dotenv.testLoad();
    expectTaskBloc = TaskBloc(usecase: mockTaskImplUseCase);
  });

  tearDown(() {
    expectTaskBloc.close();
  });

  group('TaskBloc Class', () {
    test('Should have TaskBloc Class', () {
      expect(TaskBloc, TaskBloc);
    });

    test('Should have default state is TaskInitialState', () {
      expect(expectTaskBloc.state, isA<TaskInitialState>());
    });
  });

  group('Should map TaskCreatedEvent to state', () {
    blocTest<TaskBloc, TaskState>(
      'Should map TaskCreatedEvent to state - Success case',
      build: () {
        when(
          mockTaskImplUseCase.create(
            task: argThat(isA<TaskCreateRequestEntity>(), named: 'task'),
          ),
        ).thenAnswer(
          (_) => Future<TaskCreateResponseEntity>.value(
            expectTaskCreateResponseEntity,
          ),
        );

        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async =>
          bloc.add(TaskCreatedEvent(model: expectTaskCreateRequestBlocModel)),
      expect: () {
        return <TaskState>[
          expectTaskCreateStateSuccess,
        ];
      },
    );

    blocTest<TaskBloc, TaskState>(
      'Should map TaskCreatedEvent to state - Failure case (title is empty)',
      build: () {
        when(
          mockTaskImplUseCase.create(
            task: argThat(isA<TaskCreateRequestEntity>(), named: 'task'),
          ),
        ).thenThrow(expectTaskFieldValidationExceptionTitleEmpty);

        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async => bloc.add(
        TaskCreatedEvent(
          model: TaskCreateRequestBlocModel(
            title: '',
            imageUrl: expectTaskCreateResponseBlocModel.imageUrl,
          ),
        ),
      ),
      expect: () {
        return <TaskState>[
          TaskCreateState(
            exception: ExceptionBlocModel(
              message: expectTaskFieldValidationExceptionTitleEmpty.message,
              code: expectTaskFieldValidationExceptionTitleEmpty.code,
            ),
            status: taskStatusState.failure,
          ),
        ];
      },
    );

    blocTest<TaskBloc, TaskState>(
      'Should map TaskCreatedEvent to state - Failure case (imageUrl is empty)',
      build: () {
        when(
          mockTaskImplUseCase.create(
            task: argThat(
              isA<TaskCreateRequestEntity>(),
              named: 'task',
            ),
          ),
        ).thenThrow(expectTaskFieldValidationExceptionImageUrlEmpty);

        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async => bloc.add(
        TaskCreatedEvent(
          model: TaskCreateRequestBlocModel(
            imageUrl: '',
            title: expectTaskCreateResponseEntity.title,
          ),
        ),
      ),
      expect: () {
        return <TaskState>[
          TaskCreateState(
            exception: ExceptionBlocModel(
              message: expectTaskFieldValidationExceptionImageUrlEmpty.message,
              code: expectTaskFieldValidationExceptionImageUrlEmpty.code,
            ),
            status: taskStatusState.failure,
          ),
        ];
      },
    );

    blocTest<TaskBloc, TaskState>(
      '''
Should map TaskCreatedEvent to state - Failure case (throw error from usecase)''',
      build: () {
        when(
          mockTaskImplUseCase.create(
            task: argThat(
              isA<TaskCreateRequestEntity>(),
              named: 'task',
            ),
          ),
        ).thenThrow(expectTaskCreateUseCaseError);

        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async => bloc.add(
        TaskCreatedEvent(
          model: TaskCreateRequestBlocModel(
            imageUrl: '',
            title: expectTaskCreateResponseEntity.title,
          ),
        ),
      ),
      expect: () {
        return <TaskState>[
          TaskCreateState(
            error: ErrorBlocModel(
              message: expectTaskCreateUseCaseError.message,
              code: expectTaskCreateUseCaseError.code,
            ),
            status: taskStatusState.failure,
          ),
        ];
      },
    );
  });

  group('Should map TaskGotEvent to state', () {
    blocTest<TaskBloc, TaskState>(
      'Should map TaskGotEvent to state - Success case',
      build: () {
        when(
          mockTaskImplUseCase.get(
            query: argThat(isA<TaskGetRequestEntity>(), named: 'query'),
          ),
        ).thenAnswer(
          (_) => Future<List<TaskGetResponseEntity>>.value(
            expectTaskGetResponseEntityList,
          ),
        );

        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async =>
          bloc.add(TaskGotEvent(model: expectTaskGetRequestBlocModel)),
      expect: () {
        return <TaskState>[
          expectTaskLoadingState,
          expectTaskGetStateSuccess,
        ];
      },
    );

    blocTest<TaskBloc, TaskState>(
      '''
Should map TaskGotEvent to state - Failure case (throw error from usecase)''',
      build: () {
        when(
          mockTaskImplUseCase.get(
            query: argThat(isA<TaskGetRequestEntity>(), named: 'query'),
          ),
        ).thenThrow(expectTaskGetUseCaseError);

        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async =>
          bloc.add(TaskGotEvent(model: expectTaskGetRequestBlocModel)),
      expect: () {
        return <TaskState>[
          expectTaskLoadingState,
          expectTaskGetStateError,
        ];
      },
    );
  });

  group('Should map TaskUpdatedEvent to state', () {
    blocTest<TaskBloc, TaskState>(
      'Should map TaskUpdatedEvent to state - Success case',
      build: () {
        final MockTaskImplUseCase mockTaskImplUseCase = MockTaskImplUseCase();
        final TaskBloc expectTaskBloc = TaskBloc(usecase: mockTaskImplUseCase);

        when(
          mockTaskImplUseCase.update(
            queryParams: argThat(
              isA<TaskUpdateQueryParamsRequestEntity>(),
              named: 'queryParams',
            ),
            task: argThat(isA<TaskUpdateBodyRequestEntity>(), named: 'task'),
          ),
        ).thenAnswer(
          (_) => Future<TaskUpdateResponseEntity>.value(
            expectTaskUpdateResponseEntity,
          ),
        );
        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async => bloc.add(
        TaskUpdatedEvent(
          queryParams: expectTaskUpdateQueryParamsRequestBlocModel,
          model: expectTaskUpdateBodyRequestBlocModel,
        ),
      ),
      expect: () {
        return <TaskState>[
          const TaskUpdateState(
            status: taskStatusState.success,
          ),
        ];
      },
    );

    blocTest<TaskBloc, TaskState>(
      '''
Should map TaskUpdatedEvent to state - Failure case (id is empty from usecase)''',
      build: () {
        final MockTaskImplUseCase mockTaskImplUseCase = MockTaskImplUseCase();
        final TaskBloc expectTaskBloc = TaskBloc(usecase: mockTaskImplUseCase);

        when(
          mockTaskImplUseCase.update(
            task: argThat(isA<TaskUpdateBodyRequestEntity>(), named: 'task'),
            queryParams: argThat(
              isA<TaskUpdateQueryParamsRequestEntity>(),
              named: 'queryParams',
            ),
          ),
        ).thenThrow(expectFieldRequiredExceptionId);

        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async => bloc.add(
        TaskUpdatedEvent(
          model: expectTaskUpdateBodyRequestBlocModel,
          queryParams: const TaskUpdateQueryParamsRequestBlocModel(
            id: '',
          ),
        ),
      ),
      expect: () {
        return <TaskState>[
          TaskUpdateState(
            exception: ExceptionBlocModel(
              message: expectFieldRequiredExceptionId.message,
              code: expectFieldRequiredExceptionId.code,
            ),
            status: taskStatusState.failure,
          ),
        ];
      },
    );

    blocTest<TaskBloc, TaskState>(
      '''
Should map TaskUpdatedEvent to state - Failure case (title isDone imageUrl is empty from usecase)''',
      build: () {
        final MockTaskImplUseCase mockTaskImplUseCase = MockTaskImplUseCase();
        final TaskBloc expectTaskBloc = TaskBloc(usecase: mockTaskImplUseCase);
        when(
          mockTaskImplUseCase.update(
            task: argThat(isA<TaskUpdateBodyRequestEntity>(), named: 'task'),
            queryParams: argThat(
              isA<TaskUpdateQueryParamsRequestEntity>(),
              named: 'queryParams',
            ),
          ),
        ).thenThrow(expectFieldValidationExceptionAtLeastOne);
        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async => bloc.add(
        TaskUpdatedEvent(
          model: const TaskUpdateBodyRequestBlocModel(
            imageUrl: '',
            title: '',
          ),
          queryParams: expectTaskUpdateQueryParamsRequestBlocModel,
        ),
      ),
      expect: () {
        return <TaskState>[
          TaskUpdateState(
            exception: ExceptionBlocModel(
              message: expectFieldValidationExceptionAtLeastOne.message,
              code: expectFieldValidationExceptionAtLeastOne.code,
            ),
            status: taskStatusState.failure,
          ),
        ];
      },
    );

    blocTest<TaskBloc, TaskState>(
      '''
Should map TaskUpdatedEvent to state - Failure case (throw error id is empty from datasource)''',
      build: () {
        final MockTaskImplUseCase mockTaskImplUseCase = MockTaskImplUseCase();
        final TaskBloc expectTaskBloc = TaskBloc(usecase: mockTaskImplUseCase);

        when(
          mockTaskImplUseCase.update(
            task: argThat(isA<TaskUpdateBodyRequestEntity>(), named: 'task'),
            queryParams: argThat(
              isA<TaskUpdateQueryParamsRequestEntity>(),
              named: 'queryParams',
            ),
          ),
        ).thenThrow(expectFieldRequiredExceptionId);

        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async => bloc.add(
        TaskUpdatedEvent(
          model: TaskUpdateBodyRequestBlocModel(
            title: expectTaskGetResponseEntity.title,
          ),
          queryParams: const TaskUpdateQueryParamsRequestBlocModel(
            id: '',
          ),
        ),
      ),
      expect: () {
        return <TaskState>[
          TaskUpdateState(
            exception: ExceptionBlocModel(
              message: expectFieldRequiredExceptionId.message,
              code: expectFieldRequiredExceptionId.code,
            ),
            status: taskStatusState.failure,
          ),
        ];
      },
    );

    blocTest<TaskBloc, TaskState>(
      'Should have TaskSelectedToUpdateEvent - Success case',
      build: () {
        final MockTaskImplUseCase mockTaskImplUseCase = MockTaskImplUseCase();
        final TaskBloc expectTaskBloc = TaskBloc(usecase: mockTaskImplUseCase);

        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async => bloc
          .add(TaskSelectedToUpdatedEvent(model: expectTaskUpdateBlocModel)),
      expect: () {
        return <TaskState>[
          TaskUpdateState(data: expectTaskUpdateBlocModel),
        ];
      },
    );
  });

  group('Should map TaskDeletedEvent to state', () {
    blocTest<TaskBloc, TaskState>(
      'Should map TaskDeletedEvent to state - Success case',
      build: () {
        final MockTaskImplUseCase mockTaskImplUseCase = MockTaskImplUseCase();
        final TaskBloc expectTaskBloc = TaskBloc(usecase: mockTaskImplUseCase);

        when(
          mockTaskImplUseCase.delete(
            queryParams: argThat(
              isA<TaskDeleteQueryParamsRequestEntity>(),
              named: 'queryParams',
            ),
          ),
        ).thenAnswer((_) => Future<void>.value());
        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async => bloc.add(
        TaskDeletedEvent(
          queryParams: expectTaskDeleteQueryParamsRequestBlocModel,
        ),
      ),
      expect: () {
        return <TaskState>[
          const TaskDeleteState(
            status: taskStatusState.success,
          ),
        ];
      },
    );

    blocTest<TaskBloc, TaskState>(
      '''
Should map TaskDeletedEvent to state - Failure case (id is empty from usecase)''',
      build: () {
        final MockTaskImplUseCase mockTaskImplUseCase = MockTaskImplUseCase();
        final TaskBloc expectTaskBloc = TaskBloc(usecase: mockTaskImplUseCase);

        when(
          mockTaskImplUseCase.delete(
            queryParams: argThat(
              isA<TaskDeleteQueryParamsRequestEntity>(),
              named: 'queryParams',
            ),
          ),
        ).thenThrow(expectFieldRequiredExceptionId);
        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async => bloc.add(
        const TaskDeletedEvent(
          queryParams: TaskDeleteQueryParamsRequestBlocModel(
            id: '',
          ),
        ),
      ),
      expect: () {
        return <TaskState>[
          TaskDeleteState(
            exception: ExceptionBlocModel(
              message: expectFieldRequiredExceptionId.message,
              code: expectFieldRequiredExceptionId.code,
            ),
            status: taskStatusState.failure,
          ),
        ];
      },
    );

    blocTest<TaskBloc, TaskState>(
      '''
Should map TaskDeletedEvent to state - Failure case (throw error id is empty from datasource)''',
      build: () {
        final MockTaskImplUseCase mockTaskImplUseCase = MockTaskImplUseCase();
        final TaskBloc expectTaskBloc = TaskBloc(usecase: mockTaskImplUseCase);

        when(
          mockTaskImplUseCase.delete(
            queryParams: argThat(
              isA<TaskDeleteQueryParamsRequestEntity>(),
              named: 'queryParams',
            ),
          ),
        ).thenThrow(expectFieldValidationExceptionAtLeastOne);

        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async => bloc.add(
        const TaskDeletedEvent(
          queryParams: TaskDeleteQueryParamsRequestBlocModel(
            id: '',
          ),
        ),
      ),
      expect: () {
        return <TaskState>[
          TaskDeleteState(
            exception: ExceptionBlocModel(
              message: expectFieldValidationExceptionAtLeastOne.message,
              code: expectFieldValidationExceptionAtLeastOne.code,
            ),
            status: taskStatusState.failure,
          ),
        ];
      },
    );
  });

  group('Should map TaskStreamSubscriptionEvent to state', () {
    blocTest<TaskBloc, TaskState>(
      '''
Should map TaskStreamSubscriptionEvent to state - Failure case (throw error from usecase)''',
      build: () {
        when(
          mockTaskImplUseCase.streamGet(
            url: argThat(isA<String>(), named: 'url'),
          ),
        ).thenThrow(expectTaskStreamGetUseCaseError);

        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async => bloc.add(TaskStreamSubscriptionEvent()),
      expect: () {
        return <TaskState>[
          TaskStreamSubscriptionState(
            error: ErrorBlocModel(
              message: expectTaskStreamGetUseCaseError.message,
              code: expectTaskStreamGetUseCaseError.code,
            ),
            status: taskStatusState.failure,
          ),
        ];
      },
    );
  });

  group('Should map TaskStreamGotEvent to state', () {
    blocTest<TaskBloc, TaskState>(
      'Should map TaskStreamGotEvent to state - Success case',
      build: () {
        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async => bloc
          .add(TaskStreamGotEvent(model: expectTaskGetResponseBlocModelList)),
      expect: () {
        return <TaskState>[
          TaskStreamGetState(
            data: expectTaskGetResponseBlocModelList,
            status: taskStatusState.success,
          )
        ];
      },
    );
  });

  group('Should map TaskRefreshStreamGetEvent to state', () {
    // TaskStreamSubscriptionState expectTaskStreamSubscriptionState =
    //     TaskStreamSubscriptionState(
    //   channel: mockWebSocketChannel,
    // );
    blocTest<TaskBloc, TaskState>(
      'Should map TaskRefreshStreamGetEvent to state - Success case',
      seed: () {
        return TaskStreamSubscriptionState(
          channel: mockWebSocketChannel,
        );
      },
      build: () {
        when(
          mockTaskImplUseCase.sendData(
            channel: mockWebSocketChannel,
            data: 'data',
          ),
        );
        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async => bloc.add(TaskRefreshStreamGetEvent()),
      expect: () {
        return <TaskState>[
          const TaskRefreshStreamGetState(
            status: taskStatusState.success,
          )
        ];
      },
    );

    blocTest<TaskBloc, TaskState>(
      '''Should map TaskRefreshStreamGetEvent to state - Failure case (throw error)''',
      build: () {
        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async => bloc.add(TaskRefreshStreamGetEvent()),
      expect: () {
        return <TaskState>[
          const TaskRefreshStreamGetState(
            status: taskStatusState.failure,
          ),
        ];
      },
    );
  });

  group('Should map TaskDisconnectStreamGetEvent to state', () {
    final FakeTaskImplUsecase usecase = FakeTaskImplUsecase();
    setUp(() {
      expectTaskBloc = TaskBloc(usecase: usecase);
    });
    blocTest<TaskBloc, TaskState>(
      'Should map TaskDisconnectStreamGetEvent to state - Success case',
      seed: () {
        return TaskStreamSubscriptionState(
          channel: mockWebSocketChannel,
        );
      },
      build: () {
        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async => bloc.add(TaskDisconnectStreamGetEvent()),
      expect: () {
        return <TaskState>[
          const TaskDisconnectStreamGetState(
            status: taskStatusState.success,
          )
        ];
      },
    );

    blocTest<TaskBloc, TaskState>(
      '''Should map TaskDisconnectStreamGetEvent to state - Failure case (throw error)''',
      build: () {
        return expectTaskBloc;
      },
      act: (TaskBloc bloc) async => bloc.add(TaskDisconnectStreamGetEvent()),
      expect: () {
        return <TaskState>[
          const TaskDisconnectStreamGetState(
            status: taskStatusState.failure,
          )
        ];
      },
    );
  });
}
