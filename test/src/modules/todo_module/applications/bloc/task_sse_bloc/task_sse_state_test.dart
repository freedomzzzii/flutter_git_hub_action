import 'package:flutter_starter_kit/src/modules/todo_module/applications/bloc/task_sse_bloc/task_sse_bloc.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('taskSseStatusState enum', () {
    test('Should have mandatory values', () {
      const Set<String> expectTaskSseStatusState = <String>{
        'initial',
        'loading',
        'success',
        'failure'
      };

      for (final taskSseStatusState value in taskSseStatusState.values) {
        expect(
          expectTaskSseStatusState.contains(value.toString().split('.')[1]),
          true,
        );
      }

      expect(taskSseStatusState.values.length, expectTaskSseStatusState.length);
    });
  });

  group('TaskSseState Class', () {
    final TaskSseState eventTaskSseState =
        TaskSseState(eventSource: expectEventSource);
    test('Should have TaskSseState Class', () {
      expect(TaskSseState, TaskSseState);
    });

    test('Should have mandatory properties', () {
      expect(eventTaskSseState.eventSource, expectEventSource);
    });
  });

  group('TaskSseInitialState Class', () {
    test('Should have TaskSseInitialState Class', () {
      expect(TaskSseInitialState, TaskSseInitialState);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskSseInitialState.status, taskSseStatusState.initial);
    });
  });

  group('TaskSseConnectGetTaskState Class', () {
    test('Should have TaskSseConnectGetTaskState Class', () {
      expect(TaskSseConnectGetTaskState, TaskSseConnectGetTaskState);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskSseConnectGetTaskState.eventSource, expectEventSource);
      expect(
        expectTaskSseConnectGetTaskState.status,
        taskSseStatusState.success,
      );
      expect(expectTaskSseConnectGetTaskState.error, exceptErrorBlocModel);
      expect(
        expectTaskSseConnectGetTaskState.exception,
        exceptExceptionBlocModel,
      );
    });
  });

  group('TaskSseGetTaskState Class', () {
    test('Should have TaskSseGetTaskState Class', () {
      expect(TaskSseGetTaskState, TaskSseGetTaskState);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskSseGetTaskStateError.status, taskSseStatusState.failure);
      expect(
        expectTaskSseGetTaskStateError.data,
        expectTaskGetResponseBlocModelList,
      );
      expect(expectTaskSseGetTaskStateError.error, exceptErrorBlocModel);
      expect(
        expectTaskSseGetTaskStateError.exception,
        exceptExceptionBlocModel,
      );
    });
  });

  group('TaskSseCloseConnectState Class', () {
    test('Should have TaskSseCloseConnectState Class', () {
      expect(TaskSseCloseConnectState, TaskSseCloseConnectState);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskSseCloseConnectStateError.status,
        taskSseStatusState.failure,
      );
      expect(expectTaskSseCloseConnectStateError.error, exceptErrorBlocModel);
      expect(
        expectTaskSseCloseConnectStateError.exception,
        exceptExceptionBlocModel,
      );
    });
  });
}
