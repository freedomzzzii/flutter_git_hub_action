import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/src/configs/l10n/app_localizations.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_get_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/configs/routes/route_config.dart';
import 'package:flutter_starter_kit/src/modules/task_module/configs/widget_key/widget_key_config.dart';
import 'package:flutter_starter_kit/src/modules/task_module/domains/entities/task_get_entity.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import '../../task_module_test.dart';

void main() {
  final MockTaskModule taskModule = MockTaskModule();
  final MockTaskModuleBinding taskModuleBinding = MockTaskModuleBinding();

  setUp(() {
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  group('TaskListScreen Class', () {
    testWidgets('Should have mandatory menu', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskListPath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onInit: () {
            final TaskGetController _getController =
                Get.find<TaskGetController>(tag: 'grpcDatasource');

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
    });

    testWidgets('Should have mandatory app bar', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskListPath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onInit: () {
            final TaskGetController _getController =
                Get.find<TaskGetController>(tag: 'grpcDatasource');

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

      expect(find.byKey(const Key(appBarTitleWidgetKey)), findsOneWidget);
    });

    testWidgets('Should show load data text', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskListPath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onInit: () {
            final TaskGetController _getController =
                Get.find<TaskGetController>(tag: 'grpcDatasource');

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

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(loadDataTaskGetWidgetKey)), findsOneWidget);
    });
  });

  group('Should call controller to get task', () {
    testWidgets(
        'Should call controller to get task - Success case (data empty)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskListPath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onInit: () {
            final TaskGetController _getController =
                Get.find<TaskGetController>(tag: 'grpcDatasource');

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

      await tester.pumpAndSettle();

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(dataEmptyTaskGetWidgetKey)), findsOneWidget);
    });

    testWidgets('Should call controller to get task - Success case (have data)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskListPath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onInit: () {
            final TaskGetController _getController =
                Get.find<TaskGetController>(tag: 'grpcDatasource');

            when(
              _getController.usecase.get(query: expectTaskGetRequestEntity),
            ).thenAnswer(
              (_) => Future<List<TaskGetResponseEntity>?>.value(
                <TaskGetResponseEntity>[expectTaskGetResponseEntity],
              ),
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Card), findsNWidgets(1));
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${titleTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${imageTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
    });

    testWidgets('''
Should call controller to get task - Failure case (error from controller)''',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskListPath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onInit: () {
            final TaskGetController _getController =
                Get.find<TaskGetController>(tag: 'grpcDatasource');

            when(
              _getController.usecase.get(query: expectTaskGetRequestEntity),
            ).thenThrow(expectTaskGetUseCaseError);
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(oopsErrorTaskGetWidgetKey)), findsOneWidget);
    });
  });
}
