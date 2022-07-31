import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/task_update_view_model.dart';

class TaskDetailController extends GetxController {
  late TaskUpdateControllerModel _task;

  TaskUpdateControllerModel get task => _task;

  void selectTaskToUpdate({
    required TaskUpdateControllerModel task,
  }) {
    _task = task;

    update();
  }
}
