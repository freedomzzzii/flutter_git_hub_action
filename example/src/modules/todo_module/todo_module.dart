import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../configs/routes/route_config.dart';
import '../../utils/image_picker/image_picker_util.dart';
import 'applications/bloc/task_bloc/task_bloc.dart';
import 'presentations/screens/task_get_screen.dart';
import 'services/datasources/api_datasource.dart';
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
          child: (_, __) => TaskGetScreen(),
        ),
      ];
}
