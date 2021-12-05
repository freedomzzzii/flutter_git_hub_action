import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/bloc/task_sse_bloc/task_sse_bloc.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../../../task_impl_usecase_test.dart';

@GenerateMocks(<Type>[TaskSseBloc])
void main() {
  final FakeTaskImplSseUseCase expectFakeTaskImplSseUseCase =
      FakeTaskImplSseUseCase();
  late TaskSseBloc expectTaskSseBloc;

  setUp(() {
    expectTaskSseBloc = TaskSseBloc(usecase: expectFakeTaskImplSseUseCase);
  });

  group('TaskSseBloc Class', () {
    test('Should have TaskSseBloc Class', () {
      expect(TaskSseBloc, TaskSseBloc);
    });

    test('Should have default state is TaskInitialState', () {
      expect(expectTaskSseBloc.state, isA<TaskSseInitialState>());
    });
  });

  group('Should map TaskConnectedGetTaskEvent to state', () {
    blocTest<TaskSseBloc, TaskSseState>(
      'Should map TaskConnectedGetTaskEvent to state',
      build: () {
        return expectTaskSseBloc;
      },
      act: (TaskSseBloc bloc) async => bloc.add(TaskConnectedGetTaskEvent()),
      expect: () {
        return <TaskSseState>[
          const TaskSseConnectGetTaskState(status: taskSseStatusState.success),
        ];
      },
    );
  });

  group('Should map TaskClosedConnectionEvent to state', () {
    blocTest<TaskSseBloc, TaskSseState>(
      'Should map TaskClosedConnectionEvent to state',
      build: () {
        return expectTaskSseBloc;
      },
      act: (TaskSseBloc bloc) async => bloc.add(TaskClosedConnectionEvent()),
      expect: () {
        return <TaskSseState>[
          expectTaskSseCloseConnectState,
        ];
      },
    );
  });

  group('Should map TaskGotEvent to state', () {
    blocTest<TaskSseBloc, TaskSseState>(
      'Should map TaskGotEvent to state - Success case',
      build: () {
        return expectTaskSseBloc;
      },
      act: (TaskSseBloc bloc) async =>
          bloc.add(TaskGotEvent(response: expectSseResponse)),
      expect: () {
        return <TaskSseState>[
          expectTaskSseGetTaskState,
        ];
      },
    );

    blocTest<TaskSseBloc, TaskSseState>(
      'Should map TaskGotEvent to state - Failure case (title is empty)',
      build: () {
        return expectTaskSseBloc;
      },
      act: (TaskSseBloc bloc) async => bloc.add(
        const TaskGotEvent(response: ''),
      ),
      expect: () {
        return <TaskSseState>[
          const TaskSseGetTaskState(status: taskSseStatusState.failure)
        ];
      },
    );
  });
}
