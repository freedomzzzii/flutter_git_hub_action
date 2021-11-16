import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../configs/l10n/app_localizations.dart';
import '../../applications/bloc/task_bloc/task_bloc.dart';
import '../../applications/models/task_bloc_models/task_get_bloc_model.dart';
import '../../configs/widget_key/widget_key_config.dart';
import '../../services/commons/request_query.dart';
import '../widgets/bottom_menu_bar_widget.dart';

class TaskGetScreen extends StatelessWidget {
  TaskGetScreen({Key? key}) : super(key: key);

  final TaskBloc _bloc = Modular.get<TaskBloc>();

  Widget _taskList(BuildContext context, TaskState state) {
    try {
      if (state is TaskGetState && state.status == taskStatusState.success) {
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
          ],
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
                // do something from event state
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
