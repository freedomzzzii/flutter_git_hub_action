import 'package:flutter_test/flutter_test.dart';
import 'package:poc_clean_arch/src/modules/todo_module/commons/errors/repository_error.dart';

import '../../../../../test_data/mock_test_data.dart';

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
