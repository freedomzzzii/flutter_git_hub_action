import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_update_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/models/task_status_view_model.dart';
import 'package:flutter_starter_kit/src/modules/task_module/domains/entities/task_update_entity.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../task_impl_usecase_test.mocks.dart';

class MockTaskUpdateController extends TaskUpdateController with Mock {
  MockTaskUpdateController({required MockTaskImplUseCase usecase})
      : super(usecase: usecase);
}

void main() {
  final MockTaskImplUseCase expectMockTaskImplUseCase = MockTaskImplUseCase();
  final TaskUpdateController expectTaskUpdateController =
      TaskUpdateController(usecase: expectMockTaskImplUseCase);

  group('TaskUpdateController Class', () {
    test('Should have TaskUpdateController Class', () {
      expect(TaskUpdateController, TaskUpdateController);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskUpdateController.status, TaskStatusViewModel.initial);
      expect(expectTaskUpdateController.error, null);
      expect(expectTaskUpdateController.exception, null);
      expect(expectTaskUpdateController.usecase, expectMockTaskImplUseCase);
    });

    test('Should have updateTask method', () {
      when(
        expectMockTaskImplUseCase.update(
          task: expectTaskUpdateBodyRequestEntity,
          queryParams: expectTaskUpdateQueryParamsRequestEntity,
        ),
      ).thenAnswer(
        (_) => Future<TaskUpdateResponseEntity>.value(
          expectTaskUpdateResponseEntity,
        ),
      );

      expect(
        () => expectTaskUpdateController.updateTask(
          task: expectTaskUpdateBodyRequestControllerModel,
          queryParams: expectTaskUpdateQueryParamsRequestControllerModel,
        ),
        isA<void>(),
      );
    });
  });
}
