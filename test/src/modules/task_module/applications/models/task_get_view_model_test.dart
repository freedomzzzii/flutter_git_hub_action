import 'package:flutter_starter_kit/src/modules/task_module/applications/models/task_get_view_model.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskGetRequestControllerModel Class', () {
    test('Should have TaskGetRequestControllerModel Class', () {
      expect(
        TaskGetRequestControllerModel,
        TaskGetRequestControllerModel,
      );
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskGetRequestControllerModel.sortBy,
        expectTaskGetRequestEntity.sortBy,
      );
      expect(
        expectTaskGetRequestControllerModel.orderBy,
        expectTaskGetRequestEntity.orderBy,
      );
    });
  });

  group('TaskGetResponseControllerModel Class', () {
    test('Should have TaskGetResponseControllerModel Class', () {
      expect(
        TaskGetResponseControllerModel,
        TaskGetResponseControllerModel,
      );
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskGetResponseControllerModel.title,
        expectTaskCreateResponseEntity.title,
      );
      expect(
        expectTaskGetResponseControllerModel.imageUrl,
        expectTaskCreateResponseEntity.imageUrl,
      );
      expect(
        expectTaskGetResponseControllerModel.id,
        expectTaskCreateResponseEntity.id,
      );
      expect(
        expectTaskGetResponseControllerModel.isDone,
        expectTaskCreateResponseEntity.isDone,
      );
      expect(
        expectTaskGetResponseControllerModel.createdAt,
        expectTaskCreateResponseEntity.createdAt,
      );
    });
  });
}
