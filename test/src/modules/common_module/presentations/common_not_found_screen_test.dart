import 'package:flutter_starter_kit/src/configs/l10n/app_localizations.dart';
import 'package:flutter_starter_kit/src/modules/app_module.dart';
import 'package:flutter_starter_kit/src/modules/common_module/configs/routes/route_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });

  group('CommonNotFoundScreen Class', () {
    testWidgets('Should have mandatory menu', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: commonModule.getFullPath(subPath: commonNotFoundPath),
          getPages: <GetPage<Map<String, dynamic>>>[
            ...commonModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(
        find.text(
          AppLocalizations.of(Get.context!).notFoundPage,
        ),
        findsOneWidget,
      );
    });
  });
}
