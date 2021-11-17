import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:poc_clean_arch/src/configs/l10n/app_localizations.dart';
import 'package:poc_clean_arch/src/configs/routes/route_config.dart';
import 'package:poc_clean_arch/src/modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';
import 'package:poc_clean_arch/src/modules/todo_module/configs/widget_key/widget_key_config.dart';
import 'package:poc_clean_arch/src/modules/todo_module/presentations/screens/task_create_screen.dart';

import 'main_integration_test.mocks.dart';
import 'mock_integration_test.dart';

void screenTest(
  MockTaskBloc mockTaskBloc,
  MockImagePickerUtil mockImagePickerUtil,
) {
  final MockTaskBloc bloc = mockTaskBloc;
  final MockImagePickerUtil mockSelectImage = mockImagePickerUtil;

  testWidgets('Should call bloc to create task', (WidgetTester tester) async {
    when(bloc.stream).thenAnswer(
      (_) => Stream<TaskState>.value(expectTaskCreateStateSuccess),
    );
    when(bloc.state).thenReturn(expectTaskCreateStateSuccess);

    await tester.pumpWidget(
      MaterialApp(
        home: TaskCreateScreenWidget(imagePickerUtil: mockSelectImage),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );

    when(mockSelectImage.getBase64Image()).thenAnswer(
          (_) => Future<String?>.value(expectTaskCreateResponseEntity.imageUrl),
    );

    await tester.enterText(
      find.byKey(const Key(titleTextFieldWidgetKey)),
      expectTaskCreateResponseEntity.title,
    );

    await tester.tap(find.byKey(const Key(buttonSelectImageWidgetKey)));

    await tester.pump();

    expect(find.byKey(const Key(snackBarSuccessWidgetKey)), findsOneWidget);

    verify(mockSelectImage.getBase64Image()).called(1);

    verify(Modular.to.pushNamed(initialRoute)).called(1);
  });
}
