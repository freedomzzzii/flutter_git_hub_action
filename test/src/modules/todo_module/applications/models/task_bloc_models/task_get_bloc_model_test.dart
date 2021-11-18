import 'package:flutter_starter_kit/src/modules/todo_module/applications/models/task_bloc_models/task_get_bloc_model.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskGetRequestBlocModel Class', () {
    test('Should have TaskGetRequestBlocModel Class', () {
      expect(TaskGetRequestBlocModel, TaskGetRequestBlocModel);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskGetRequestBlocModel.sortBy,
        expectTaskGetRequestEntity.sortBy,
      );
      expect(
        expectTaskGetRequestBlocModel.orderBy,
        expectTaskGetRequestEntity.orderBy,
      );
    });
  });

  group('TaskGetResponseBlocModel Class', () {
    test('Should have TaskGetResponseBlocModel Class', () {
      expect(TaskGetResponseBlocModel, TaskGetResponseBlocModel);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskGetResponseBlocModel.id, expectTaskGetResponseEntity.id);
      expect(
        expectTaskGetResponseBlocModel.title,
        expectTaskGetResponseEntity.title,
      );
      expect(
        expectTaskGetResponseBlocModel.imageUrl,
        expectTaskGetResponseEntity.imageUrl,
      );
      expect(
        expectTaskGetResponseBlocModel.isDone,
        expectTaskGetResponseEntity.isDone,
      );
      expect(
        expectTaskGetResponseBlocModel.createdAt,
        expectTaskGetResponseEntity.createdAt,
      );
    });
  });
}