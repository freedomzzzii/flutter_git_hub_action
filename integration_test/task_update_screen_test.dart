import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:poc_clean_arch/src/configs/l10n/app_localizations.dart';
import 'package:poc_clean_arch/src/modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';
import 'package:poc_clean_arch/src/modules/todo_module/applications/models/task_bloc_models/task_update_bloc_model.dart';
import 'package:poc_clean_arch/src/modules/todo_module/configs/widget_key/widget_key_config.dart';
import 'package:poc_clean_arch/src/modules/todo_module/presentations/screens/task_update_screen.dart';

import 'main_integration_test.mocks.dart';

void screenTest(
  MockTaskBloc mockTaskBloc,
  MockImagePickerUtil mockImagePickerUtil,
) {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final MockTaskBloc bloc = mockTaskBloc;
  final MockImagePickerUtil mockSelectImage = mockImagePickerUtil;

  group('TaskUpdateScreen Class', () {
    testWidgets('Should can save data and have snack bar',
        (WidgetTester tester) async {
      when(bloc.state).thenReturn(
        const TaskUpdateState(
          data: TaskUpdateBlocModel(
            id: 'expect_id',
            title: 'expect_title',
            isDone: false,
            imageUrl: '''
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=''',
          ),
          status: taskStatusState.success,
        ),
      );

      when(bloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          const TaskUpdateState(
            data: TaskUpdateBlocModel(
              id: 'expect_id',
              title: 'expect_title',
              isDone: false,
              imageUrl: '''
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=''',
            ),
            status: taskStatusState.success,
          ),
          const TaskUpdateState(
            data: TaskUpdateBlocModel(
              id: 'expect_id',
              title: 'expectTaskTitle',
              isDone: false,
              imageUrl: '''
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=''',
            ),
            status: taskStatusState.success,
          ),
        ]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: TaskUpdateScreenWidget(imagePickerUtil: mockSelectImage),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      when(mockSelectImage.getBase64Image()).thenAnswer(
        (_) => Future<String?>.value(
          '''
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=''',
        ),
      );

      await tester.pump();

      await tester.enterText(
        find.byKey(const Key(textFieldUpdateWidgetKey)),
        'expectTaskTitle',
      );

      await tester.tap(find.byKey(const Key(buttonSelectUpdateImageWidgetKey)));

      await tester.pump();

      verify(mockSelectImage.getBase64Image()).called(1);

      await tester.tap(find.byKey(const Key(saveUpdateButtonWidgetKey)));

      await tester.pump();

      expect(
        find.byKey(const Key(snackBarUpdateSuccessWidgetKey)),
        findsOneWidget,
      );
    });
  });
}
