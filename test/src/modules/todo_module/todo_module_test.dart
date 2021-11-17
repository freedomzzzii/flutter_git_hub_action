import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poc_clean_arch/src/configs/routes/route_config.dart';
import 'package:poc_clean_arch/src/modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';
import 'package:poc_clean_arch/src/modules/todo_module/presentations/screens/task_create_screen.dart';
import 'package:poc_clean_arch/src/modules/todo_module/presentations/screens/task_get_screen.dart';
import 'package:poc_clean_arch/src/modules/todo_module/presentations/screens/task_update_screen.dart';
import 'package:poc_clean_arch/src/modules/todo_module/todo_module.dart';

import '../../helpers/image_picker/image_picker_util_test.mocks.dart';

void main() {
  final TodoModule expectTodoModule = TodoModule();
  final List<Type> expectBinds = <Type>[TaskBloc];

  group('TodoModule Class', () {
    test('Should have TodoModule Class', () {
      expect(TodoModule, TodoModule);
    });

    test('Should have method get binds', () {
      for (final Type element in expectBinds) {
        expect(
          expectTodoModule.getBind(typesInRequest: <Type>[element]).runtimeType,
          element,
        );
      }
      expect(expectTodoModule.binds.length, 1);
    });

    test('Should have method get binds', () {
      for (final Type element in expectBinds) {
        expect(
          expectTodoModule.getBind(typesInRequest: <Type>[element]).runtimeType,
          element,
        );
      }
      expect(expectTodoModule.binds.length, 1);
    });

    test('Should have method get routes', () {
      final List<String> expectPath = <String>[
        initialRoute,
        createTaskRoute,
        updateTaskRoute
      ];
      final List<
          StatelessWidget Function(
        BuildContext context,
        ModularArguments arg,
      )> expectChild = <
          StatelessWidget Function(
        BuildContext context,
        ModularArguments arg,
      )>[
        (BuildContext context, ModularArguments arg) => TaskGetScreenWidget(),
        (BuildContext context, ModularArguments arg) =>
            TaskCreateScreenWidget(imagePickerUtil: MockImagePickerUtil()),
        (BuildContext context, ModularArguments arg) =>
            TaskUpdateScreenWidget(imagePickerUtil: MockImagePickerUtil()),
      ];

      for (final ModularRoute<dynamic> value in expectTodoModule.routes) {
        expect(expectPath.contains(value.path), true);
        expect(
          expectChild.indexWhere(
                (
                  StatelessWidget Function(
                    BuildContext context,
                    ModularArguments arg,
                  )
                      element,
                ) =>
                    element.runtimeType == value.child.runtimeType,
              ) >
              -1,
          true,
        );
      }

      expect(expectTodoModule.routes.length, 3);
    });
  });
}
