import 'package:flutter_starter_kit/src/modules/task_module/domains/datasources/datasource.dart';
import 'package:flutter_starter_kit/src/modules/task_module/services/datasources/api_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../services/datasources/api_datasource_test.mocks.dart';

void main() {
  group('DataSource Class', () {
    test('Should have DataSource Class', () {
      expect(DataSource, DataSource);
    });

    test('Should have mandatory properties', () {
      final MockDio mockDio = MockDio();
      final DataSource expectDataSource = DataSource(dio: mockDio);

      expect(expectDataSource.runtimeType, ApiDataSource);
    });
  });
}
