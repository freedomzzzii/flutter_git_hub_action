import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/l10n/app_localizations.dart';
import '../../../../core/navigation/navigation_core.dart';
import '../../../app_module.dart';
import '../../applications/controllers/task_delete_controller.dart';
import '../../applications/controllers/task_detail_controller.dart';
import '../../applications/controllers/task_get_controller.dart';
import '../../applications/controllers/task_update_controller.dart';
import '../../applications/models/task_delete_view_model.dart';
import '../../applications/models/task_get_view_model.dart';
import '../../applications/models/task_status_view_model.dart';
import '../../applications/models/task_update_view_model.dart';
import '../../configs/routes/route_config.dart';
import '../../configs/widget_key/widget_key_config.dart';
import '../../services/commons/request_query.dart';
import '../widgets/bottom_menu_bar_widget.dart';

class TaskListEditScreen extends StatelessWidget {
  TaskListEditScreen({Key? key}) : super(key: key);

  final TaskGetController _getController = Get.find<TaskGetController>();
  final TaskDetailController _detailController =
      Get.find<TaskDetailController>();
  final TaskUpdateController _updateController =
      Get.find<TaskUpdateController>();
  final TaskDeleteController _deleteController =
      Get.find<TaskDeleteController>();

  Widget _taskList() {
    if (_getController.status == TaskStatusViewModel.success) {
      if (_getController.tasks.isEmpty) {
        return Center(
          key: const Key(dataEmptyTaskGetWidgetKey),
          child: Text(AppLocalizations.of(Get.context!).dataEmptyTaskGet),
        );
      }

      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton<String>(
                key: const Key(sortByDropdownWidgetKey),
                value: _getController.query.sortBy,
                icon: const Icon(Icons.arrow_downward),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _getController.getTasks(
                      requestBody: TaskGetRequestControllerModel(
                        sortBy: newValue,
                        orderBy: _getController.query.orderBy,
                      ),
                    );
                  }
                },
                items: sortByQueryList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    key: Key('${sortByDropdownWidgetKey}_$value'),
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(width: 50),
              DropdownButton<String>(
                key: const Key(orderByDropdownWidgetKey),
                value: _getController.query.orderBy,
                icon: const Icon(Icons.arrow_downward),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _getController.getTasks(
                      requestBody: TaskGetRequestControllerModel(
                        sortBy: _getController.query.sortBy,
                        orderBy: newValue,
                      ),
                    );
                  }
                },
                items: orderByQueryList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    key: Key('${orderByDropdownWidgetKey}_$value'),
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Image.memory(
                          const Base64Codec()
                              .decode(_getController.tasks[index].imageUrl),
                          key: Key('$imageTaskGetWidgetKey$index'),
                          fit: BoxFit.cover,
                          cacheHeight: 400,
                          cacheWidth: 400,
                        ),
                        title: Text(
                          _getController.tasks[index].title,
                          key: Key('$titleTaskGetWidgetKey$index'),
                        ),
                        subtitle: Text(
                          'Status: ${_getController.tasks[index].isDone}',
                          key: Key('$isDoneTaskGetWidgetKey$index'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              key: Key('$isDoneBtnTaskGetWidgetKey$index'),
                              child: Icon(
                                _getController.tasks[index].isDone
                                    ? Icons.check_circle_outline
                                    : Icons.radio_button_unchecked,
                              ),
                              onTap: () => _updateIsDoneStatus(
                                _getController.tasks[index],
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              key: Key('$updateBtnTaskGetWidgetKey$index'),
                              child: const Icon(
                                Icons.edit,
                              ),
                              onTap: () => _navigateToUpdateTasksScreenWidget(
                                _getController.tasks[index],
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              key: Key('$deleteBtnTaskGetWidgetKey$index'),
                              child: const Icon(
                                Icons.delete,
                              ),
                              onTap: () =>
                                  _deleteTask(_getController.tasks[index].id),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: _getController.tasks.length,
            ),
          ),
        ],
      );
    } else if (_getController.status == TaskStatusViewModel.initial ||
        _getController.status == TaskStatusViewModel.loading) {
      return Center(
        key: const Key(loadDataTaskGetWidgetKey),
        child: Text(AppLocalizations.of(Get.context!).loadDataTaskGet),
      );
    }

    return Center(
      key: const Key(oopsErrorTaskGetWidgetKey),
      child: Text(AppLocalizations.of(Get.context!).oopsErrorTaskGet),
    );
  }

  void _navigateToUpdateTasksScreenWidget(
    TaskGetResponseControllerModel model,
  ) {
    _detailController.selectTaskToUpdate(
      task: TaskUpdateControllerModel(
        id: model.id,
        title: model.title,
        isDone: model.isDone,
        imageUrl: model.imageUrl,
      ),
    );

    navigationGetX
        .push(taskModule.getFullPath(subPath: taskUpdatePath));
  }

  Future<void> _updateIsDoneStatus(TaskGetResponseControllerModel model) async {
    await _updateController.updateTask(
      task: TaskUpdateBodyRequestControllerModel(isDone: !model.isDone),
      queryParams: TaskUpdateQueryParamsRequestControllerModel(id: model.id),
    );

    if (_updateController.status != TaskStatusViewModel.success) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          key: const Key(snackBarFailureWidgetKey),
          content: Text(AppLocalizations.of(Get.context!).failureSnackBar),
        ),
      );
      return;
    }

    await _getController.getTasks(requestBody: _getController.query);
  }

  Future<void> _deleteTask(String id) async {
    await _deleteController.deleteTask(
      queryParams: TaskDeleteQueryParamsRequestControllerModel(id: id),
    );

    if (_deleteController.status != TaskStatusViewModel.success) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          key: const Key(snackBarFailureWidgetKey),
          content: Text(AppLocalizations.of(Get.context!).failureSnackBar),
        ),
      );
      return;
    }

    await _getController.getTasks(requestBody: _getController.query);
  }

  Widget _widgetListTask() {
    if (_getController.status == TaskStatusViewModel.initial) {
      _getController.getTasks(
        requestBody: const TaskGetRequestControllerModel(
          sortBy: createdAtQueryValue,
          orderBy: descQueryValue,
        ),
      );
    }

    return _taskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key(appBarTitleWidgetKey),
        title: Text(AppLocalizations.of(context).appBarTaskGet),
      ),
      body: GetBuilder<TaskGetController>(
        init: _getController,
        builder: (_) => _widgetListTask(),
      ),
      bottomNavigationBar: const BottomMenuBarWidget(
        currentTabIndex: 1,
      ),
    );
  }
}
