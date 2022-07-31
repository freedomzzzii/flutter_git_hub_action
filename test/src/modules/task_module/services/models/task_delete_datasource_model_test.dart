import 'package:flutter_starter_kit/src/modules/task_module/services/models/task_delete_datasource_model.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

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
