import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../configs/l10n/app_localizations.dart';
import '../../../../configs/routes/route_config.dart';
import '../../../../utils/image_picker/image_picker_util.dart';
import '../../applications/bloc/task_bloc/task_bloc.dart';
import '../../applications/models/task_bloc_models/task_update_bloc_model.dart';
import '../../configs/widget_key/widget_key_config.dart';
import '../widgets/bottom_menu_bar_widget.dart';

class TaskUpdateScreen extends StatelessWidget {
  TaskUpdateScreen({required ImagePickerUtil imagePickerUtil, Key? key})
      : _imagePickerUtil = imagePickerUtil,
        super(key: key);

  final TaskBloc _bloc = Modular.get<TaskBloc>();
  final TextEditingController editTitleController = TextEditingController();
  final ImagePickerUtil _imagePickerUtil;

  Future<void> _selectImage(TaskState state, BuildContext context) async {
    try {
      final String? getBase64Image = await _imagePickerUtil.getBase64Image();

      if (getBase64Image != null && state is TaskUpdateState) {
        _bloc.add(
          TaskSelectedToUpdatedEvent(
            model: TaskUpdateBlocModel(
              id: state.data?.id ?? '',
              title: editTitleController.text,
              isDone: state.data?.isDone ?? false,
              imageUrl: getBase64Image,
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          key: const Key(snackBarUpdateFailureWidgetKey),
          content: Text(AppLocalizations.of(context).selectImageFail),
        ),
      );
    }
  }

  void _updateTask(TaskState state, BuildContext context) {
    try {
      if (state is TaskUpdateState) {
        final String? id = state.data?.id;
        if (id != null && id.isNotEmpty) {
          _bloc.add(
            TaskUpdatedEvent(
              model: TaskUpdateBodyRequestBlocModel(
                title: editTitleController.text,
                imageUrl: state.data?.imageUrl,
              ),
              queryParams: TaskUpdateQueryParamsRequestBlocModel(id: id),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          key: const Key(snackBarUpdateFailureWidgetKey),
          content: Text(AppLocalizations.of(context).failToUpdate),
        ),
      );
    }
  }

  void _navigateToListTasksScreen(BuildContext context) {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          key: const Key(snackBarUpdateSuccessWidgetKey),
          content: Text(AppLocalizations.of(context).successSnackBar),
        ),
      );
      Modular.to.pushNamed(initialRoute);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          key: const Key(snackBarUpdateFailureWidgetKey),
          content: Text(AppLocalizations.of(context).failToNavigate),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).updateTaskAppBar),
      ),
      body: BlocProvider<TaskBloc>(
        create: (BuildContext context) => _bloc,
        child: Builder(
          builder: (BuildContext context) {
            return BlocConsumer<TaskBloc, TaskState>(
              listener: (BuildContext context, TaskState state) {
                if (state is TaskUpdateState &&
                    state.status == taskStatusState.success) {
                  _navigateToListTasksScreen(context);
                }
              },
              builder: (BuildContext context, TaskState state) {
                final String imageUrl =
                    state is TaskUpdateState ? state.data?.imageUrl ?? '' : '';
                if (state is TaskUpdateState) {
                  editTitleController.text = state.data?.title ?? '';
                }
                final Uint8List bytes = const Base64Codec().decode(imageUrl);
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        key: const Key(textFieldUpdateWidgetKey),
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context).textFieldPlaceHolder,
                          border: const OutlineInputBorder(),
                        ),
                        controller: editTitleController,
                      ),
                      const SizedBox(height: 20),
                      if (bytes.isNotEmpty)
                        Image.memory(
                          bytes,
                          key: const Key(imageUpdateWidgetKey),
                          fit: BoxFit.cover,
                          cacheHeight: 300,
                        )
                      else
                        Text(AppLocalizations.of(context).noUpdateImage),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        key: const Key(buttonSelectUpdateImageWidgetKey),
                        onPressed: () => _selectImage(state, context),
                        child: Text(
                          AppLocalizations.of(context).selectImage,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        key: const Key(saveUpdateButtonWidgetKey),
                        onPressed: () {
                          if (editTitleController.text.isNotEmpty) {
                            _updateTask(state, context);
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context).saveUpdateTaskBtn,
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomMenuBarWidget(
        currentTabIndex: 2,
      ),
    );
  }
}
