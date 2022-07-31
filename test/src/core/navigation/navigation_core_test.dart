import 'package:flutter_starter_kit/src/core/navigation/navigation_core.dart';
import 'package:flutter_starter_kit/src/modules/common_module/configs/routes/route_config.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SubPath Class', () {
    test('Should have SubPath Class', () {
      expect(SubPath, SubPath);
    });

    test('Should have mandatory properties', () {
      expect(expectSubPath.name, expectTaskGetResponseEntity.title);
      expect(expectSubPath.path, commonNotFoundPath.path);
    });
  });

  group('NavigationError Class', () {
    test('Should have NavigationError Class', () {
      expect(NavigationError, NavigationError);
    });

    test('Should have mandatory properties', () {
      expect(expectNavigationError.code, expectDataSourceError.code);
      expect(expectNavigationError.message, expectDataSourceError.message);
    });
  });

  group('combinePath Function', () {
    test('Should have combinePath function', () {
      expect(combinePath, combinePath);
    });

    test('Should have mandatory properties', () {
      const String expectMainPath = '/main-path';
      final SubPath expectSubPath =
          SubPath(name: 'expectSubPath', path: '/sub-path/:id');
      const int expectId = 123;
      const String expectParams = 'title=test&name=name';
      final String expectCombinePath = combinePath(
        mainPath: expectMainPath,
        subPath: expectSubPath,
        replaceParameters: <String, String>{'id': expectId.toString()},
        params: expectParams,
      );

      expect(expectCombinePath, '$expectMainPath/sub-path/123?$expectParams');
    });
  });

  group('NavigationGetX Class', () {
    const String expectPath = '/path';
    test('Should have NavigationGetX Class', () {
      expect(NavigationGetX, NavigationGetX);
    });

    test('Should have pop method', () {
      expect(() => navigationGetX.pop(), isA<void>());
    });

    test('Should have push method', () {
      expect(() => navigationGetX.push(expectPath), isA<void>());
    });

    test('Should have replaceAll method', () {
      expect(() => navigationGetX.replaceAll(expectPath), isA<void>());
    });

    test('Should have replace method', () {
      expect(() => navigationGetX.replace(expectPath), isA<void>());
    });
  });
}
