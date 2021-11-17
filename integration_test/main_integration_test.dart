import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poc_clean_arch/src/configs/routes/route_config.dart';
import 'package:poc_clean_arch/src/helpers/image_picker/image_picker_helper.dart';
import 'package:poc_clean_arch/src/modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';
import 'package:poc_clean_arch/src/modules/todo_module/todo_module.dart';

import 'main_integration_test.mocks.dart';
import 'task_create_screen_test.dart' as create_task_screen;
import 'task_get_screen_test.dart' as get_task_screen;
import 'task_update_screen_test.dart' as update_task_screen;

@GenerateMocks(<Type>[TaskBloc, ImagePickerUtil, IModularNavigator])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final MockTaskBloc bloc = MockTaskBloc();
  final MockImagePickerUtil mockSelectImage = MockImagePickerUtil();

  setUp(() {
    initModule(
      TodoModule(),
      replaceBinds: <Bind<Object>>[
        Bind<Object>((_) => bloc),
      ],
    );

    Modular.navigatorDelegate = MockIModularNavigator();

    when(Modular.to.pushNamed(initialRoute))
        .thenAnswer((_) => Future<void>.value());
  });

  tearDown(() {
    Modular.dispose();
  });

  group('create task screen test', () {
    create_task_screen.screenTest(bloc, mockSelectImage);
  });

  group('update task screen test', () {
    update_task_screen.screenTest(bloc, mockSelectImage);
  });

  group('get task screen test', () {
    get_task_screen.screenTest(bloc);
  });
}
