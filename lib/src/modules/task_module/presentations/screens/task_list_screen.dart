import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/l10n/app_localizations.dart';
import '../../applications/controllers/task_get_controller.dart';
import '../../applications/models/task_get_view_model.dart';
import '../../applications/models/task_status_view_model.dart';
import '../../configs/widget_key/widget_key_config.dart';
import '../../services/commons/request_query.dart';
import '../widgets/bottom_menu_bar_widget.dart';

class TaskListScreen extends StatelessWidget {
  TaskListScreen({Key? key}) : super(key: key);

  final TaskGetController _getController =
      Get.find<TaskGetController>(tag: 'grpcDatasource');


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
        tag: 'grpcDatasource',
      ),
      bottomNavigationBar: const BottomMenuBarWidget(
        currentTabIndex: 2,
      ),
    );
  }
}
