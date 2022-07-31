import 'package:flutter_starter_kit/src/commons/constants/api_constant.dart';
import 'package:flutter_starter_kit/src/utils/error_code/error_code_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const Set<String> expectAppErrorCodes = <String>{
    'missingRequiredFields',
    'resourceNotFound',
    'unknownError'
  };

  group('AppErrorCodes enum', () {
    test('should have mandatory values', () {
      for (final AppErrorCodes value in AppErrorCodes.values) {
        expect(
          expectAppErrorCodes.contains(value.toString().split('.')[1]),
          true,
        );
      }

      expect(AppErrorCodes.values.length, expectAppErrorCodes.length);
    });
  });

  group('getAppErrorCode Method', () {
    test('Should return errorCode enum by case', () {
      expect(getAppErrorCode(code: 400), AppErrorCodes.missingRequiredFields);
      expect(
        getAppErrorCode(code: errorRequireFieldCodeAPI),
        AppErrorCodes.missingRequiredFields,
      );
      expect(getAppErrorCode(code: 404), AppErrorCodes.resourceNotFound);
      expect(getAppErrorCode(code: 500), AppErrorCodes.unknownError);
    });
  });
}
