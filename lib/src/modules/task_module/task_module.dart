import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../configs/error_messages/error_message_config.dart';
import '../../core/navigation/navigation_core.dart';
import '../../utils/error_code/error_code_util.dart';
import '../../utils/grpc/grpc_util.dart';
import '../../utils/image_picker/image_picker_util.dart';
import '../app_module.dart';
import 'applications/controllers/task_create_controller.dart';
import 'applications/controllers/task_delete_controller.dart';
import 'applications/controllers/task_detail_controller.dart';
import 'applications/controllers/task_get_controller.dart';
import 'applications/controllers/task_update_controller.dart';
import 'configs/routes/route_config.dart';
import 'presentations/screens/task_create_screen.dart';
import 'presentations/screens/task_list_edit_screen.dart';
import 'presentations/screens/task_list_screen.dart';
import 'presentations/screens/task_update_screen.dart';
import 'services/datasources/api_datasource.dart';
import 'services/datasources/grpc_datasource.dart';
import 'task_impl_repository.dart';
import 'task_impl_usecase.dart';

class TaskModuleBinding implements Bindings {
  final TaskImplUseCase _usecase = TaskImplUseCase(
    repository: TaskImplRepository(
      dataSource: ApiDataSource(
        http: Dio(),
      ),
    ),
  );

  TaskImplUseCase get usecase => _usecase;

  @override
  void dependencies() {
    Get.lazyPut<TaskGetController>(
      () => TaskGetController(usecase: _usecase),
    );

    Get.lazyPut<TaskCreateController>(
      () => TaskCreateController(usecase: _usecase),
    );

    Get.lazyPut<TaskDetailController>(
      () => TaskDetailController(),
    );

    Get.lazyPut<TaskUpdateController>(
      () => TaskUpdateController(usecase: _usecase),
    );

    Get.lazyPut<TaskDeleteController>(
      () => TaskDeleteController(usecase: _usecase),
    );
    Get.lazyPut<TaskGetController>(
      () => TaskGetController(
        usecase: TaskImplUseCase(
          repository: TaskImplRepository(
            dataSource: GprcDataSource(
              grpcClient: GrpcClientUtil(),
            ),
          ),
        ),
      ),
      tag: 'grpcDatasource',
    );
  }
}

class TaskModule implements Module {
  final ImagePickerUtil _imagePicker = ImagePickerUtil();
  final TaskModuleBinding _taskModuleBinding = TaskModuleBinding();

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
          binding: _taskModuleBinding,
        ),
        GetPage<Map<String, dynamic>>(
          name: getFullPath(subPath: taskCreatePath),
          page: () => TaskCreateScreen(imagePickerUtil: _imagePicker),
          binding: _taskModuleBinding,
        ),
        GetPage<Map<String, dynamic>>(
          name: getFullPath(subPath: taskUpdatePath),
          page: () => TaskUpdateScreen(imagePickerUtil: _imagePicker),
          binding: _taskModuleBinding,
        ),
        GetPage<Map<String, dynamic>>(
          name: getFullPath(subPath: taskListPath),
          page: () => TaskListScreen(),
          binding: _taskModuleBinding,
        ),
      ];
}
