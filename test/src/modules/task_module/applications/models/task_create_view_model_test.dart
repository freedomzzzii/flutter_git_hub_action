import 'package:flutter_starter_kit/src/modules/task_module/applications/models/task_create_view_model.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskCreateRequestControllerModel Class', () {
    test('Should have TaskCreateRequestControllerModel Class', () {
      expect(
        TaskCreateRequestControllerModel,
        TaskCreateRequestControllerModel,
      );
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskCreateRequestControllerModel.title,
        expectTaskCreateResponseEntity.title,
      );
      expect(
        expectTaskCreateRequestControllerModel.imageUrl,
        expectTaskCreateResponseEntity.imageUrl,
      );
    });
  });

  group('TaskCreateResponseControllerModel Class', () {
    test('Should have TaskCreateResponseControllerModel Class', () {
      expect(
        TaskCreateResponseControllerModel,
        TaskCreateResponseControllerModel,
      );
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskCreateResponseControllerModel.title,
        expectTaskCreateResponseEntity.title,
      );
      expect(
        expectTaskCreateResponseControllerModel.imageUrl,
        expectTaskCreateResponseEntity.imageUrl,
      );
      expect(
        expectTaskCreateResponseControllerModel.id,
        expectTaskCreateResponseEntity.id,
      );
      expect(
        expectTaskCreateResponseControllerModel.isDone,
        expectTaskCreateResponseEntity.isDone,
      );
      expect(
        expectTaskCreateResponseControllerModel.createdAt,
        expectTaskCreateResponseEntity.createdAt,
      );
    });
  });
}
