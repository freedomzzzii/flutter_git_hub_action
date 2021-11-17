import 'package:flutter_test/flutter_test.dart';
import 'package:poc_clean_arch/src/modules/todo_module/applications/models/exception_bloc_model.dart';

import '../../../../../test_data/mock_test_data.dart';

void main() {
  group('ExceptionBlocModel Class', () {
    test('Should have ExceptionBlocModel Class', () {
      expect(ExceptionBlocModel, ExceptionBlocModel);
    });

    test('Should have mandatory properties', () {
      expect(exceptExceptionBlocModel.code, expectDataSourceError.code);
      expect(exceptExceptionBlocModel.message, expectDataSourceError.message);
    });
  });
}
