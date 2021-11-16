import 'package:flutter_starter_kit/src/modules/todo_module/domains/entities/task_create_entity.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskCreateRequestEntity Class', () {
    test('Should have TaskCreateRequestEntity Class', () {
      expect(TaskCreateRequestEntity, TaskCreateRequestEntity);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskCreateRequestEntity.title,
        expectTaskCreateResponseEntity.title,
      );
      expect(
        expectTaskCreateRequestEntity.imageUrl,
        expectTaskCreateResponseEntity.imageUrl,
      );
    });
  });

  group('TaskCreateResponseEntity Class', () {
    test('Should have TaskCreateResponseEntity Class', () {
      expect(TaskCreateResponseEntity, TaskCreateResponseEntity);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskCreateResponseEntity.id,
        expectTaskCreateResponseBlocModel.id,
      );
      expect(
        expectTaskCreateResponseEntity.title,
        expectTaskCreateResponseEntity.title,
      );
      expect(
        expectTaskCreateResponseEntity.imageUrl,
        expectTaskCreateResponseEntity.imageUrl,
      );
      expect(
        expectTaskCreateResponseEntity.isDone,
        expectTaskCreateResponseEntity.isDone,
      );
      expect(
        expectTaskCreateResponseEntity.createdAt,
        expectTaskCreateResponseEntity.createdAt,
      );
    });
  });
}
