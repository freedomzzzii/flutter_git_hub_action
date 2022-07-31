import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/src/configs/l10n/app_localizations.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_detail_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_get_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_update_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/models/exception_view_model.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/models/task_status_view_model.dart';
import 'package:flutter_starter_kit/src/modules/task_module/configs/routes/route_config.dart';
import 'package:flutter_starter_kit/src/modules/task_module/configs/widget_key/widget_key_config.dart';
import 'package:flutter_starter_kit/src/modules/task_module/domains/entities/task_get_entity.dart';
import 'package:flutter_starter_kit/src/modules/task_module/domains/entities/task_update_entity.dart';
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

  group('TaskUpdateScreen Class', () {
    testWidgets('Should mandatory widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskUpdatePath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onInit: () {
            final TaskDetailController _detailController =
                Get.find<TaskDetailController>();

            _detailController.selectTaskToUpdate(
              task: expectTaskUpdateControllerModel,
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key(textFieldUpdateWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(imageUpdateWidgetKey)), findsOneWidget);
      expect(
        find.byKey(const Key(buttonSelectUpdateImageWidgetKey)),
        findsOneWidget,
      );
      expect(find.byKey(const Key(saveUpdateButtonWidgetKey)), findsOneWidget);
    });

    testWidgets('Should accept state from event', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskUpdatePath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onInit: () {
            final TaskDetailController _detailController =
                Get.find<TaskDetailController>();

            _detailController.selectTaskToUpdate(
              task: expectTaskUpdateControllerModel,
            );
          },
        ),
      );

      final TextFormField textField = tester.widget<TextFormField>(
        find.byKey(const Key(textFieldUpdateWidgetKey)),
      );
      expect(textField.controller?.text, expectTaskGetResponseEntity.title);
    });

    testWidgets('Should call controller to update task - Success case',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskUpdatePath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onInit: () {
            final TaskDetailController _detailController =
                Get.find<TaskDetailController>();

            _detailController.selectTaskToUpdate(
              task: expectTaskUpdateControllerModel,
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      when(taskModule.imagePicker.getBase64Image()).thenAnswer(
        (_) => Future<String>.value(
          '''
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=''',
        ),
      );

      await tester.enterText(
        find.byKey(const Key(textFieldUpdateWidgetKey)),
        'expectTaskTitle',
      );

      await tester.tap(find.byKey(const Key(buttonSelectUpdateImageWidgetKey)));

      await tester.pump();

      verify(taskModule.imagePicker.getBase64Image()).called(1);

      final TaskGetController _getController = Get.find<TaskGetController>();
      final TaskUpdateController _updateController =
          Get.find<TaskUpdateController>();

      when(
        _updateController.usecase.update(
          task: const TaskUpdateBodyRequestEntity(
            title: 'expectTaskTitle',
            imageUrl: '''
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=''',
          ),
          queryParams: expectTaskUpdateQueryParamsRequestEntity,
        ),
      ).thenAnswer(
        (_) => Future<TaskUpdateResponseEntity>.value(
          expectTaskUpdateResponseEntity,
        ),
      );
      when(
        _getController.usecase.get(query: expectTaskGetRequestEntity),
      ).thenAnswer(
        (_) => Future<List<TaskGetResponseEntity>?>.value(
          <TaskGetResponseEntity>[expectTaskGetResponseEntity],
        ),
      );

      await tester.tap(find.byKey(const Key(saveUpdateButtonWidgetKey)));

      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key(snackBarUpdateSuccessWidgetKey)),
        findsOneWidget,
      );

      expect(_updateController.status, TaskStatusViewModel.success);
      expect(_updateController.error, null);
      expect(_updateController.exception, null);

      expect(
        Get.currentRoute,
        taskModule.getFullPath(subPath: taskListEditPath),
      );
    });

    testWidgets('''
Should call controller to update task - Failure case (error from ImagePickerUtil)''',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskUpdatePath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onInit: () {
            final TaskDetailController _detailController =
                Get.find<TaskDetailController>();

            _detailController.selectTaskToUpdate(
              task: expectTaskUpdateControllerModel,
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      when(taskModule.imagePicker.getBase64Image())
          .thenThrow(expectImagePickerUtilError);

      await tester.enterText(
        find.byKey(const Key(textFieldUpdateWidgetKey)),
        'expectTaskTitle',
      );

      await tester.tap(find.byKey(const Key(buttonSelectUpdateImageWidgetKey)));

      await tester.pump();

      verify(taskModule.imagePicker.getBase64Image()).called(1);

      expect(
        find.byKey(const Key(snackBarUpdateFailureWidgetKey)),
        findsOneWidget,
      );

      expect(
        Get.currentRoute,
        taskModule.getFullPath(subPath: taskUpdatePath),
      );
    });

    testWidgets('''
Should call controller to update task - Failure case (error from controller)''',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: taskModule.getFullPath(subPath: taskUpdatePath),
          initialBinding: taskModuleBinding,
          getPages: <GetPage<Map<String, dynamic>>>[
            ...taskModule.routeScreen,
          ],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onInit: () {
            final TaskDetailController _detailController =
                Get.find<TaskDetailController>();

            _detailController.selectTaskToUpdate(
              task: expectTaskUpdateControllerModel,
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      when(taskModule.imagePicker.getBase64Image()).thenAnswer(
        (_) => Future<String>.value(
          '''
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=''',
        ),
      );

      await tester.enterText(
        find.byKey(const Key(textFieldUpdateWidgetKey)),
        'expectTaskTitle',
      );

      await tester.tap(find.byKey(const Key(buttonSelectUpdateImageWidgetKey)));

      await tester.pump();

      verify(taskModule.imagePicker.getBase64Image()).called(1);

      final TaskUpdateController _updateController =
          Get.find<TaskUpdateController>();

      when(
        _updateController.usecase.update(
          task: const TaskUpdateBodyRequestEntity(
            title: 'expectTaskTitle',
            imageUrl: '''
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=''',
          ),
          queryParams: expectTaskUpdateQueryParamsRequestEntity,
        ),
      ).thenThrow(expectFieldRequiredExceptionId);

      await tester.tap(find.byKey(const Key(saveUpdateButtonWidgetKey)));

      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key(snackBarUpdateFailureWidgetKey)),
        findsOneWidget,
      );

      expect(_updateController.status, TaskStatusViewModel.failure);
      expect(_updateController.error, null);
      expect(_updateController.exception, isA<ExceptionViewModel>());

      expect(
        Get.currentRoute,
        taskModule.getFullPath(subPath: taskUpdatePath),
      );
    });
  });
}
