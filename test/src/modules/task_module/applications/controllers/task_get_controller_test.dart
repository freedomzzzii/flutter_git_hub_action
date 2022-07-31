import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_get_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/models/task_get_view_model.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/models/task_status_view_model.dart';
import 'package:flutter_starter_kit/src/modules/task_module/domains/entities/task_get_entity.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../task_impl_usecase_test.mocks.dart';

class MockTaskGetController extends TaskGetController with Mock {
  MockTaskGetController({required MockTaskImplUseCase usecase})
      : super(usecase: usecase);
}

void main() {
  final MockTaskImplUseCase expectMockTaskImplUseCase = MockTaskImplUseCase();
  final TaskGetController expectTaskGetController =
      TaskGetController(usecase: expectMockTaskImplUseCase);

  group('TaskGetController Class', () {
    test('Should have TaskGetController Class', () {
      expect(TaskGetController, TaskGetController);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskGetController.status, TaskStatusViewModel.initial);
      expect(expectTaskGetController.tasks, <TaskGetResponseControllerModel>[]);
      expect(
        expectTaskGetController.query,
        expectTaskGetRequestControllerModel,
      );
      expect(expectTaskGetController.error, null);
      expect(expectTaskGetController.usecase, expectMockTaskImplUseCase);
    });

    test('Should have getTasks method', () {
      when(
        expectTaskGetController.usecase.get(query: expectTaskGetRequestEntity),
      ).thenAnswer(
        (_) => Future<List<TaskGetResponseEntity>?>.value(
          <TaskGetResponseEntity>[expectTaskGetResponseEntity],
        ),
      );

      expect(
        () => expectTaskGetController.getTasks(
          requestBody: expectTaskGetRequestControllerModel,
        ),
        isA<void>(),
      );
    });
  });
}
