import 'package:flutter_test/flutter_test.dart';
import 'package:poc_clean_arch/src/modules/todo_module/domains/entities/task_get_entity.dart';

import '../../../../../test_data/mock_test_data.dart';

void main() {
  group('TaskGetRequestEntity Class', () {
    test('Should have TaskGetRequestEntity Class', () {
      expect(TaskGetRequestEntity, TaskGetRequestEntity);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskGetRequestEntity.sortBy,
        expectTaskGetRequestDataSourceModel.sortBy,
      );
      expect(
        expectTaskGetRequestEntity.orderBy,
        expectTaskGetRequestDataSourceModel.orderBy,
      );
    });
  });

  group('TaskGetResponseEntity Class', () {
    test('Should have TaskGetResponseEntity Class', () {
      expect(TaskGetResponseEntity, TaskGetResponseEntity);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskGetResponseEntity.id, expectTaskGetResponseEntity.id);
      expect(
        expectTaskGetResponseEntity.title,
        expectTaskGetResponseEntity.title,
      );
      expect(
        expectTaskGetResponseEntity.imageUrl,
        expectTaskGetResponseEntity.imageUrl,
      );
      expect(
        expectTaskGetResponseEntity.isDone,
        expectTaskGetResponseEntity.isDone,
      );
      expect(
        expectTaskGetResponseEntity.createdAt,
        expectTaskGetResponseEntity.createdAt,
      );
    });
  });
}
