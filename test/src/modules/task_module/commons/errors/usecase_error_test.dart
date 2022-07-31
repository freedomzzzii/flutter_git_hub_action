import 'package:flutter_starter_kit/src/modules/task_module/commons/errors/usecase_error.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaskCreateUseCaseError Class', () {
    test('Should have TaskCreateUseCaseError Class', () {
      expect(TaskCreateUseCaseError, TaskCreateUseCaseError);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskCreateUseCaseError.message,
        expectDataSourceErrorRequiredField.message,
      );
      expect(
        expectTaskCreateUseCaseError.code,
        expectDataSourceErrorRequiredField.code,
      );
    });
  });

  group('TaskGetUseCaseError Class', () {
    test('Should have TaskGetUseCaseError Class', () {
      expect(TaskGetUseCaseError, TaskGetUseCaseError);
    });

    test('Should have mandatory properties', () {
      expect(expectTaskGetUseCaseError.message, expectDataSourceError.message);
      expect(expectTaskGetUseCaseError.code, expectDataSourceError.code);
    });
  });

  group('TaskUpdateUseCaseError Class', () {
    test('Should have TaskUpdateUseCaseError Class', () {
      expect(TaskUpdateUseCaseError, TaskUpdateUseCaseError);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskUpdateUseCaseError.message,
        expectDataSourceError.message,
      );
      expect(expectTaskUpdateUseCaseError.code, expectDataSourceError.code);
    });
  });

  group('TaskDeleteUseCaseError Class', () {
    test('Should have TaskDeleteUseCaseError Class', () {
      expect(TaskDeleteUseCaseError, TaskDeleteUseCaseError);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskDeleteUseCaseError.message,
        expectDataSourceError.message,
      );
      expect(expectTaskDeleteUseCaseError.code, expectDataSourceError.code);
    });
  });
}
