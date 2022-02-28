import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_starter_kit/src/configs/l10n/app_localizations.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/models/task_bloc_models/task_get_bloc_model.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/configs/widget_key/widget_key_config.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/presentations/widgets/bottom_menu_bar_widget.dart';

class TaskGetWebSocketScreenWidget extends StatelessWidget {
  TaskGetWebSocketScreenWidget({Key? key}) : super(key: key) {
    _closDuplicateChannel();
  }

  final TaskBloc _bloc = Modular.get<TaskBloc>();

  void _closDuplicateChannel() {
    _bloc.add(TaskDisconnectStreamGetEvent());
  }

  Widget _taskList(BuildContext context, dynamic state) {
    if (state is TaskStreamSubscriptionState &&
        state.status == taskStatusState.success) {
      if (state.channel != null) {
        _bloc.add(TaskRefreshStreamGetEvent());
      }
    }
    if (state is TaskStreamGetState &&
        state.status == taskStatusState.success) {
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
    } else if (state is taskStatusState) {
      return Center(
        key: const Key(loadDataTaskGetWidgetKey),
        child: Text(AppLocalizations.of(context).loadDataTaskGet),
      );
    } else {
      return const Text('No Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _closDuplicateChannel();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Web Socket'),
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
          currentTabIndex: 5,
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                _bloc.add(TaskStreamSubscriptionEvent());
              },
              key: const Key(connectButtonWidgetKey),
              heroTag: 'connect btn',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                _bloc.add(TaskRefreshStreamGetEvent());
              },
              key: const Key(addEventButtonWidgetKey),
              heroTag: 'add message btn',
              child: const Icon(Icons.refresh),
            ),
            FloatingActionButton(
              onPressed: () {
                _bloc.add(TaskDisconnectStreamGetEvent());
              },
              // key: const Key(addEventButtonWidgetKey),
              heroTag: 'disconnect websocket',
              child: const Icon(Icons.highlight_remove),
            ),
          ],
        ),
      ),
    );
  }
}
