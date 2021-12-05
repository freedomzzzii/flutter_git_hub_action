import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../configs/routes/route_config.dart';
import '../../utils/image_picker/image_picker_util.dart';
import 'applications/bloc/task_bloc/task_bloc.dart';
import 'applications/bloc/task_sse_bloc/task_sse_bloc.dart';
import 'presentations/screens/task_create_screen.dart';
import 'presentations/screens/task_get_screen.dart';
import 'presentations/screens/task_get_sse_screen.dart';
import 'presentations/screens/task_update_screen.dart';
import 'services/datasources/api_datasource.dart';
import 'services/datasources/sse_datasource.dart';
import 'task_impl_repository.dart';
import 'task_impl_usecase.dart';

class TodoModule extends Module {
  final ImagePickerUtil _imagePicker = ImagePickerUtil();

  ImagePickerUtil get imagePicker => _imagePicker;

  @override
  List<Bind<Object>> get binds => <Bind<Object>>[
        Bind<Object>(
          (_) => TaskBloc(
            usecase: TaskImplUseCase(
              repository: TaskImplRepository(
                dataSource: ApiDataSource(
                  http: Dio(),
                ),
              ),
            ),
          ),
        ),
      ];

  @override
  List<ModularRoute<dynamic>> get routes => <ModularRoute<dynamic>>[
        ChildRoute<String>(
          initialRoute,
          child: (_, __) => TaskGetScreenWidget(),
        ),
        ChildRoute<String>(
          createTaskRoute,
          child: (_, __) => TaskCreateScreenWidget(
            imagePickerUtil: _imagePicker,
          ),
        ),
        ChildRoute<String>(
          updateTaskRoute,
          child: (_, __) => TaskUpdateScreenWidget(
            imagePickerUtil: _imagePicker,
          ),
        ),
        ChildRoute<String>(
          getTaskSseRoute,
          child: (_, __) => TaskGetSseScreen(
            bloc: TaskSseBloc(
              usecase: TaskImplSseUseCase(
                repository: TaskImplSseRepository(dataSource: SseDatasource()),
              ),
            ),
          ),
        ),
      ];
}
