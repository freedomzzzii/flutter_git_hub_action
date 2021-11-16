import 'package:flutter_starter_kit/src/modules/todo_module/commons/errors/datasource_error.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

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
