import 'package:flutter_starter_kit/src/modules/todo_module/commons/errors/usecase_error.dart';
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

  group('TaskStreamGetUseCaseError Class', () {
    test('Should have TaskStreamGetUseCaseError Class', () {
      expect(TaskStreamGetUseCaseError, TaskStreamGetUseCaseError);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskStreamGetUseCaseError.message,
        expectDataSourceError.message,
      );
      expect(
        expectTaskStreamGetUseCaseError.code, expectDataSourceError.code,);
    });
  });

  group('TaskSendDataUseCaseError Class', () {
    test('Should have TaskSendDataUseCaseError Class', () {
      expect(
        TaskSendDataUseCaseError, TaskSendDataUseCaseError,);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskSendDataUseCaseError.message,
        expectDataSourceError.message,
      );
      expect(expectTaskSendDataUseCaseError.code,
        expectDataSourceError.code,);
    });
  });

  group('TaskDisconnectUseCaseError Class', () {
    test('Should have TaskDisconnectUseCaseError Class', () {
      expect(TaskDisconnectUseCaseError, TaskDisconnectUseCaseError);
    });

    test('Should have mandatory properties', () {
      expect(
        expectTaskDisconnectUseCaseError.message,
        expectDataSourceError.message,
      );
      expect(expectTaskDisconnectUseCaseError.code,
        expectDataSourceError.code,);
    });
  });
}
