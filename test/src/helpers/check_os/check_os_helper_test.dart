import 'package:flutter_starter_kit/src/helpers/check_os/check_os_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const Set<String> expectOsCodes = <String>{'web', 'android', 'ios'};

  group('osCodes enum', () {
    test('should have mandatory values', () {
      for (final osCodes value in osCodes.values) {
        expect(expectOsCodes.contains(value.toString().split('.')[1]), true);
      }

      expect(osCodes.values.length, expectOsCodes.length);
    });
  });

  group('getOs Method', () {
    test('Should throw error - Failure case', () {
      expect(() => getOs(), throwsA(isA<GetOsError>()));
    });
  });
}
