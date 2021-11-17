import 'package:flutter_starter_kit/src/modules/todo_module/commons/errors/repository_error.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RepositoryError Class', () {
    test('Should have RepositoryError Class', () {
      expect(RepositoryError, RepositoryError);
    });

    test('Should have mandatory properties', () {
      expect(expectRepositoryError.code, expectDataSourceError.code);
      expect(expectRepositoryError.message, expectDataSourceError.message);
    });
  });
}
