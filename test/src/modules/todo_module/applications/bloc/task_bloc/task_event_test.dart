import 'package:flutter_starter_kit/src/modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

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

  group('TaskStreamSubscriptionEvent Class', () {
    test('Should have TaskStreamSubscriptionEvent Class', () {
      expect(TaskStreamSubscriptionEvent, TaskStreamSubscriptionEvent);
    });
  });

  group('TaskStreamGotEvent Class', () {
    test('Should have TaskStreamGotEvent Class', () {
      expect(TaskStreamGotEvent, TaskStreamGotEvent);
    });

    test('Should have mandatory properties', () {
      final TaskStreamGotEvent expectTaskStreamGotEvent =
          TaskStreamGotEvent(model: expectTaskGetResponseBlocModelList);

      expect(
        expectTaskStreamGotEvent.model,
        expectTaskGetResponseBlocModelList,
      );
    });
  });

  group('TaskRefreshStreamGetEvent Class', () {
    test('Should have TaskRefreshStreamGetEvent Class', () {
      expect(TaskRefreshStreamGetEvent, TaskRefreshStreamGetEvent);
    });
  });

  group('TaskDisconnectStreamGetEvent Class', () {
    test('Should have TaskDisconnectStreamGetEvent Class', () {
      expect(TaskDisconnectStreamGetEvent, TaskDisconnectStreamGetEvent);
    });
  });
}
