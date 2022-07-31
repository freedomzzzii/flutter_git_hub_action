import 'package:equatable/src/equatable_utils.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/models/exception_view_model.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExceptionViewModel Class', () {
    test('Should have ExceptionBlocModel Class', () {
      expect(ExceptionViewModel, ExceptionViewModel);
    });

    test('Should have mandatory properties', () {
      expect(expectExceptionViewModel.code, expectDataSourceError.code);
      expect(
        expectExceptionViewModel.message,
        expectDataSourceError.message,
      );
    });

    test('should return correct hashCode', () {
      final ExceptionViewModel instance = exceptExceptionViewModel;
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
      );
    });
  });
}
