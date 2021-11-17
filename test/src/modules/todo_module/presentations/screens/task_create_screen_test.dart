import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:poc_clean_arch/src/configs/l10n/app_localizations.dart';
import 'package:poc_clean_arch/src/configs/routes/route_config.dart';
import 'package:poc_clean_arch/src/modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';
import 'package:poc_clean_arch/src/modules/todo_module/configs/widget_key/widget_key_config.dart';
import 'package:poc_clean_arch/src/modules/todo_module/presentations/screens/task_create_screen.dart';
import 'package:poc_clean_arch/src/modules/todo_module/todo_module.dart';

import '../../../../../test_data/mock_test_data.dart';
import '../../../../helpers/image_picker/image_picker_util_test.mocks.dart';
import '../../../app_module_test.mocks.dart';
import '../../applications/bloc/task_bloc/task_bloc_test.mocks.dart';

void main() {
  final MockTaskBloc bloc = MockTaskBloc();
  final MockImagePickerUtil mockSelectImage = MockImagePickerUtil();

  setUp(() {
    initModule(
      TodoModule(),
      replaceBinds: <Bind<Object>>[
        Bind<Object>((_) => bloc),
      ],
    );

    Modular.navigatorDelegate = MockIModularNavigator();
  });

  tearDown(() {
    Modular.dispose();
  });

  group('TaskCreateScreen Class', () {
    testWidgets('Should have mandatory menu', (WidgetTester tester) async {
      late BuildContext testContext;

      when(bloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          TaskInitialState(),
          expectTaskCreateStateSuccess,
        ]),
      );
      when(bloc.state).thenReturn(TaskInitialState());

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              testContext = context;

              return TaskCreateScreenWidget(imagePickerUtil: mockSelectImage);
            },
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(
        find.text(AppLocalizations.of(testContext).createBottomMenu),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.of(testContext).listBottomMenu),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.of(testContext).updateBottomMenu),
        findsOneWidget,
      );
    });

    testWidgets('Should have mandatory app bar', (WidgetTester tester) async {
      when(bloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          TaskInitialState(),
          expectTaskCreateStateSuccess,
        ]),
      );
      when(bloc.state).thenReturn(TaskInitialState());

      await tester.pumpWidget(
        MaterialApp(
          home: TaskCreateScreenWidget(
            imagePickerUtil: mockSelectImage,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(appBarTitleWidgetKey)), findsOneWidget);
    });

    testWidgets('Should have mandatory form', (WidgetTester tester) async {
      late BuildContext testContext;

      when(bloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          TaskInitialState(),
          expectTaskCreateStateSuccess,
        ]),
      );
      when(bloc.state).thenReturn(TaskInitialState());

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              testContext = context;

              return TaskCreateScreenWidget(imagePickerUtil: mockSelectImage);
            },
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(
        find.text(AppLocalizations.of(testContext).titlePlaceholderTaskCreate),
        findsOneWidget,
      );
      expect(
        find.text(AppLocalizations.of(testContext).selectImageBtnTaskCreate),
        findsOneWidget,
      );
      expect(find.byKey(const Key(titleTextFieldWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(buttonSelectImageWidgetKey)), findsOneWidget);
    });

    testWidgets('Should call bloc to create task - Success case',
        (WidgetTester tester) async {
      when(bloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          TaskInitialState(),
          expectTaskCreateStateSuccess,
        ]),
      );
      when(bloc.state).thenReturn(TaskInitialState());

      await tester.pumpWidget(
        MaterialApp(
          home: TaskCreateScreenWidget(imagePickerUtil: mockSelectImage),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      when(bloc.add(TaskCreatedEvent(model: expectTaskCreateRequestBlocModel)))
          .thenAnswer(
        (_) => Future<TaskState>.value(
          expectTaskCreateStateSuccess,
        ),
      );

      when(mockSelectImage.getBase64Image()).thenAnswer(
        (_) => Future<String>.value(expectTaskCreateResponseEntity.imageUrl),
      );

      when(Modular.to.pushNamed(initialRoute))
          .thenAnswer((_) => Future<void>.value());

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

    testWidgets('''
Should call bloc to create task - Failure case (error in _selectImage method)''',
        (WidgetTester tester) async {
      when(bloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          TaskInitialState(),
        ]),
      );
      when(bloc.state).thenReturn(TaskInitialState());

      await tester.pumpWidget(
        MaterialApp(
          home: TaskCreateScreenWidget(imagePickerUtil: mockSelectImage),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(snackBarSuccessWidgetKey)), findsNothing);
      expect(find.byKey(const Key(snackBarFailureWidgetKey)), findsNothing);

      when(mockSelectImage.getBase64Image()).thenThrow(expectImagePickerError);

      await tester.enterText(
        find.byKey(const Key(titleTextFieldWidgetKey)),
        expectTaskCreateResponseEntity.title,
      );

      await tester.tap(find.byKey(const Key(buttonSelectImageWidgetKey)));

      await tester.pump();

      expect(find.byKey(const Key(snackBarFailureWidgetKey)), findsOneWidget);

      verify(mockSelectImage.getBase64Image()).called(1);
    });
  });
}
