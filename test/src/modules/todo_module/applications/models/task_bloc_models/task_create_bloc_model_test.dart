import 'package:flutter_starter_kit/src/modules/todo_module/applications/models/task_bloc_models/task_create_bloc_model.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskCreateRequestBlocModel Class', () {
    test('Should have TaskCreateRequestBlocModel Class', () {
      expect(TaskCreateRequestBlocModel, TaskCreateRequestBlocModel);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskCreateRequestBlocModel.title,
        expectTaskCreateResponseEntity.title,
      );
      expect(
        expectTaskCreateRequestBlocModel.imageUrl,
        expectTaskCreateResponseEntity.imageUrl,
      );
    });
  });

  group('TaskCreateResponseBlocModel Class', () {
    test('Should have TaskCreateResponseBlocModel Class', () {
      expect(TaskCreateResponseBlocModel, TaskCreateResponseBlocModel);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskCreateResponseBlocModel.id,
        expectTaskCreateResponseEntity.id,
      );
      expect(
        expectTaskCreateResponseBlocModel.title,
        expectTaskCreateResponseEntity.title,
      );
      expect(
        expectTaskCreateResponseBlocModel.imageUrl,
        expectTaskCreateResponseEntity.imageUrl,
      );
      expect(
        expectTaskCreateResponseBlocModel.isDone,
        expectTaskCreateResponseEntity.isDone,
      );
      expect(
        expectTaskCreateResponseBlocModel.createdAt,
        expectTaskCreateResponseEntity.createdAt,
      );
    });
  });
}
