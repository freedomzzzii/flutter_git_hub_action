import 'package:flutter_starter_kit/src/modules/todo_module/applications/models/exception_bloc_model.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

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
