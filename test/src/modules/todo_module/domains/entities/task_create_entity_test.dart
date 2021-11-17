import 'package:flutter_test/flutter_test.dart';
import 'package:poc_clean_arch/src/modules/todo_module/domains/entities/task_create_entity.dart';

import '../../../../../test_data/mock_test_data.dart';

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
