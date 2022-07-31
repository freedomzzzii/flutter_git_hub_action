import 'package:flutter_starter_kit/src/modules/task_module/applications/models/task_status_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskStatusViewModel enum', () {
    test('Should have mandatory values', () {
      const Set<String> expectTaskStateStatus = <String>{
        'initial',
        'loading',
        'success',
        'failure'
      };

      for (final TaskStatusViewModel value in TaskStatusViewModel.values) {
        expect(
          expectTaskStateStatus.contains(value.toString().split('.')[1]),
          true,
        );
      }

      expect(TaskStatusViewModel.values.length, expectTaskStateStatus.length);
    });
  });
}
