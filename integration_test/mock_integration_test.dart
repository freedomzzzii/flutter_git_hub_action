import 'package:flutter_starter_kit/src/configs/error_messages/error_message_config.dart';
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
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import 'main_integration_test.mocks.dart';

class MockTaskCreateController extends TaskCreateController with Mock {
  MockTaskCreateController({required MockTaskImplUseCase usecase})
      : super(usecase: usecase);
}

class MockTaskDeleteController extends TaskDeleteController with Mock {
  MockTaskDeleteController({required MockTaskImplUseCase usecase})
      : super(usecase: usecase);
}

class MockTaskGetController extends TaskGetController with Mock {
  MockTaskGetController({required MockTaskImplUseCase usecase})
      : super(usecase: usecase);
}

class MockTaskUpdateController extends TaskUpdateController with Mock {
  MockTaskUpdateController({required MockTaskImplUseCase usecase})
      : super(usecase: usecase);
}

class MockTaskDetailController extends TaskDetailController with Mock {
  MockTaskDetailController() : super();
}

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
