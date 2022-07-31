import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/src/configs/l10n/app_localizations.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_delete_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_get_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_update_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/models/error_view_model.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/models/exception_view_model.dart';
import 'package:flutter_starter_kit/src/modules/task_module/configs/routes/route_config.dart';
import 'package:flutter_starter_kit/src/modules/task_module/configs/widget_key/widget_key_config.dart';
import 'package:flutter_starter_kit/src/modules/task_module/domains/entities/task_get_entity.dart';
import 'package:flutter_starter_kit/src/modules/task_module/domains/entities/task_update_entity.dart';
import 'package:flutter_starter_kit/src/modules/task_module/services/commons/request_query.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';

import '../mock_integration_test.dart';

void screenTest() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final MockTaskModule taskModule = MockTaskModule();
  final MockTaskModuleBinding taskModuleBinding = MockTaskModuleBinding();

  setUp(() {
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  group('TaskListEditScreen Class', () {
    testWidgets('Should have mandatory menu', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskListEditPath),
          initialBinding: taskModuleBinding,
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
    });

    testWidgets('Should have mandatory app bar', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskListEditPath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(appBarTitleWidgetKey)), findsOneWidget);
    });

    testWidgets('Should show load data text', (WidgetTester tester) async {
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
              (_) => Future<List<TaskGetResponseEntity>?>.value(),
            );
          },
        ),
      );

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsNothing);
      expect(
        find.byKey(const Key(loadDataTaskGetWidgetKey)),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsNothing);
      expect(
        find.byKey(const Key(dataEmptyTaskGetWidgetKey)),
        findsOneWidget,
      );
    });

    testWidgets('Should call controller to get task - Success case (have data)',
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
                <TaskGetResponseEntity>[expectTaskGetResponseEntity],
              ),
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key(sortByDropdownWidgetKey)),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key(orderByDropdownWidgetKey)),
        findsOneWidget,
      );
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
    });

    testWidgets(
        'Should call controller to get task - Success case (tap orderBy)',
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
                <TaskGetResponseEntity>[expectTaskGetResponseEntity],
              ),
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key(sortByDropdownWidgetKey)),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key(orderByDropdownWidgetKey)),
        findsOneWidget,
      );
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );

      await tester.tap(find.byKey(const Key(orderByDropdownWidgetKey)));
      await tester.pump();

      final TaskGetController _getController = Get.find<TaskGetController>();
      when(
        _getController.usecase.get(
          query: const TaskGetRequestEntity(
            sortBy: createdAtQueryValue,
            orderBy: ascQueryValue,
          ),
        ),
      ).thenAnswer(
        (_) => Future<List<TaskGetResponseEntity>?>.value(
          <TaskGetResponseEntity>[
            expectTaskGetResponseEntity,
            expectTaskGetResponseEntity
          ],
        ),
      );

      await tester.tap(
        find.text(ascQueryValue).last,
      );

      await tester.pumpAndSettle();

      expect(find.byType(Card), findsNWidgets(2));
    });

    testWidgets(
        'Should call controller to get task - Success case (tap sortBy)',
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
                <TaskGetResponseEntity>[expectTaskGetResponseEntity],
              ),
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key(sortByDropdownWidgetKey)),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key(orderByDropdownWidgetKey)),
        findsOneWidget,
      );
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );

      await tester.tap(find.byKey(const Key(sortByDropdownWidgetKey)));

      await tester.pump();

      final TaskGetController _getController = Get.find<TaskGetController>();
      when(
        _getController.usecase.get(
          query: const TaskGetRequestEntity(
            sortBy: createdAtQueryValue,
            orderBy: descQueryValue,
          ),
        ),
      ).thenAnswer(
        (_) => Future<List<TaskGetResponseEntity>?>.value(
          <TaskGetResponseEntity>[expectTaskGetResponseEntity],
        ),
      );

      await tester.tap(
        find.text(createdAtQueryValue).last,
      );

      await tester.pump();

      expect(find.byType(Card), findsNWidgets(1));
    });

    testWidgets('''
Should call controller to get task - Failure case (error from controller)''',
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
            ).thenThrow(expectTaskGetUseCaseError);
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsNothing);
      expect(
        find.byKey(const Key(oopsErrorTaskGetWidgetKey)),
        findsOneWidget,
      );

      final TaskGetController _getController = Get.find<TaskGetController>();
      expect(_getController.error, isA<ErrorViewModel>());
    });
  });

  group('Should call controller to update task', () {
    testWidgets('Should call controller to update task - Success case (isDone)',
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
                <TaskGetResponseEntity>[expectTaskGetResponseEntity],
              ),
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsOneWidget);
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );

      final TaskGetController _getController = Get.find<TaskGetController>();
      final TaskUpdateController _updateTaskController =
          Get.find<TaskUpdateController>();
      when(
        _updateTaskController.usecase.update(
          queryParams: expectTaskUpdateQueryParamsRequestEntity,
          task: const TaskUpdateBodyRequestEntity(isDone: true),
        ),
      ).thenAnswer(
        (_) => Future<TaskUpdateResponseEntity>.value(
          TaskUpdateResponseEntity(
            id: expectTaskGetResponseEntity.id,
            createdAt: expectTaskGetResponseEntity.createdAt,
            isDone: true,
            title: expectTaskGetResponseEntity.title,
            imageUrl: expectTaskGetResponseEntity.imageUrl,
          ),
        ),
      );
      when(_getController.usecase.get(query: expectTaskGetRequestEntity))
          .thenAnswer(
        (_) =>
            Future<List<TaskGetResponseEntity>?>.value(<TaskGetResponseEntity>[
          TaskGetResponseEntity(
            id: expectTaskGetResponseEntity.id,
            createdAt: expectTaskGetResponseEntity.createdAt,
            isDone: true,
            title: expectTaskGetResponseEntity.title,
            imageUrl: expectTaskGetResponseEntity.imageUrl,
          )
        ]),
      );

      await tester.tap(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Status: true'), findsOneWidget);

      expect(find.byType(Card), findsNWidgets(1));
    });

    testWidgets('''
Should call controller to update task - Success case (navigate to update screen)''',
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
                <TaskGetResponseEntity>[expectTaskGetResponseEntity],
              ),
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsOneWidget);
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );

      await tester.tap(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
      );

      await tester.pump();

      expect(
        Get.currentRoute,
        taskModule.getFullPath(subPath: taskUpdatePath),
      );
    });

    testWidgets('''
Should call controller to update task - Failure case (error from controller isDone btn)''',
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
                <TaskGetResponseEntity>[expectTaskGetResponseEntity],
              ),
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsOneWidget);
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );

      final TaskUpdateController _updateTaskController =
          Get.find<TaskUpdateController>();
      when(
        _updateTaskController.usecase.update(
          queryParams: expectTaskUpdateQueryParamsRequestEntity,
          task: const TaskUpdateBodyRequestEntity(isDone: true),
        ),
      ).thenThrow(expectTaskUpdateUseCaseError);

      await tester.tap(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
      );

      await tester.pump();

      expect(find.byKey(const Key(snackBarFailureWidgetKey)), findsOneWidget);
    });
  });

  group('Should call controller to delete task', () {
    testWidgets('Should call controller to delete task - Success case',
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
                <TaskGetResponseEntity>[expectTaskGetResponseEntity],
              ),
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsOneWidget);
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );

      final TaskGetController _getController = Get.find<TaskGetController>();
      final TaskDeleteController _deleteTaskController =
          Get.find<TaskDeleteController>();
      when(
        _deleteTaskController.usecase
            .delete(queryParams: expectTaskDeleteQueryParamsRequestEntity),
      ).thenAnswer((_) => Future<void>.value());
      when(_getController.usecase.get(query: expectTaskGetRequestEntity))
          .thenAnswer(
        (_) => Future<List<TaskGetResponseEntity>?>.value(
          <TaskGetResponseEntity>[],
        ),
      );

      await tester.tap(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Card), findsNWidgets(0));
    });

    testWidgets('''
Should call controller to delete task - Failure case (error from controller)''',
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
            final TaskGetController _getTaskController =
                Get.find<TaskGetController>();
            when(
              _getTaskController.usecase.get(query: expectTaskGetRequestEntity),
            ).thenAnswer(
              (_) => Future<List<TaskGetResponseEntity>?>.value(
                <TaskGetResponseEntity>[expectTaskGetResponseEntity],
              ),
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsOneWidget);
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );

      final TaskDeleteController _deleteTaskController =
          Get.find<TaskDeleteController>();
      when(
        _deleteTaskController.usecase
            .delete(queryParams: expectTaskDeleteQueryParamsRequestEntity),
      ).thenThrow(expectTaskDeleteUseCaseError);

      await tester.tap(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key(snackBarFailureWidgetKey)), findsOneWidget);

      expect(_deleteTaskController.error, isA<ErrorViewModel>());
      expect(_deleteTaskController.exception, null);
    });

    testWidgets('''
Should call controller to delete task - Failure case (exception from controller)''',
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
            final TaskGetController _getTaskController =
                Get.find<TaskGetController>();
            when(
              _getTaskController.usecase.get(query: expectTaskGetRequestEntity),
            ).thenAnswer(
              (_) => Future<List<TaskGetResponseEntity>?>.value(
                <TaskGetResponseEntity>[expectTaskGetResponseEntity],
              ),
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsOneWidget);
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );

      final TaskDeleteController _deleteTaskController =
          Get.find<TaskDeleteController>();
      when(
        _deleteTaskController.usecase
            .delete(queryParams: expectTaskDeleteQueryParamsRequestEntity),
      ).thenThrow(expectFieldRequiredExceptionId);

      await tester.tap(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key(snackBarFailureWidgetKey)), findsOneWidget);

      expect(_deleteTaskController.error, null);
      expect(_deleteTaskController.exception, isA<ExceptionViewModel>());
    });
  });
}
