import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_starter_kit/src/configs/l10n/app_localizations.dart';
import 'package:flutter_starter_kit/src/configs/routes/route_config.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/configs/widget_key/widget_key_config.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/presentations/screens/task_update_screen.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/todo_module.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../utils/image_picker/image_picker_util_test.mocks.dart';
import '../../../app_module_test.mocks.dart';
import '../../applications/bloc/task_bloc/task_bloc_test.mocks.dart';

void main() {
  final MockTaskBloc mockBloc = MockTaskBloc();
  final MockImagePickerUtil mockImagePickerUtil = MockImagePickerUtil();

  setUp(() {
    initModule(
      TodoModule(),
      replaceBinds: <Bind<Object>>[
        Bind<Object>((_) => mockBloc),
      ],
    );

    when(mockBloc.state).thenReturn(expectTaskUpdateStateSuccess);

    when(mockBloc.stream).thenAnswer(
      (_) => Stream<TaskState>.fromIterable(<TaskState>[
        expectTaskUpdateStateSuccess,
        expectTaskUpdateStateSuccess,
      ]),
    );

    Modular.navigatorDelegate = MockIModularNavigator();

    when(Modular.to.pushNamed(initialRoute))
        .thenAnswer((_) => Future<void>.value());
  });

  tearDown(() {
    Modular.dispose();
  });

  group('TaskUpdateScreen Class', () {
    testWidgets('Should mandatory widget', (WidgetTester tester) async {
      Modular.get<TaskBloc>().add(expectTaskSelectedToUpdateEvent);

      await tester.pumpWidget(
        MaterialApp(
          home: TaskUpdateScreen(imagePickerUtil: mockImagePickerUtil),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );
      expect(find.byKey(const Key(textFieldUpdateWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(imageUpdateWidgetKey)), findsOneWidget);
      expect(
        find.byKey(const Key(buttonSelectUpdateImageWidgetKey)),
        findsOneWidget,
      );
      expect(find.byKey(const Key(saveUpdateButtonWidgetKey)), findsOneWidget);
    });

    testWidgets('Should accept state from event', (WidgetTester tester) async {
      Modular.get<TaskBloc>().add(expectTaskSelectedToUpdateEvent);

      await tester.pumpWidget(
        MaterialApp(
          home: TaskUpdateScreen(imagePickerUtil: mockImagePickerUtil),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      final TextFormField textField = tester.widget<TextFormField>(
        find.byKey(const Key(textFieldUpdateWidgetKey)),
      );
      expect(textField.controller?.text, expectTaskGetResponseEntity.title);
    });

    testWidgets('Should can save data and have snack bar',
        (WidgetTester tester) async {
          await tester.pumpWidget(
        MaterialApp(
          home: TaskUpdateScreen(imagePickerUtil: mockImagePickerUtil),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

          when(mockImagePickerUtil.getBase64Image()).thenAnswer(
        (_) => Future<String>.value(
          '''
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=''',
        ),
      );

      await tester.enterText(
        find.byKey(const Key(textFieldUpdateWidgetKey)),
        'expectTaskTitle',
      );

      await tester.tap(find.byKey(const Key(buttonSelectUpdateImageWidgetKey)));

      await tester.pump();

      verify(mockImagePickerUtil.getBase64Image()).called(1);

      await tester.tap(find.byKey(const Key(saveUpdateButtonWidgetKey)));

      await tester.pump();

      expect(
        find.byKey(const Key(snackBarUpdateSuccessWidgetKey)),
        findsOneWidget,
      );
    });
  });
}
