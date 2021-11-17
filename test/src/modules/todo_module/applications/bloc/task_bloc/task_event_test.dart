import 'package:flutter_test/flutter_test.dart';
import 'package:poc_clean_arch/src/modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';

import '../../../../../../test_data/mock_test_data.dart';

void main() {
  group('TaskCreatedEvent Class', () {
    test('Should have TaskCreatedEvent Class', () {
      expect(TaskCreatedEvent, TaskCreatedEvent);
    });

    test('Should have mandatory properties', () {
      final TaskCreatedEvent expectTaskCreatedEvent =
          TaskCreatedEvent(model: expectTaskCreateRequestBlocModel);

      expect(expectTaskCreatedEvent.task, expectTaskCreateRequestBlocModel);
    });
  });

  group('TaskGotEvent Class', () {
    test('Should have TaskGotEvent Class', () {
      expect(TaskGotEvent, TaskGotEvent);
    });

    test('Should have mandatory properties', () {
      final TaskGotEvent expectTaskGotEvent =
          TaskGotEvent(model: expectTaskGetRequestBlocModel);

      expect(expectTaskGotEvent.model, expectTaskGetRequestBlocModel);
    });
  });

  group('TaskUpdatedEvent Class', () {
    test('Should have TaskUpdatedEvent Class', () {
      expect(TaskUpdatedEvent, TaskUpdatedEvent);
    });

    test('Should have mandatory properties', () {
      final TaskUpdatedEvent expectTaskUpdatedEvent = TaskUpdatedEvent(
        model: expectTaskUpdateBodyRequestBlocModel,
        queryParams: expectTaskUpdateQueryParamsRequestBlocModel,
      );

      expect(
        expectTaskUpdatedEvent.model,
        expectTaskUpdateBodyRequestBlocModel,
      );
      expect(
        expectTaskUpdatedEvent.queryParams,
        expectTaskUpdateQueryParamsRequestBlocModel,
      );
    });
  });

  group('TaskSelectedToUpdateEvent Class', () {
    test('Should have TaskSelectedToUpdateEvent Class', () {
      expect(TaskSelectedToUpdatedEvent, TaskSelectedToUpdatedEvent);
    });

    test('Should have mandatory properties', () {
      final TaskSelectedToUpdatedEvent expectTaskSelectedToUpdateEvent =
          TaskSelectedToUpdatedEvent(model: expectTaskUpdateBlocModel);

      expect(expectTaskSelectedToUpdateEvent.model, expectTaskUpdateBlocModel);
    });
  });

  group('TaskDeletedEvent Class', () {
    test('Should have TaskDeletedEvent Class', () {
      expect(TaskDeletedEvent, TaskDeletedEvent);
    });

    test('Should have mandatory properties', () {
      final TaskDeletedEvent expectTaskDeletedEvent = TaskDeletedEvent(
        queryParams: expectTaskDeleteQueryParamsRequestBlocModel,
      );

      expect(
        expectTaskDeletedEvent.queryParams,
        expectTaskDeleteQueryParamsRequestBlocModel,
      );
    });
  });
}
