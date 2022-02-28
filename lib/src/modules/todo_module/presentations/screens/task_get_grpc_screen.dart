import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/l10n/app_localizations.dart';
import '../../applications/bloc/task_bloc/task_bloc.dart';
import '../../applications/models/task_bloc_models/task_get_bloc_model.dart';
import '../../configs/widget_key/widget_key_config.dart';
import '../../services/commons/request_query.dart';
import '../widgets/bottom_menu_bar_widget.dart';

class TaskGetGrpcScreen extends StatelessWidget {
  const TaskGetGrpcScreen({required TaskBloc bloc, Key? key})
      : _bloc = bloc,
        super(key: key);

  final TaskBloc _bloc;

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
                      ],
                    ),
                  );
                },
                itemCount: state.data?.length,
              ),
            ),
          ],
        );
      } else if (state is TaskInitialState) {
        _getListTask(context);
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

  void _getListTask(BuildContext context) {
    _bloc.add(
      const TaskGotEvent(
        model: TaskGetRequestBlocModel(
          sortBy: createdAtQueryValue,
          orderBy: descQueryValue,
        ),
      ),
    );
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
            return BlocBuilder<TaskBloc, TaskState>(
              builder: (BuildContext context, TaskState state) {
                return _taskList(context, state);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomMenuBarWidget(
        currentTabIndex: 3,
      ),
    );
  }
}
