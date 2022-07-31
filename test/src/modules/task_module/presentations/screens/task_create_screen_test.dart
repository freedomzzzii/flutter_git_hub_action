import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/src/configs/l10n/app_localizations.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_create_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/models/error_view_model.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/models/exception_view_model.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/models/task_status_view_model.dart';
import 'package:flutter_starter_kit/src/modules/task_module/configs/routes/route_config.dart';
import 'package:flutter_starter_kit/src/modules/task_module/configs/widget_key/widget_key_config.dart';
import 'package:flutter_starter_kit/src/modules/task_module/domains/entities/task_create_entity.dart';
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

  group('TaskCreateScreen Class', () {
    testWidgets('Should have mandatory menu', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskCreatePath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(
        find.text(
          AppLocalizations.of(Get.context!).createBottomMenu,
        ),
        findsOneWidget,
      );
      expect(
        find.text(
          AppLocalizations.of(Get.context!).listBottomMenu,
        ),
        findsOneWidget,
      );
      expect(
        find.text(
          AppLocalizations.of(Get.context!).grpcBottomMenu,
        ),
        findsOneWidget,
      );
    });

    testWidgets('Should have mandatory app bar', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskCreatePath),
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

    testWidgets('Should have mandatory form', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskCreatePath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(
        find.text(
          AppLocalizations.of(Get.context!).selectImage,
        ),
        findsOneWidget,
      );
      expect(
        find.text(
          AppLocalizations.of(Get.context!).textFieldPlaceHolder,
        ),
        findsOneWidget,
      );
      expect(find.byKey(const Key(titleTextFieldWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(buttonSelectImageWidgetKey)), findsOneWidget);
    });

    testWidgets('Should call create controller to create task - Success case',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskCreatePath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      when(taskModule.imagePicker.getBase64Image()).thenAnswer(
        (_) => Future<String>.value(expectTaskCreateResponseEntity.imageUrl),
      );

      await tester.enterText(
        find.byKey(const Key(titleTextFieldWidgetKey)),
        expectTaskCreateResponseEntity.title,
      );

      final TaskCreateController _createController =
          Get.find<TaskCreateController>();
      when(
        _createController.usecase.create(
          task: expectTaskCreateRequestEntity,
        ),
      ).thenAnswer(
        (_) => Future<TaskCreateResponseEntity>.value(
          expectTaskCreateResponseEntity,
        ),
      );

      await tester.enterText(
        find.byKey(const Key(titleTextFieldWidgetKey)),
        expectTaskCreateResponseEntity.title,
      );

      await tester.tap(find.byKey(const Key(buttonSelectImageWidgetKey)));

      await tester.pumpAndSettle();

      expect(_createController.status, TaskStatusViewModel.success);

      verify(taskModule.imagePicker.getBase64Image()).called(1);

      expect(
        Get.currentRoute,
        taskModule.getFullPath(subPath: taskListEditPath),
      );
    });

    testWidgets('''
Should call create controller to create task - Failure case (error from ImagePickerUtil)''',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskCreatePath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      await tester.enterText(
        find.byKey(const Key(titleTextFieldWidgetKey)),
        expectTaskCreateResponseEntity.title,
      );

      when(taskModule.imagePicker.getBase64Image())
          .thenThrow(expectImagePickerUtilError);

      await tester.tap(find.byKey(const Key(buttonSelectImageWidgetKey)));

      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key(snackBarFailureWidgetKey)),
        findsOneWidget,
      );

      verify(taskModule.imagePicker.getBase64Image()).called(1);

      expect(
        Get.currentRoute,
        taskModule.getFullPath(subPath: taskCreatePath),
      );
    });

    testWidgets('''
Should call create controller to create task - Failure case (error from controller)''',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskCreatePath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      when(taskModule.imagePicker.getBase64Image()).thenAnswer(
        (_) => Future<String>.value(expectTaskCreateResponseEntity.imageUrl),
      );

      await tester.enterText(
        find.byKey(const Key(titleTextFieldWidgetKey)),
        expectTaskCreateResponseEntity.title,
      );

      final TaskCreateController _createController =
          Get.find<TaskCreateController>();
      when(
        _createController.usecase.create(
          task: expectTaskCreateRequestEntity,
        ),
      ).thenThrow(expectTaskCreateUseCaseError);

      await tester.tap(find.byKey(const Key(buttonSelectImageWidgetKey)));

      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key(snackBarFailureWidgetKey)),
        findsOneWidget,
      );

      expect(_createController.status, TaskStatusViewModel.failure);

      expect(_createController.error, isA<ErrorViewModel>());

      expect(_createController.exception, null);

      verify(taskModule.imagePicker.getBase64Image()).called(1);
    });

    testWidgets('''
Should call create controller to create task - Failure case (exception from controller)''',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskCreatePath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      when(taskModule.imagePicker.getBase64Image()).thenAnswer(
        (_) => Future<String>.value(expectTaskCreateResponseEntity.imageUrl),
      );

      await tester.enterText(
        find.byKey(const Key(titleTextFieldWidgetKey)),
        expectTaskCreateResponseEntity.title,
      );

      final TaskCreateController _createController =
          Get.find<TaskCreateController>();
      when(
        _createController.usecase.create(
          task: expectTaskCreateRequestEntity,
        ),
      ).thenThrow(expectTaskFieldValidationExceptionTitleEmpty);

      await tester.tap(find.byKey(const Key(buttonSelectImageWidgetKey)));

      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key(snackBarFailureWidgetKey)),
        findsOneWidget,
      );

      expect(_createController.status, TaskStatusViewModel.failure);

      expect(_createController.error, null);

      expect(_createController.exception, isA<ExceptionViewModel>());

      verify(taskModule.imagePicker.getBase64Image()).called(1);
    });
  });
}
