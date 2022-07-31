import 'package:equatable/src/equatable_utils.dart';
import 'package:flutter_starter_kit/src/modules/task_module/domains/entities/task_delete_entity.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskDeleteRequestEntity class', () {
    test('Should have TaskDeleteRequestEntity Class', () {
      expect(
        TaskDeleteQueryParamsRequestEntity,
        TaskDeleteQueryParamsRequestEntity,
      );
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskDeleteQueryParamsRequestEntity.id,
        expectTaskGetResponseEntity.id,
      );
    });

    test('should return correct hashCode', () {
      final TaskDeleteQueryParamsRequestEntity instance =
          expectTaskDeleteQueryParamsRequestEntity;
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
      );
    });
  });
}
