import 'package:flutter_starter_kit/src/modules/task_module/applications/models/task_delete_view_model.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskDeleteQueryParamsRequestControllerModel Class', () {
    test('Should have TaskDeleteQueryParamsRequestControllerModel Class', () {
      expect(
        TaskDeleteQueryParamsRequestControllerModel,
        TaskDeleteQueryParamsRequestControllerModel,
      );
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskDeleteQueryParamsRequestControllerModel.id,
        expectTaskCreateResponseEntity.id,
      );
    });
  });
}
