import 'package:flutter_test/flutter_test.dart';
import 'package:poc_clean_arch/src/commons/constants/api_constant.dart';
import 'package:poc_clean_arch/src/utils/error_code_util.dart';

void main() {
  const Set<String> expectErrorCode = <String>{
    'missingRequiredFields',
    'resourceNotFound',
    'unknownError'
  };

  group('taskStateStatus enum', () {
    test('should have mandatory values', () {
      for (final appErrorCodes value in appErrorCodes.values) {
        expect(expectErrorCode.contains(value.toString().split('.')[1]), true);
      }

      expect(appErrorCodes.values.length, expectErrorCode.length);
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
