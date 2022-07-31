import 'package:equatable/src/equatable_utils.dart';
import 'package:flutter_starter_kit/src/modules/task_module/domains/entities/task_get_entity.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

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

    test('should return correct hashCode', () {
      const TaskGetRequestEntity instance = expectTaskGetRequestEntity;
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
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

    test('should return correct hashCode', () {
      final TaskGetResponseEntity instance = expectTaskGetResponseEntity;
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
      );
    });
  });
}
