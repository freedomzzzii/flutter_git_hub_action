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
}
