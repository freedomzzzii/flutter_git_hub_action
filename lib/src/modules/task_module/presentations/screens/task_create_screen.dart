import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/l10n/app_localizations.dart';
import '../../../../core/navigation/navigation_core.dart';
import '../../../../utils/image_picker/image_picker_util.dart';
import '../../../app_module.dart';
import '../../applications/controllers/task_create_controller.dart';
import '../../applications/models/task_create_view_model.dart';
import '../../applications/models/task_status_view_model.dart';
import '../../configs/routes/route_config.dart';
import '../../configs/widget_key/widget_key_config.dart';
import '../widgets/bottom_menu_bar_widget.dart';

class TaskCreateScreen extends StatelessWidget {
  TaskCreateScreen({required ImagePickerUtil imagePickerUtil, Key? key})
      : _imagePickerUtil = imagePickerUtil,
        super(key: key);

  final ImagePickerUtil _imagePickerUtil;
  final TaskCreateController _createController =
      Get.find<TaskCreateController>();
  final TextEditingController _titleTextController = TextEditingController();

  Future<void> _selectImage() async {
    try {
      if (_titleTextController.text.isNotEmpty) {
        final String? base64Image = await _imagePickerUtil.getBase64Image();

        if (base64Image != null) {
          await _createController.createTask(
            task: TaskCreateRequestControllerModel(
              title: _titleTextController.text,
              imageUrl: base64Image,
            ),
          );

          if (_createController.status == TaskStatusViewModel.success) {
            ScaffoldMessenger.of(Get.context!).showSnackBar(
              SnackBar(
                key: const Key(snackBarSuccessWidgetKey),
                content:
                    Text(AppLocalizations.of(Get.context!).successSnackBar),
              ),
            );

            navigationGetX
                .replace(taskModule.getFullPath(subPath: taskListEditPath));
            return;
          }

          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              key: const Key(snackBarFailureWidgetKey),
              content: Text(AppLocalizations.of(Get.context!).failureSnackBar),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          key: const Key(snackBarFailureWidgetKey),
          content: Text(AppLocalizations.of(Get.context!).failureSnackBar),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key(appBarTitleWidgetKey),
        title: Text(AppLocalizations.of(context).appBarTaskGet),
      ),
      body: GetBuilder<TaskCreateController>(
        init: _createController,
        builder: (_) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                key: const Key(titleTextFieldWidgetKey),
                controller: _titleTextController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).textFieldPlaceHolder,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  key: const Key(buttonSelectImageWidgetKey),
                  onPressed: () => _selectImage(),
                  child: Text(
                    AppLocalizations.of(context).selectImage,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomMenuBarWidget(
        currentTabIndex: 0,
      ),
    );
  }
}
