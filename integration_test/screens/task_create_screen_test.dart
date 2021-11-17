import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_starter_kit/src/configs/l10n/app_localizations.dart';
import 'package:flutter_starter_kit/src/configs/routes/route_config.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/configs/widget_key/widget_key_config.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/presentations/screens/task_create_screen.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../main_integration_test.mocks.dart';

void screenTest(
  MockTaskBloc mockTaskBloc,
  MockImagePickerUtil mockImagePickerUtil,
) {
  testWidgets('Should call bloc to create task', (WidgetTester tester) async {
    when(mockTaskBloc.stream).thenAnswer(
      (_) => Stream<TaskState>.value(expectTaskCreateStateSuccess),
    );
    when(mockTaskBloc.state).thenReturn(expectTaskCreateStateSuccess);

    await tester.pumpWidget(
      MaterialApp(
        home: TaskCreateScreenWidget(imagePickerUtil: mockImagePickerUtil),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );

    when(mockImagePickerUtil.getBase64Image()).thenAnswer(
      (_) => Future<String?>.value(expectTaskCreateResponseEntity.imageUrl),
    );

    await tester.enterText(
      find.byKey(const Key(titleTextFieldWidgetKey)),
      expectTaskCreateResponseEntity.title,
    );

    await tester.tap(find.byKey(const Key(buttonSelectImageWidgetKey)));

    await tester.pump();

    expect(find.byKey(const Key(snackBarSuccessWidgetKey)), findsOneWidget);

    verify(mockImagePickerUtil.getBase64Image()).called(1);

    verify(Modular.to.pushNamed(initialRoute)).called(1);
  });
}
