import 'package:flutter_starter_kit/src/configs/error_messages/error_message_config.dart';
import 'package:flutter_starter_kit/src/configs/l10n/app_localizations.dart';
import 'package:flutter_starter_kit/src/core/navigation/navigation_core.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_create_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_delete_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_detail_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_get_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/applications/controllers/task_update_controller.dart';
import 'package:flutter_starter_kit/src/modules/task_module/configs/routes/route_config.dart';
import 'package:flutter_starter_kit/src/modules/task_module/presentations/screens/task_create_screen.dart';
import 'package:flutter_starter_kit/src/modules/task_module/presentations/screens/task_list_edit_screen.dart';
import 'package:flutter_starter_kit/src/modules/task_module/presentations/screens/task_list_screen.dart';
import 'package:flutter_starter_kit/src/modules/task_module/presentations/screens/task_update_screen.dart';
import 'package:flutter_starter_kit/src/modules/task_module/task_impl_usecase.dart';
import 'package:flutter_starter_kit/src/modules/task_module/task_module.dart';
import 'package:flutter_starter_kit/src/utils/error_code/error_code_util.dart';
import 'package:flutter_starter_kit/src/utils/image_picker/image_picker_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import '../../utils/image_picker/image_picker_util_test.mocks.dart';
import '../task_module/applications/controllers/task_create_controller_test.dart';
import '../task_module/applications/controllers/task_delete_controller_test.dart';
import '../task_module/applications/controllers/task_get_controller_test.dart';
import '../task_module/applications/controllers/task_update_controller_test.dart';
import '../task_module/task_impl_usecase_test.mocks.dart';
import 'applications/controllers/task_detail_controller_test.dart';

class MockTaskModuleBinding implements TaskModuleBinding {
  final MockTaskImplUseCase _usecase = MockTaskImplUseCase();

  @override
  TaskImplUseCase get usecase => _usecase;

  @override
  void dependencies() {
    Get.lazyPut<TaskGetController>(
      () => MockTaskGetController(usecase: _usecase),
    );

    Get.lazyPut<TaskCreateController>(
      () => MockTaskCreateController(usecase: _usecase),
    );

    Get.lazyPut<TaskDetailController>(() => MockTaskDetailController());

    Get.lazyPut<TaskUpdateController>(
      () => MockTaskUpdateController(usecase: _usecase),
    );

    Get.lazyPut<TaskDeleteController>(
      () => MockTaskDeleteController(usecase: _usecase),
    );

    Get.lazyPut<TaskGetController>(
      () => TaskGetController(usecase: MockTaskImplUseCase()),
      tag: 'grpcDatasource',
    );
  }
}

class MockTaskModule extends Mock implements TaskModule {
  final ImagePickerUtil _imagePicker = MockImagePickerUtil();

  @override
  ImagePickerUtil get imagePicker => _imagePicker;

  @override
  String get mainPath => taskMainPath;

  @override
  List<SubPath> get subPaths => <SubPath>[
    taskListEditPath,
    taskUpdatePath,
    taskCreatePath,
    taskListPath,
  ];

  @override
  String getFullPath({
    required SubPath subPath,
    Map<String, String>? replaceParameters,
    String? params,
  }) {
    try {
      final Iterable<SubPath> result =
      subPaths.where((SubPath taskSubPath) => taskSubPath == subPath);

      if (result.isNotEmpty) {
        return combinePath(
          mainPath: mainPath,
          subPath: subPath,
          replaceParameters: replaceParameters,
          params: params,
        );
      }

      throw NavigationError(
        message: cannotFindPathToNavigate,
        code: AppErrorCodes.resourceNotFound,
      );
    } catch (e) {
      throw NavigationError(
        message: cannotFindPathToNavigate,
        code: AppErrorCodes.resourceNotFound,
      );
    }
  }

  @override
  List<GetPage<Map<String, dynamic>>> get routeScreen =>
      <GetPage<Map<String, dynamic>>>[
        GetPage<Map<String, dynamic>>(
          name: getFullPath(subPath: taskListEditPath),
          page: () => TaskListEditScreen(),
          binding: MockTaskModuleBinding(),
        ),
        GetPage<Map<String, dynamic>>(
          name: getFullPath(subPath: taskCreatePath),
          page: () => TaskCreateScreen(
            imagePickerUtil: _imagePicker,
          ),
          binding: MockTaskModuleBinding(),
        ),
        GetPage<Map<String, dynamic>>(
          name: getFullPath(subPath: taskUpdatePath),
          page: () => TaskUpdateScreen(
            imagePickerUtil: _imagePicker,
          ),
          binding: MockTaskModuleBinding(),
        ),
        GetPage<Map<String, dynamic>>(
          name: getFullPath(subPath: taskListPath),
          page: () => TaskListScreen(),
        ),
      ];
}

void main() {
  final TaskModule _expectTaskModule = TaskModule();
  final TaskModuleBinding _expectTaskModuleBinding = TaskModuleBinding();
  final List<GetPage<Map<String, dynamic>>> expectRouteScreen =
      <GetPage<Map<String, dynamic>>>[
    GetPage<Map<String, dynamic>>(
      name: _expectTaskModule.getFullPath(subPath: taskListEditPath),
      page: () => TaskListEditScreen(),
      binding: _expectTaskModuleBinding,
    ),
    GetPage<Map<String, dynamic>>(
      name: _expectTaskModule.getFullPath(subPath: taskCreatePath),
      page: () => TaskCreateScreen(
        imagePickerUtil: ImagePickerUtil(),
      ),
      binding: _expectTaskModuleBinding,
    ),
    GetPage<Map<String, dynamic>>(
      name: _expectTaskModule.getFullPath(subPath: taskUpdatePath),
      page: () => TaskUpdateScreen(
        imagePickerUtil: ImagePickerUtil(),
      ),
      binding: _expectTaskModuleBinding,
    ),
    GetPage<Map<String, dynamic>>(
      name: _expectTaskModule.getFullPath(subPath: taskListPath),
      page: () => TaskListScreen(),
      binding: _expectTaskModuleBinding,
    )
  ];

  group('TaskModuleBinding Class', () {
    test('Should have TaskModuleBinding Class', () {
      expect(TaskModuleBinding, TaskModuleBinding);
    });

    test('Should have mandatory properties', () {
      expect(
        _expectTaskModuleBinding.usecase,
        isA<TaskImplUseCase>(),
      );
    });

    test('Should have dependencies method', () {
      expect(
        () => _expectTaskModuleBinding.dependencies(),
        isA<void>(),
      );
    });
  });

  group('TaskModule Class', () {
    test('Should have TaskModule Class', () {
      expect(TaskModule, TaskModule);
    });

    test('Should have mandatory properties', () {
      expect(
        _expectTaskModule.imagePicker,
        isA<ImagePickerUtil>(),
      );
      expect(
        _expectTaskModule.routeScreen,
        isA<List<GetPage<Map<String, dynamic>>>>(),
      );

      expect(_expectTaskModule.routeScreen.length, 4);

      for (int i = 0; i < _expectTaskModule.routeScreen.length; i++) {
        expect(
          _expectTaskModule.routeScreen[i].name,
          expectRouteScreen[i].name,
        );
        expect(
          _expectTaskModule.routeScreen[i].page.runtimeType,
          expectRouteScreen[i].page.runtimeType,
        );
        expect(
          _expectTaskModule.routeScreen[i].binding.runtimeType,
          expectRouteScreen[i].binding.runtimeType,
        );
      }
    });
  });

  testWidgets('Should have controller', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: _expectTaskModule.getFullPath(subPath: taskListEditPath),
        initialBinding: _expectTaskModuleBinding,
        getPages: <GetPage<Map<String, dynamic>>>[
          ..._expectTaskModule.routeScreen,
        ],
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );

    expect(Get.find<TaskGetController>(), isA<TaskGetController>());
    expect(Get.find<TaskCreateController>(), isA<TaskCreateController>());
    expect(Get.find<TaskDetailController>(), isA<TaskDetailController>());
    expect(Get.find<TaskUpdateController>(), isA<TaskUpdateController>());
    expect(Get.find<TaskDeleteController>(), isA<TaskDeleteController>());
    expect(
      Get.find<TaskGetController>(tag: 'grpcDatasource'),
      isA<TaskGetController>(),
    );
  });
}
