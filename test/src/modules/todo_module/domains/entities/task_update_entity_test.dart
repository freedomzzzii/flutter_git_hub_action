import 'package:flutter_starter_kit/src/modules/todo_module/domains/entities/task_update_entity.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskUpdateBodyRequestEntity class', () {
    test('Should have TaskUpdateRequestEntity Class', () {
      expect(TaskUpdateBodyRequestEntity, TaskUpdateBodyRequestEntity);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskUpdateRequestEntity.title,
        expectTaskGetResponseEntity.title,
      );
      expect(
        expectTaskUpdateRequestEntity.isDone,
        expectTaskGetResponseEntity.isDone,
      );
      expect(
        expectTaskUpdateRequestEntity.imageUrl,
        expectTaskGetResponseEntity.imageUrl,
      );
    });
  });

  group('TaskUpdateQueryParamsRequestEntity class', () {
    test('Should have TaskUpdateQueryParamsRequestEntity Class', () {
      expect(
        TaskUpdateQueryParamsRequestEntity,
        TaskUpdateQueryParamsRequestEntity,
      );
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskUpdateQueryParamsRequestEntity.id,
        expectTaskGetResponseEntity.id,
      );
    });
  });

  group('TaskUpdateResponseEntity class', () {
    test('Should have TaskUpdateResponseEntity Class', () {
      expect(TaskUpdateResponseEntity, TaskUpdateResponseEntity);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskUpdateResponseEntity.id, expectTaskGetResponseEntity.id);
      expect(
        expectTaskUpdateResponseEntity.title,
        expectTaskGetResponseEntity.title,
      );
      expect(
        expectTaskUpdateResponseEntity.isDone,
        expectTaskGetResponseEntity.isDone,
      );
      expect(
        expectTaskUpdateResponseEntity.imageUrl,
        expectTaskGetResponseEntity.imageUrl,
      );
      expect(
        expectTaskUpdateResponseEntity.createdAt,
        expectTaskGetResponseEntity.createdAt,
      );
    });
  });
}
