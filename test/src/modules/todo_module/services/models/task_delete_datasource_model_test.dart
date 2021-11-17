import 'package:flutter_test/flutter_test.dart';
import 'package:poc_clean_arch/src/modules/todo_module/services/models/task_delete_datasource_model.dart';

import '../../../../../test_data/mock_test_data.dart';

void main() {
  group('Test TaskDeleteQueryParamsRequestDataSourceModel', () {
    test('Should have TaskDeleteQueryParamsRequestDataSourceModel', () {
      expect(
        TaskDeleteQueryParamsRequestDataSourceModel,
        TaskDeleteQueryParamsRequestDataSourceModel,
      );
    });

    test('Should have mandatory properties', () {
      final TaskDeleteQueryParamsRequestDataSourceModel
          expectTaskDeleteQueryParamsRequestDataSourceModel =
          TaskDeleteQueryParamsRequestDataSourceModel(
        id: expectTaskGetResponseEntity.id,
      );
      expect(
        expectTaskDeleteQueryParamsRequestDataSourceModel.id,
        expectTaskGetResponseEntity.id,
      );
    });
  });
}
