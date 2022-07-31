import 'package:equatable/src/equatable_utils.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/models/error_view_model.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorViewModel Class', () {
    test('Should have ErrorBlocModel Class', () {
      expect(ErrorViewModel, ErrorViewModel);
    });

    test('Should have mandatory properties', () {
      expect(expectErrorViewModel.code, expectDataSourceError.code);
      expect(exceptErrorViewModel.message, expectDataSourceError.message);
    });

    test('should return correct hashCode', () {
      final ErrorViewModel instance = exceptErrorViewModel;
      expect(
        instance.hashCode,
        instance.runtimeType.hashCode ^ mapPropsToHashCode(instance.props),
      );
    });
  });
}
