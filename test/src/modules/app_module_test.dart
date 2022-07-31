import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_starter_kit/src/helpers/check_os/check_os_helper.dart';
import 'package:flutter_starter_kit/src/modules/app_module.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils/firebase/firebase_message_util_test.dart';

void main() {
  final AppBinding expectAppBinding = AppBinding(os: OsCodes.ios);
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group('AppBinding Class', () {
    test('Should have AppBinding Class', () {
      expect(AppBinding, AppBinding);
    });

    test('Should have mandatory properties', () async {
      expect(expectAppBinding.os, OsCodes.ios);
    });

    test('Should have dependencies method', () {
      expect(() => expectAppBinding.dependencies(), isA<void>());
    });
  });

  group('Module Class', () {
    test('Should have Module Class', () {
      expect(Module, Module);
    });
  });

  test('Should have allRouteScreen Variable', () {
    expect(allRouteScreen.length, 5);
  });
}
