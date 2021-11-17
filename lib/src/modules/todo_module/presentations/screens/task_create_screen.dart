import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../configs/l10n/app_localizations.dart';
import '../../../../configs/routes/route_config.dart';
import '../../../../utils/image_picker/image_picker_util.dart';
import '../../applications/bloc/task_bloc/task_bloc.dart';
import '../../applications/models/task_bloc_models/task_create_bloc_model.dart';
import '../../configs/widget_key/widget_key_config.dart';
import '../widgets/bottom_menu_bar_widget.dart';

class TaskCreateScreenWidget extends StatelessWidget {
  TaskCreateScreenWidget({required ImagePickerUtil imagePickerUtil, Key? key})
      : _imagePickerUtil = imagePickerUtil,
        super(key: key);

  final ImagePickerUtil _imagePickerUtil;
  final TaskBloc _bloc = Modular.get<TaskBloc>();
  final TextEditingController _titleTextController = TextEditingController();

  Future<void> _selectImage(BuildContext context) async {
    try {
      if (_titleTextController.text.isNotEmpty) {
        final String? base64Image = await _imagePickerUtil.getBase64Image();

        if (base64Image != null) {
          _bloc.add(
            TaskCreatedEvent(
              model: TaskCreateRequestBlocModel(
                title: _titleTextController.text,
                imageUrl: base64Image,
              ),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          key: const Key(snackBarFailureWidgetKey),
          content: Text(AppLocalizations.of(context).failureSnackBar),
        ),
      );
    }
  }

  void _navigateToListTasksScreenWidget(BuildContext context) {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          key: const Key(snackBarSuccessWidgetKey),
          content: Text(AppLocalizations.of(context).successSnackBar),
        ),
      );

      Modular.to.pushNamed(initialRoute);
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
              listener: (BuildContext context, TaskState state) {
                if (state is TaskCreateState &&
                    state.status == taskStatusState.success) {
                  _navigateToListTasksScreenWidget(context);
                } else if (state is TaskCreateState &&
                    state.status == taskStatusState.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      key: const Key(snackBarSuccessWidgetKey),
                      content:
                          Text(AppLocalizations.of(context).failureSnackBar),
                    ),
                  );
                }
              },
              builder: (BuildContext context, TaskState state) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        key: const Key(titleTextFieldWidgetKey),
                        controller: _titleTextController,
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context).textFieldPlaceHolder,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          key: const Key(buttonSelectImageWidgetKey),
                          onPressed: () => _selectImage(context),
                          child: Text(
                            AppLocalizations.of(context).selectImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomMenuBarWidget(
        currentTabIndex: 0,
      ),
    );
  }
}
