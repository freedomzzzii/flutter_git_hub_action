import 'package:flutter_starter_kit/src/modules/task_module/applications/models/task_update_view_model.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskUpdateBodyRequestControllerModel Class', () {
    test('Should have TaskUpdateBodyRequestControllerModel Class', () {
      expect(
        TaskUpdateBodyRequestControllerModel,
        TaskUpdateBodyRequestControllerModel,
      );
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskUpdateBodyRequestControllerModel.title,
        expectTaskCreateResponseEntity.title,
      );
      expect(
        expectTaskUpdateBodyRequestControllerModel.imageUrl,
        expectTaskCreateResponseEntity.imageUrl,
      );
      expect(
        expectTaskUpdateBodyRequestControllerModel.isDone,
        expectTaskCreateResponseEntity.isDone,
      );
    });
  });

  group('TaskUpdateQueryParamsRequestControllerModel Class', () {
    test('Should have TaskUpdateQueryParamsRequestControllerModel Class', () {
      expect(
        TaskUpdateQueryParamsRequestControllerModel,
        TaskUpdateQueryParamsRequestControllerModel,
      );
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskUpdateQueryParamsRequestControllerModel.id,
        expectTaskCreateResponseEntity.id,
      );
    });
  });

  group('TaskUpdateResponseControllerModel Class', () {
    test('Should have TaskUpdateResponseControllerModel Class', () {
      expect(
        TaskUpdateResponseControllerModel,
        TaskUpdateResponseControllerModel,
      );
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskUpdateResponseControllerModel.title,
        expectTaskCreateResponseEntity.title,
      );
      expect(
        expectTaskUpdateResponseControllerModel.imageUrl,
        expectTaskCreateResponseEntity.imageUrl,
      );
      expect(
        expectTaskUpdateResponseControllerModel.id,
        expectTaskCreateResponseEntity.id,
      );
      expect(
        expectTaskUpdateResponseControllerModel.isDone,
        expectTaskCreateResponseEntity.isDone,
      );
      expect(
        expectTaskUpdateResponseControllerModel.createdAt,
        expectTaskCreateResponseEntity.createdAt,
      );
    });
  });

  group('TaskUpdateControllerModel Class', () {
    test('Should have TaskUpdateControllerModel Class', () {
      expect(
        TaskUpdateControllerModel,
        TaskUpdateControllerModel,
      );
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskUpdateControllerModel.title,
        expectTaskCreateResponseEntity.title,
      );
      expect(
        expectTaskUpdateControllerModel.imageUrl,
        expectTaskCreateResponseEntity.imageUrl,
      );
      expect(
        expectTaskUpdateControllerModel.id,
        expectTaskCreateResponseEntity.id,
      );
      expect(
        expectTaskUpdateControllerModel.isDone,
        expectTaskCreateResponseEntity.isDone,
      );
    });
  });
}
