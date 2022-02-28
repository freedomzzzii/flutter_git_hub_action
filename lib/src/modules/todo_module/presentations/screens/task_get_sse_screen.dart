import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/l10n/app_localizations.dart';
import '../../applications/bloc/task_sse_bloc/task_sse_bloc.dart';
import '../../applications/models/task_bloc_models/task_get_bloc_model.dart';
import '../../configs/widget_key/widget_key_config.dart';
import '../widgets/bottom_menu_bar_widget.dart';

class TaskGetSseScreen extends StatelessWidget {
  const TaskGetSseScreen({
    required TaskSseBloc bloc,
    Key? key,
  })  : _bloc = bloc,
        super(key: key);

  final TaskSseBloc _bloc;

  Widget _taskList(BuildContext context, dynamic state) {
    if (state is TaskSseGetTaskState &&
        state.status == taskSseStatusState.success) {
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
    } else if (state is TaskSseGetTaskState &&
        state.status == taskSseStatusState.failure) {
      return Center(
        key: const Key(oopsErrorTaskGetWidgetKey),
        child: Text(AppLocalizations.of(context).oopsErrorTaskGet),
      );
    }  else if (state.status == taskSseStatusState.failure) {
      return Center(
        key: const Key(oopsErrorTaskGetWidgetKey),
        child: Text(AppLocalizations.of(context).oopsErrorTaskGet),
      );
    }

    return Center(
      key: const Key(loadDataTaskGetWidgetKey),
      child: Text(AppLocalizations.of(context).loadDataTaskGet),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key(appBarTitleWidgetKey),
        title: Text(AppLocalizations.of(context).appBarTaskGet),
      ),
      body: BlocProvider<TaskSseBloc>(
        create: (BuildContext context) => _bloc,
        child: Builder(
          builder: (BuildContext context) {
            return BlocBuilder<TaskSseBloc, TaskSseState>(
              builder: (BuildContext context, TaskSseState state) {
                return _taskList(context, state);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomMenuBarWidget(
        currentTabIndex: 4,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <FloatingActionButton>[
          FloatingActionButton(
            onPressed: () {
              _bloc.add(TaskConnectedGetTaskEvent());
            },
            key: const Key(sseConnectButtonWidgetKey),
            heroTag: sseConnectButtonWidgetKey,
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              _bloc.add(TaskClosedConnectionEvent());
            },
            key: const Key(sseCloseConnectButtonWidgetKey),
            heroTag: sseCloseConnectButtonWidgetKey,
            child: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
