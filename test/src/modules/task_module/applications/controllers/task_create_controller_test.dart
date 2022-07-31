import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_create_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/models/task_status_view_model.dart';
import 'package:flutter_starter_kit/src/modules/task_module/domains/entities/task_create_entity.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../task_impl_usecase_test.mocks.dart';

class MockTaskCreateController extends TaskCreateController with Mock {
  MockTaskCreateController({required MockTaskImplUseCase usecase})
      : super(usecase: usecase);
}

void main() {
  final MockTaskImplUseCase expectMockTaskImplUseCase = MockTaskImplUseCase();
  final TaskCreateController expectTaskCreateController =
      TaskCreateController(usecase: expectMockTaskImplUseCase);

  group('TaskCreateController Class', () {
    test('Should have TaskCreateController Class', () {
      expect(TaskCreateController, TaskCreateController);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskCreateController.status, TaskStatusViewModel.initial);
      expect(expectTaskCreateController.error, null);
      expect(expectTaskCreateController.exception, null);
      expect(expectTaskCreateController.usecase, expectMockTaskImplUseCase);
    });

    test('Should have createTask method', () {
      when(
        expectTaskCreateController.usecase
            .create(task: expectTaskCreateRequestEntity),
      ).thenAnswer(
        (_) => Future<TaskCreateResponseEntity>.value(
          expectTaskCreateResponseEntity,
        ),
      );

      expect(
        () => expectTaskCreateController.createTask(
          task: expectTaskCreateRequestControllerModel,
        ),
        isA<void>(),
      );
    });
  });
}
