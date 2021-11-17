import 'package:flutter_starter_kit/src/modules/todo_module/applications/models/task_bloc_models/task_delete_bloc_model.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/models/task_bloc_models/task_update_bloc_model.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test TaskUpdateBodyRequestBlocModel', () {
    test('should have TaskUpdateBodyRequestBlocModel', () {
      expect(TaskUpdateBodyRequestBlocModel, TaskUpdateBodyRequestBlocModel);
    });

    test('should have mandatory properties', () {
      expect(
        expectTaskUpdateBodyRequestBlocModel.title,
        expectTaskGetResponseEntity.title,
      );
      expect(
        expectTaskUpdateBodyRequestBlocModel.isDone,
        expectTaskGetResponseEntity.isDone,
      );
      expect(
        expectTaskUpdateBodyRequestBlocModel.imageUrl,
        expectTaskGetResponseEntity.imageUrl,
      );
    });
  });

  group('Test TaskUpdateQueryParamsRequestBlocModel', () {
    test('should have TaskUpdateQueryParamsRequestBlocModel', () {
      expect(
        TaskUpdateQueryParamsRequestBlocModel,
        TaskUpdateQueryParamsRequestBlocModel,
      );
    });

    test('should have mandatory properties', () {
      expect(
        expectTaskUpdateQueryParamsRequestBlocModel.id,
        expectTaskGetResponseEntity.id,
      );
    });
  });

  group('Test TaskUpdateResponseBlocModel', () {
    test('should have TaskUpdateResponseBlocModel', () {
      expect(TaskUpdateResponseBlocModel, TaskUpdateResponseBlocModel);
    });

    test('should have mandatory properties', () {
      expect(
        expectTaskUpdateResponseBlocModel.id,
        expectTaskGetResponseEntity.id,
      );
      expect(
        expectTaskUpdateResponseBlocModel.title,
        expectTaskGetResponseEntity.title,
      );
      expect(
        expectTaskUpdateResponseBlocModel.isDone,
        expectTaskGetResponseEntity.isDone,
      );
      expect(
        expectTaskUpdateResponseBlocModel.imageUrl,
        expectTaskGetResponseEntity.imageUrl,
      );
      expect(
        expectTaskUpdateResponseBlocModel.createdAt,
        expectTaskGetResponseEntity.createdAt,
      );
    });
  });

  group('Test TaskUpdateBlocModel', () {
    test('should have TaskUpdateBlocModel', () {
      expect(TaskUpdateBlocModel, TaskUpdateBlocModel);
    });

    test('should have mandatory properties', () {
      expect(expectTaskUpdateBlocModel.id, expectTaskGetResponseEntity.id);
      expect(
        expectTaskUpdateBlocModel.title,
        expectTaskGetResponseEntity.title,
      );
      expect(
        expectTaskUpdateBlocModel.isDone,
        expectTaskGetResponseEntity.isDone,
      );
      expect(
        expectTaskUpdateBlocModel.imageUrl,
        expectTaskGetResponseEntity.imageUrl,
      );
    });
  });

  group('Test TaskUpdateQueryParamsRequestBlocModel', () {
    test('should have TaskUpdateQueryParamsRequestBlocModel', () {
      expect(
        TaskDeleteQueryParamsRequestBlocModel,
        TaskDeleteQueryParamsRequestBlocModel,
      );
    });

    test('should have mandatory properties', () {
      expect(
        expectTaskDeleteQueryParamsRequestBlocModel.id,
        expectTaskGetResponseEntity.id,
      );
    });
  });
}
