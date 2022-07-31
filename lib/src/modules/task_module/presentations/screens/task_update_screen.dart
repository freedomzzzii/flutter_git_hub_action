import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/l10n/app_localizations.dart';
import '../../../../core/navigation/navigation_core.dart';
import '../../../../utils/image_picker/image_picker_util.dart';
import '../../../app_module.dart';
import '../../applications/controllers/task_detail_controller.dart';
import '../../applications/controllers/task_get_controller.dart';
import '../../applications/controllers/task_update_controller.dart';
import '../../applications/models/task_status_view_model.dart';
import '../../applications/models/task_update_view_model.dart';
import '../../configs/routes/route_config.dart';
import '../../configs/widget_key/widget_key_config.dart';
import '../widgets/bottom_menu_bar_widget.dart';

class TaskUpdateScreen extends StatelessWidget {
  TaskUpdateScreen({required ImagePickerUtil imagePickerUtil, Key? key})
      : _imagePickerUtil = imagePickerUtil,
        super(key: key);

  final TaskDetailController _detailController =
      Get.find<TaskDetailController>();
  final TaskUpdateController _updateController =
      Get.find<TaskUpdateController>();
  final TaskGetController _getController = Get.find<TaskGetController>();
  final TextEditingController editTitleController = TextEditingController();
  final ImagePickerUtil _imagePickerUtil;

  Future<void> _selectImage() async {
    try {
      final String? getBase64Image = await _imagePickerUtil.getBase64Image();

      if (getBase64Image != null) {
        _detailController.selectTaskToUpdate(
          task: TaskUpdateControllerModel(
            id: _detailController.task.id,
            title: editTitleController.text,
            isDone: _detailController.task.isDone,
            imageUrl: getBase64Image,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          key: const Key(snackBarUpdateFailureWidgetKey),
          content: Text(
            AppLocalizations.of(Get.context!).selectImageFail,
          ),
        ),
      );
    }
  }

  Future<void> _updateTask() async {
    _updateController.updateTask(
      task: TaskUpdateBodyRequestControllerModel(
        title: editTitleController.text,
        imageUrl: _detailController.task.imageUrl,
      ),
      queryParams: TaskUpdateQueryParamsRequestControllerModel(
        id: _detailController.task.id,
      ),
    );

    if (_updateController.status == TaskStatusViewModel.failure) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          key: const Key(snackBarUpdateFailureWidgetKey),
          content: Text(
            AppLocalizations.of(Get.context!).failToUpdate,
          ),
        ),
      );
      return;
    }

    await _getController.getTasks(requestBody: _getController.query);

    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        key: const Key(snackBarUpdateSuccessWidgetKey),
        content: Text(
          AppLocalizations.of(Get.context!).successSnackBar,
        ),
      ),
    );

    navigationGetX.replace(taskModule.getFullPath(subPath: taskListEditPath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).updateTaskAppBar,
        ),
      ),
      body: GetBuilder<TaskDetailController>(
        init: _detailController,
        builder: (_) {
          final String imageUrl = _detailController.task.imageUrl;
          editTitleController.text = _detailController.task.title;
          final Uint8List bytes = const Base64Codec().decode(imageUrl);

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  key: const Key(textFieldUpdateWidgetKey),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).textFieldPlaceHolder,
                    border: const OutlineInputBorder(),
                  ),
                  controller: editTitleController,
                ),
                const SizedBox(height: 20),
                Image.memory(
                  bytes,
                  key: const Key(imageUpdateWidgetKey),
                  fit: BoxFit.cover,
                  cacheHeight: 300,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  key: const Key(buttonSelectUpdateImageWidgetKey),
                  onPressed: () => _selectImage(),
                  child: Text(
                    AppLocalizations.of(context).selectImage,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  key: const Key(saveUpdateButtonWidgetKey),
                  onPressed: () {
                    if (editTitleController.text.isNotEmpty) {
                      _updateTask();
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context).saveUpdateTaskBtn,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomMenuBarWidget(
        currentTabIndex: 1,
      ),
    );
  }
}
