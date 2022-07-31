import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/src/configs/error_messages/error_message_config.dart';
import 'package:flutter_starter_kit/src/core/navigation/navigation_core.dart';
import 'package:flutter_starter_kit/src/modules/common_module/common_module.dart';
import 'package:flutter_starter_kit/src/modules/common_module/configs/routes/route_config.dart';
import 'package:flutter_starter_kit/src/modules/common_module/presentations/screens/common_not_found_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  final CommonModule _expectCommonModule = CommonModule();
  final List<GetPage<Map<String, dynamic>>> expectRouteScreen =
      <GetPage<Map<String, dynamic>>>[
    GetPage<Map<String, dynamic>>(
      name: _expectCommonModule.getFullPath(subPath: commonNotFoundPath),
      page: () => const CommonNotFoundScreen(),
    ),
  ];

  setUpAll(() {
    Get.testMode = true;

    WidgetsFlutterBinding.ensureInitialized();
  });

  group('CommonModule Class', () {
    test('Should have CommonModule Class', () {
      expect(CommonModule, CommonModule);
    });

    test('Should have mandatory properties', () {
      expect(
        _expectCommonModule.routeScreen,
        isA<List<GetPage<Map<String, dynamic>>>>(),
      );

      expect(_expectCommonModule.routeScreen.length, 1);

      for (int i = 0; i < _expectCommonModule.routeScreen.length; i++) {
        expect(
          _expectCommonModule.routeScreen[i].name,
          expectRouteScreen[i].name,
        );
        expect(
          _expectCommonModule.routeScreen[i].page.runtimeType,
          expectRouteScreen[i].page.runtimeType,
        );
        expect(
          _expectCommonModule.routeScreen[i].binding.runtimeType,
          expectRouteScreen[i].binding.runtimeType,
        );
      }
    });

    test('Should have getFullPath method - Success case', () {
      expect(
        _expectCommonModule.getFullPath(subPath: commonNotFoundPath),
        '${_expectCommonModule.mainPath}${commonNotFoundPath.path}',
      );
    });

    test('Should have getFullPath method - Failure case (sub path)', () {
      final SubPath subPath = SubPath(name: 'name', path: 'path');
      final Map<String, String> replaceParameters = <String, String>{
        'id': '123'
      };

      expect(
        () => _expectCommonModule.getFullPath(
          subPath: subPath,
          replaceParameters: replaceParameters,
        ),
        throwsA(isA<NavigationError>()),
      );

      expect(
        () => _expectCommonModule.getFullPath(
          subPath: subPath,
          replaceParameters: replaceParameters,
        ),
        throwsA(
          predicate(
            (Error e) =>
                e is NavigationError &&
                e.toString().contains(cannotFindPathToNavigate),
          ),
        ),
      );
    });

    test('Should have getFullPath method - Failure case (map parameter)', () {
      final Map<String, String> replaceParameters = <String, String>{
        'id': '123'
      };

      expect(
        () => _expectCommonModule.getFullPath(
          subPath: commonNotFoundPath,
          replaceParameters: replaceParameters,
        ),
        throwsA(isA<NavigationError>()),
      );

      expect(
        () => _expectCommonModule.getFullPath(
          subPath: commonNotFoundPath,
          replaceParameters: replaceParameters,
        ),
        throwsA(
          predicate(
            (Error e) =>
                e is NavigationError &&
                e.toString().contains(cannotReplaceParameter),
          ),
        ),
      );
    });
  });
}
