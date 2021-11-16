import 'package:flutter_starter_kit/src/commons/constants/api_constant.dart';
import 'package:flutter_starter_kit/src/utils/error_code/error_code_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const Set<String> expectAppErrorCodes = <String>{
    'missingRequiredFields',
    'resourceNotFound',
    'unknownError'
  };

  group('appErrorCodes enum', () {
    test('should have mandatory values', () {
      for (final appErrorCodes value in appErrorCodes.values) {
        expect(
          expectAppErrorCodes.contains(value.toString().split('.')[1]),
          true,
        );
      }

      expect(appErrorCodes.values.length, expectAppErrorCodes.length);
    });
  });

  group('getAppErrorCode Method', () {
    test('Should return errorCode enum by case', () {
      expect(getAppErrorCode(code: 400), appErrorCodes.missingRequiredFields);
      expect(
        getAppErrorCode(code: errorRequireFieldCodeAPI),
        appErrorCodes.missingRequiredFields,
      );
      expect(getAppErrorCode(code: 404), appErrorCodes.resourceNotFound);
      expect(getAppErrorCode(code: 500), appErrorCodes.unknownError);
    });
  });
}
