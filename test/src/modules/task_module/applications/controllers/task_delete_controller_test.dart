import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_delete_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/models/task_status_view_model.dart';
import 'package:flutter_starter_kit/src/modules/task_module/domains/entities/task_create_entity.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../task_impl_usecase_test.mocks.dart';

class MockTaskDeleteController extends TaskDeleteController with Mock {
  MockTaskDeleteController({required MockTaskImplUseCase usecase})
      : super(usecase: usecase);
}

void main() {
  final MockTaskImplUseCase expectMockTaskImplUseCase = MockTaskImplUseCase();
  final TaskDeleteController expectTaskDeleteController =
      TaskDeleteController(usecase: expectMockTaskImplUseCase);

  group('TaskDeleteController Class', () {
    test('Should have TaskDeleteController Class', () {
      expect(TaskDeleteController, TaskDeleteController);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskDeleteController.status, TaskStatusViewModel.initial);
      expect(expectTaskDeleteController.error, null);
      expect(expectTaskDeleteController.exception, null);
      expect(expectTaskDeleteController.usecase, expectMockTaskImplUseCase);
    });

    test('Should have createTask method', () {
      when(
        expectTaskDeleteController.usecase
            .delete(queryParams: expectTaskDeleteQueryParamsRequestEntity),
      ).thenAnswer(
        (_) => Future<TaskCreateResponseEntity>.value(
          expectTaskCreateResponseEntity,
        ),
      );

      expect(
        () => expectTaskDeleteController.deleteTask(
          queryParams: expectTaskDeleteQueryParamsRequestControllerModel,
        ),
        isA<void>(),
      );
    });
  });
}
