import 'package:flutter_starter_kit/src/modules/todo_module/applications/bloc/task_sse_bloc/task_sse_bloc.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskConnectedGetTaskEvent Class', () {
    test('Should have TaskConnectedGetTaskEvent Class', () {
      expect(TaskConnectedGetTaskEvent, TaskConnectedGetTaskEvent);
    });
  });

  group('TaskClosedConnectionEvent Class', () {
    test('Should have TaskClosedConnectionEvent Class', () {
      expect(TaskClosedConnectionEvent, TaskClosedConnectionEvent);
    });
  });

  group('TaskGotEvent Class', () {
    test('Should have TaskGotEvent Class', () {
      expect(TaskGotEvent, TaskGotEvent);
    });

    test('Should have mandatory properties', () {
      final TaskGotEvent expectTaskGotEvent = TaskGotEvent(
        response: expectSseResponse,
      );

      expect(expectTaskGotEvent.response, expectSseResponse);
    });
  });
}
