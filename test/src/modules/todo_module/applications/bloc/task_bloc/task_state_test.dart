import 'package:flutter_starter_kit/src/modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('taskStateStatus enum', () {
    test('Should have mandatory values', () {
      const Set<String> expectTaskStateStatus = <String>{
        'initial',
        'loading',
        'success',
        'failure'
      };

      for (final taskStatusState value in taskStatusState.values) {
        expect(
          expectTaskStateStatus.contains(value.toString().split('.')[1]),
          true,
        );
      }

      expect(taskStatusState.values.length, expectTaskStateStatus.length);
    });
  });

  group('TaskInitialState Class', () {
    test('Should have TaskInitialState Class', () {
      expect(TaskInitialState, TaskInitialState);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskInitialState.status, isA<taskStatusState>());
      expect(expectTaskInitialState.status, taskStatusState.initial);
    });
  });

  group('TaskLoadingState Class', () {
    test('Should have TaskLoadingState Class', () {
      expect(TaskLoadingState, TaskLoadingState);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskLoadingState.status, isA<taskStatusState>());
      expect(expectTaskLoadingState.status, taskStatusState.loading);
    });
  });

  group('TaskCreateState Class', () {
    test('Should have TaskCreateState Class', () {
      expect(TaskCreateState, TaskCreateState);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskCreateState.status, taskStatusState.failure);
      expect(expectTaskCreateState.error, exceptErrorBlocModel);
      expect(expectTaskCreateState.exception, exceptExceptionBlocModel);
    });
  });

  group('TaskGetState Class', () {
    test('Should have TaskGetState Class', () {
      expect(TaskGetState, TaskGetState);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskGetState.status, taskStatusState.failure);
      expect(expectTaskGetState.query, expectTaskGetRequestBlocModel);
      expect(expectTaskGetState.data, expectTaskGetResponseBlocModelList);
      expect(expectTaskGetState.error, exceptErrorBlocModel);
      expect(expectTaskGetState.exception, exceptExceptionBlocModel);
    });
  });

  group('TaskUpdateState Class', () {
    test('Should have TaskState Class', () {
      expect(TaskUpdateState, TaskUpdateState);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskUpdateState.status, expectTaskGetState.status);
      expect(expectTaskUpdateState.error, exceptErrorBlocModel);
      expect(expectTaskUpdateState.exception, exceptExceptionBlocModel);
    });
  });

  group('TaskDeleteState Class', () {
    test('Should have TaskDeleteState Class', () {
      expect(TaskDeleteState, TaskDeleteState);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskDeleteState.status, expectTaskGetState.status);
      expect(expectTaskDeleteState.error, exceptErrorBlocModel);
      expect(expectTaskDeleteState.exception, exceptExceptionBlocModel);
    });
  });

  group('TaskStreamSubscriptionState Class', () {
    test('Should have TaskStreamSubscriptionState Class', () {
      expect(TaskStreamSubscriptionState, TaskStreamSubscriptionState);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskStreamSubscriptionState.status,
        taskStatusState.failure,
      );
      expect(expectTaskStreamSubscriptionState.error, exceptErrorBlocModel);
      expect(
        expectTaskStreamSubscriptionState.exception,
        exceptExceptionBlocModel,
      );
    });
  });

  group('TaskStreamGetState Class', () {
    test('Should have TaskStreamGetState Class', () {
      expect(TaskStreamGetState, TaskStreamGetState);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskStreamGetState.status, taskStatusState.failure);
      expect(expectTaskStreamGetState.data, expectTaskGetResponseBlocModelList);
      expect(expectTaskStreamGetState.error, exceptErrorBlocModel);
      expect(expectTaskStreamGetState.exception, exceptExceptionBlocModel);
    });
  });

  group('TaskRefreshStreamGetState Class', () {
    test('Should have TaskRefreshStreamGetState Class', () {
      expect(TaskRefreshStreamGetState, TaskRefreshStreamGetState);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskRefreshStreamGetState.status, taskStatusState.failure);
      expect(expectTaskRefreshStreamGetState.error, exceptErrorBlocModel);
      expect(
        expectTaskRefreshStreamGetState.exception,
        exceptExceptionBlocModel,
      );
    });
  });

  group('TaskDisconnectStreamGetState Class', () {
    test('Should have TaskDisconnectStreamGetState Class', () {
      expect(TaskDisconnectStreamGetState, TaskDisconnectStreamGetState);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskDisconnectStreamGetState.status,
        taskStatusState.failure,
      );
      expect(expectTaskDisconnectStreamGetState.error, exceptErrorBlocModel);
      expect(
        expectTaskDisconnectStreamGetState.exception,
        exceptExceptionBlocModel,
      );
    });
  });
}
