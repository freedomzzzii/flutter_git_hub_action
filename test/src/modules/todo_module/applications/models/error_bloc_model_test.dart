import 'package:equatable/src/equatable_utils.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/models/error_bloc_model.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorBlocModel Class', () {
    test('Should have ErrorBlocModel Class', () {
      expect(ErrorBlocModel, ErrorBlocModel);
    });

    test('Should have mandatory properties', () {
      expect(exceptErrorBlocModel.code, expectDataSourceError.code);
      expect(exceptErrorBlocModel.message, expectDataSourceError.message);
    });

    test('should return correct hashCode', () {
      final ErrorBlocModel instance = exceptErrorBlocModel;
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
      );
    });
  });
}
