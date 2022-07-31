import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_starter_kit/src/configs/l10n/app_localizations.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_get_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/configs/routes/route_config.dart';
import 'package:flutter_starter_kit/src/modules/task_module/domains/entities/task_get_entity.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import '../../../../utils/firebase/firebase_message_util_test.dart';
import '../../task_module_test.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  final MockTaskModule taskModule = MockTaskModule();
  final MockTaskModuleBinding taskModuleBinding = MockTaskModuleBinding();

  setUp(() {
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  group('BottomMenuBarWidget Class', () {
    testWidgets('Should have mandatory menu', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskListEditPath),
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(
        find.text(AppLocalizations.of(Get.context!).createBottomMenu),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.of(Get.context!).listBottomMenu),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.of(Get.context!).grpcBottomMenu),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.of(Get.context!).grpcBottomMenu),
        findsOneWidget,
      );
    });

    testWidgets('Should navigate to screen (list, create, update)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskListEditPath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onInit: () {
            final TaskGetController _getController =
                Get.find<TaskGetController>();

            when(
              _getController.usecase.get(query: expectTaskGetRequestEntity),
            ).thenAnswer(
              (_) => Future<List<TaskGetResponseEntity>?>.value(
                <TaskGetResponseEntity>[],
              ),
            );
          },
        ),
      );

      expect(
        Get.currentRoute,
        taskModule.getFullPath(subPath: taskListEditPath),
      );

      await tester
          .tap(find.text(AppLocalizations.of(Get.context!).createBottomMenu));

      await tester.pumpAndSettle();

      expect(
        Get.currentRoute,
        taskModule.getFullPath(subPath: taskCreatePath),
      );

      final TaskGetController _getControllerGrpcDatasource =
          Get.find<TaskGetController>(tag: 'grpcDatasource');

      when(
        _getControllerGrpcDatasource.usecase
            .get(query: expectTaskGetRequestEntity),
      ).thenAnswer(
        (_) => Future<List<TaskGetResponseEntity>?>.value(
          <TaskGetResponseEntity>[],
        ),
      );

      await tester
          .tap(find.text(AppLocalizations.of(Get.context!).grpcBottomMenu));

      await tester.pumpAndSettle();

      expect(Get.currentRoute, taskModule.getFullPath(subPath: taskListPath));

      await tester
          .tap(find.text(AppLocalizations.of(Get.context!).listBottomMenu));

      await tester.pumpAndSettle();

      expect(
        Get.currentRoute,
        taskModule.getFullPath(subPath: taskListEditPath),
      );
    });
  });
}
