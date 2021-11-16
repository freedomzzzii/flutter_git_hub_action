import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_starter_kit/src/configs/routes/route_config.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/todo_module.dart';
import 'package:flutter_starter_kit/src/utils/image_picker/image_picker_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'main_integration_test.mocks.dart';
import 'screens/task_create_screen_test.dart' as create_task_screen_test;
import 'screens/task_get_screen_test.dart' as get_task_screen_test;
import 'screens/task_update_screen_test.dart' as update_task_screen_test;

@GenerateMocks(<Type>[TaskBloc, ImagePickerUtil, IModularNavigator])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final MockTaskBloc mockBloc = MockTaskBloc();
  final MockImagePickerUtil mockImagePickerUtil = MockImagePickerUtil();

  setUp(() {
    initModule(
      TodoModule(),
      replaceBinds: <Bind<Object>>[
        Bind<Object>((_) => mockBloc),
      ],
    );

    Modular.navigatorDelegate = MockIModularNavigator();

    when(Modular.to.pushNamed(initialRoute))
        .thenAnswer((_) => Future<void>.value());
  });

  tearDown(() {
    Modular.dispose();
  });

  group('Create task screen integration test', () {
    create_task_screen_test.screenTest(mockBloc, mockImagePickerUtil);
  });

  group('Update task screen integration test', () {
    update_task_screen_test.screenTest(mockBloc, mockImagePickerUtil);
  });

  group('Get task screen integration test', () {
    get_task_screen_test.screenTest(mockBloc);
  });
}
