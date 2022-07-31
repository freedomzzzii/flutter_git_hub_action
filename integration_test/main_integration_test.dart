import 'package:flutter_starter_kit/src/modules/task_module/task_impl_usecase.dart';
import 'package:flutter_starter_kit/src/utils/image_picker/image_picker_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';

import 'main_integration_test.mocks.dart';
import 'screens/task_create_screen_test.dart' as create_task_screen_test;
import 'screens/task_list_edit_screen_test.dart' as get_task_screen_test;
import 'screens/task_update_screen_test.dart' as update_task_screen_test;

@GenerateMocks(<Type>[ImagePickerUtil, TaskImplUseCase])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final MockImagePickerUtil mockImagePickerUtil = MockImagePickerUtil();

  group('Update task screen integration test', () {
    update_task_screen_test.screenTest(
      mockImagePickerUtil,
    );
  });

  group('Create task screen integration test', () {
    create_task_screen_test.screenTest(
      mockImagePickerUtil,
    );
  });

  group('Get task screen integration test', () {
    get_task_screen_test.screenTest();
  });
}
