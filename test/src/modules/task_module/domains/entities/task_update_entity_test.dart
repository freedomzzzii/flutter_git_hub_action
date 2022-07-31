import 'package:equatable/src/equatable_utils.dart';
import 'package:flutter_starter_kit/src/modules/task_module/domains/entities/task_update_entity.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskUpdateBodyRequestEntity class', () {
    test('Should have TaskUpdateRequestEntity Class', () {
      expect(TaskUpdateBodyRequestEntity, TaskUpdateBodyRequestEntity);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskUpdateBodyRequestEntity.title,
        expectTaskGetResponseEntity.title,
      );
      expect(
        expectTaskUpdateBodyRequestEntity.isDone,
        expectTaskGetResponseEntity.isDone,
      );
      expect(
        expectTaskUpdateBodyRequestEntity.imageUrl,
        expectTaskGetResponseEntity.imageUrl,
      );
    });

    test('should return correct hashCode', () {
      final TaskUpdateBodyRequestEntity instance =
          expectTaskUpdateBodyRequestEntity;
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
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

    test('should return correct hashCode', () {
      final TaskUpdateQueryParamsRequestEntity instance =
          expectTaskUpdateQueryParamsRequestEntity;
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
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

    test('should return correct hashCode', () {
      final TaskUpdateResponseEntity instance = expectTaskUpdateResponseEntity;
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
      );
    });
  });

  group('TaskUpdateEntity class', () {
    test('Should have TaskUpdateEntity Class', () {
      expect(TaskUpdateEntity, TaskUpdateEntity);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskUpdateEntity.id, expectTaskGetResponseEntity.id);
      expect(
        expectTaskUpdateEntity.title,
        expectTaskGetResponseEntity.title,
      );
      expect(
        expectTaskUpdateEntity.isDone,
        expectTaskGetResponseEntity.isDone,
      );
      expect(
        expectTaskUpdateEntity.imageUrl,
        expectTaskGetResponseEntity.imageUrl,
      );
    });

    test('should return correct hashCode', () {
      final TaskUpdateEntity instance = expectTaskUpdateEntity;
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
      );
    });
  });
}
