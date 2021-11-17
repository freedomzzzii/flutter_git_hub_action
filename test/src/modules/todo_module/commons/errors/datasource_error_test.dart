import 'package:flutter_test/flutter_test.dart';
import 'package:poc_clean_arch/src/modules/todo_module/commons/errors/datasource_error.dart';

import '../../../../../test_data/mock_test_data.dart';

void main() {
  group('DataSourceError Class', () {
    test('Should have DataSourceError Class', () {
      expect(DataSourceError, DataSourceError);
    });

    test('Should have mandatory properties', () {
      expect(expectDataSourceError.code, expectRepositoryError.code);
      expect(expectDataSourceError.message, expectRepositoryError.message);
    });
  });
}
