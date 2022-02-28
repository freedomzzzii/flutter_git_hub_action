import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../configs/l10n/app_localizations.dart';
import '../../../../configs/routes/route_config.dart';
import '../../applications/bloc/task_bloc/task_bloc.dart';
import '../../applications/models/task_bloc_models/task_delete_bloc_model.dart';
import '../../applications/models/task_bloc_models/task_get_bloc_model.dart';
import '../../applications/models/task_bloc_models/task_update_bloc_model.dart';
import '../../configs/widget_key/widget_key_config.dart';
import '../../services/commons/request_query.dart';
import '../widgets/bottom_menu_bar_widget.dart';

class TaskGetScreen extends StatelessWidget {
  TaskGetScreen({Key? key}) : super(key: key);

  final TaskBloc _bloc = Modular.get<TaskBloc>();

  Widget _taskList(BuildContext context, TaskState state) {
    try {
      if (state is TaskGetState && state.status == taskStatusState.success) {
        if (state.data == null || state.data!.isEmpty) {
          return Center(
            key: const Key(dataEmptyTaskGetWidgetKey),
            child: Text(AppLocalizations.of(context).dataEmptyTaskGet),
          );
        }
        final List<TaskGetResponseBlocModel> data = state.data!;

        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton<String>(
                  key: const Key(sortByDropdownWidgetKey),
                  value: state.query.sortBy,
                  icon: const Icon(Icons.arrow_downward),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _bloc.add(
                        TaskGotEvent(
                          model: TaskGetRequestBlocModel(
                            sortBy: newValue,
                            orderBy: state.query.orderBy,
                          ),
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
                  value: state.query.orderBy,
                  icon: const Icon(Icons.arrow_downward),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _bloc.add(
                        TaskGotEvent(
                          model: TaskGetRequestBlocModel(
                            sortBy: state.query.sortBy,
                            orderBy: newValue,
                          ),
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
                            const Base64Codec().decode(data[index].imageUrl),
                            key: Key('$imageTaskGetWidgetKey$index'),
                            fit: BoxFit.cover,
                            cacheHeight: 400,
                            cacheWidth: 400,
                          ),
                          title: Text(
                            data[index].title,
                            key: Key('$titleTaskGetWidgetKey$index'),
                          ),
                          subtitle: Text(
                            'Status: ${data[index].isDone}',
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
                                  data[index].isDone
                                      ? Icons.check_circle_outline
                                      : Icons.radio_button_unchecked,
                                ),
                                onTap: () =>
                                    _updateIsDoneStatus(context, data[index]),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                key: Key('$updateBtnTaskGetWidgetKey$index'),
                                child: const Icon(
                                  Icons.edit,
                                ),
                                onTap: () => _navigateToUpdateTasksScreenWidget(
                                  context,
                                  data[index],
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                key: Key('$deleteBtnTaskGetWidgetKey$index'),
                                child: const Icon(
                                  Icons.delete,
                                ),
                                onTap: () =>
                                    _deleteTask(context, data[index].id),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: state.data?.length,
              ),
            ),
          ],
        );
      } else if (state is TaskInitialState ||
          (state is TaskUpdateState &&
              state.status == taskStatusState.success) ||
          (state is TaskDeleteState &&
              state.status == taskStatusState.success) ||
          (state is TaskCreateState &&
              state.status == taskStatusState.success)) {
        _getListTask(context);
        return Center(
          key: const Key(loadDataTaskGetWidgetKey),
          child: Text(AppLocalizations.of(context).loadDataTaskGet),
        );
      } else if ((state is TaskUpdateState &&
              (state.status != taskStatusState.failure &&
                  state.status != taskStatusState.success)) ||
          state is TaskDeleteState &&
              (state.status != taskStatusState.failure &&
                  state.status != taskStatusState.success) ||
          state is TaskCreateState &&
              (state.status != taskStatusState.failure &&
                  state.status != taskStatusState.success)) {
        return Center(
          key: const Key(loadDataTaskGetWidgetKey),
          child: Text(AppLocalizations.of(context).loadDataTaskGet),
        );
      }

      return Center(
        key: const Key(oopsErrorTaskGetWidgetKey),
        child: Text(AppLocalizations.of(context).oopsErrorTaskGet),
      );
    } catch (e) {
      return Center(
        key: const Key(oopsErrorTaskGetWidgetKey),
        child: Text(AppLocalizations.of(context).oopsErrorTaskGet),
      );
    }
  }

  void _navigateToUpdateTasksScreenWidget(
    BuildContext context,
    TaskGetResponseBlocModel model,
  ) {
    try {
      _bloc.add(
        TaskSelectedToUpdatedEvent(
          model: TaskUpdateBlocModel(
            id: model.id,
            title: model.title,
            isDone: model.isDone,
            imageUrl: model.imageUrl,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          key: const Key(snackBarFailureWidgetKey),
          content: Text(AppLocalizations.of(context).failureSnackBar),
        ),
      );
    }
  }

  void _updateIsDoneStatus(
    BuildContext context,
    TaskGetResponseBlocModel model,
  ) {
    try {
      _bloc.add(
        TaskUpdatedEvent(
          model: TaskUpdateBodyRequestBlocModel(isDone: !model.isDone),
          queryParams: TaskUpdateQueryParamsRequestBlocModel(id: model.id),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          key: const Key(snackBarFailureWidgetKey),
          content: Text(AppLocalizations.of(context).failureSnackBar),
        ),
      );
    }
  }

  void _deleteTask(BuildContext context, String id) {
    try {
      _bloc.add(
        TaskDeletedEvent(
          queryParams: TaskDeleteQueryParamsRequestBlocModel(id: id),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          key: const Key(snackBarFailureWidgetKey),
          content: Text(AppLocalizations.of(context).failureSnackBar),
        ),
      );
    }
  }

  void _getListTask(BuildContext context) {
    try {
      _bloc.add(
        const TaskGotEvent(
          model: TaskGetRequestBlocModel(
            sortBy: createdAtQueryValue,
            orderBy: descQueryValue,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          key: const Key(snackBarFailureWidgetKey),
          content: Text(AppLocalizations.of(context).failureSnackBar),
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
      body: BlocProvider<TaskBloc>(
        create: (BuildContext context) => _bloc,
        child: Builder(
          builder: (BuildContext context) {
            return BlocConsumer<TaskBloc, TaskState>(
              builder: (BuildContext context, TaskState state) {
                return _taskList(context, state);
              },
              listener: (BuildContext context, TaskState state) {
                if (state is TaskUpdateState && state.data != null) {
                  Modular.to.pushNamed(updateTaskRoute);
                } else if (state is TaskDeleteState &&
                    state.status == taskStatusState.success) {
                  _getListTask(context);
                } else if (state is TaskUpdateState &&
                    state.status == taskStatusState.success) {
                  _getListTask(context);
                }
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomMenuBarWidget(
        currentTabIndex: 1,
      ),
    );
  }
}
