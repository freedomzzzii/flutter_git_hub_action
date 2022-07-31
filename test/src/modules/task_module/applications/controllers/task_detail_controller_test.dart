import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_detail_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/models/task_update_view_model.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockTaskDetailController extends TaskDetailController with Mock {
  MockTaskDetailController() : super();
}

void main() {
  final TaskDetailController expectTaskDetailController =
      TaskDetailController();

  group('TaskDetailController Class', () {
    test('Should have TaskDetailController Class', () {
      expect(TaskDetailController, TaskDetailController);
    });

    test('Should have mandatory properties', () {
      expectTaskDetailController.selectTaskToUpdate(
        task: expectTaskUpdateControllerModel,
      );

      expect(expectTaskDetailController.task, isA<TaskUpdateControllerModel>());
      expect(expectTaskDetailController.task, expectTaskUpdateControllerModel);
    });

    test('Should have selectTaskToUpdate method', () {
      expect(
        () => expectTaskDetailController.selectTaskToUpdate(
          task: expectTaskUpdateControllerModel,
        ),
        isA<void>(),
      );
    });
  });
}
