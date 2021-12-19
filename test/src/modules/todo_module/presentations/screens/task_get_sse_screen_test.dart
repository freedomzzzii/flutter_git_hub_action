import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_starter_kit/src/configs/l10n/app_localizations.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/bloc/task_sse_bloc/task_sse_bloc.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/configs/widget_key/widget_key_config.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/presentations/screens/task_get_sse_screen.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/todo_module.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../app_module_test.mocks.dart';
import '../../applications/bloc/task_sse_bloc/task_sse_bloc_test.mocks.dart';

void main() {
  final MockTaskSseBloc mockTaskSseBloc = MockTaskSseBloc();
  final TaskGetSseScreen expectTaskGetSseScreen = TaskGetSseScreen(
    bloc: mockTaskSseBloc,
  );

  setUp(() {
    initModule(
      TodoModule(),
    );

    Modular.navigatorDelegate = MockIModularNavigator();
  });

  tearDown(() {
    Modular.dispose();
  });

  group('TaskGetSseScreen Class', () {
    testWidgets('Should have mandatory menu', (WidgetTester tester) async {
      late BuildContext testContext;

      when(mockTaskSseBloc.stream).thenAnswer(
        (_) => Stream<TaskSseState>.fromIterable(<TaskSseState>[
          expectTaskSseGetTaskState,
        ]),
      );
      when(mockTaskSseBloc.state).thenReturn(expectTaskSseGetTaskState);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              testContext = context;

              return expectTaskGetSseScreen;
            },
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(
        find.byKey(const Key(sseCloseConnectButtonWidgetKey)),
        findsOneWidget,
      );
      expect(find.byKey(const Key(sseConnectButtonWidgetKey)), findsOneWidget);
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
      expect(
        find.text(AppLocalizations.of(testContext).sseBottomMenu),
        findsOneWidget,
      );
    });

    testWidgets('Should have mandatory app bar', (WidgetTester tester) async {
      when(mockTaskSseBloc.stream).thenAnswer(
        (_) => Stream<TaskSseState>.fromIterable(<TaskSseState>[
          expectTaskSseGetTaskState,
        ]),
      );
      when(mockTaskSseBloc.state).thenReturn(expectTaskSseGetTaskState);

      await tester.pumpWidget(
        MaterialApp(
          home: expectTaskGetSseScreen,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(
        find.byKey(const Key(sseCloseConnectButtonWidgetKey)),
        findsOneWidget,
      );
      expect(find.byKey(const Key(sseConnectButtonWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(appBarTitleWidgetKey)), findsOneWidget);
    });

    testWidgets('Should show load data text', (WidgetTester tester) async {
      when(mockTaskSseBloc.stream).thenAnswer(
        (_) => Stream<TaskSseState>.fromIterable(<TaskSseState>[
          expectTaskSseInitialState,
        ]),
      );
      when(mockTaskSseBloc.state).thenReturn(expectTaskSseInitialState);

      await tester.pumpWidget(
        MaterialApp(
          home: expectTaskGetSseScreen,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(
        find.byKey(const Key(sseCloseConnectButtonWidgetKey)),
        findsOneWidget,
      );
      expect(find.byKey(const Key(sseConnectButtonWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(loadDataTaskGetWidgetKey)), findsOneWidget);
    });
  });

  group('Should call bloc to get task', () {
    testWidgets('Should call bloc to create task - Success case',
        (WidgetTester tester) async {
      when(mockTaskSseBloc.stream).thenAnswer(
        (_) => Stream<TaskSseState>.fromIterable(<TaskSseState>[
          expectTaskSseGetTaskState,
        ]),
      );
      when(mockTaskSseBloc.state).thenReturn(expectTaskSseGetTaskState);

      await tester.pumpWidget(
        MaterialApp(
          home: expectTaskGetSseScreen,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byType(Card), findsNWidgets(1));
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${titleTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${imageTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Should call bloc to get task - Success case (data empty)',
        (WidgetTester tester) async {
      when(mockTaskSseBloc.stream).thenAnswer(
        (_) => Stream<TaskSseState>.fromIterable(<TaskSseState>[
          expectTaskSseGetTaskStateEmpty,
        ]),
      );
      when(mockTaskSseBloc.state).thenReturn(expectTaskSseGetTaskStateEmpty);

      await tester.pumpWidget(
        MaterialApp(
          home: expectTaskGetSseScreen,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(
        find.byKey(const Key(sseCloseConnectButtonWidgetKey)),
        findsOneWidget,
      );

      when(
        mockTaskSseBloc.add(TaskClosedConnectionEvent()),
      ).thenAnswer(
          (_) => Future<TaskSseState>.value(expectTaskSseGetTaskStateEmpty));

      await tester.tap(find.byKey(const Key(sseConnectButtonWidgetKey)));

      await tester.pump();

      expect(find.byKey(const Key(sseConnectButtonWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(dataEmptyTaskGetWidgetKey)), findsOneWidget);
    });

    testWidgets('Should call bloc to get task - Failure case (error from bloc)',
        (WidgetTester tester) async {
      when(mockTaskSseBloc.stream).thenAnswer(
        (_) => Stream<TaskSseState>.fromIterable(<TaskSseState>[
          expectTaskSseGetTaskStateError,
        ]),
      );
      when(mockTaskSseBloc.state).thenReturn(expectTaskSseGetTaskStateError);

      await tester.pumpWidget(
        MaterialApp(
          home: expectTaskGetSseScreen,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(
        find.byKey(const Key(sseCloseConnectButtonWidgetKey)),
        findsOneWidget,
      );
      expect(find.byKey(const Key(sseConnectButtonWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(oopsErrorTaskGetWidgetKey)), findsOneWidget);
    });
  });

  group('Should call bloc to connect sse', () {
    testWidgets('Should call bloc to connect sse - Success case',
        (WidgetTester tester) async {
      when(mockTaskSseBloc.stream).thenAnswer(
        (_) => Stream<TaskSseState>.fromIterable(<TaskSseState>[
          expectTaskSseConnectGetTaskState,
        ]),
      );
      when(mockTaskSseBloc.state).thenReturn(expectTaskSseConnectGetTaskState);

      await tester.pumpWidget(
        MaterialApp(
          home: expectTaskGetSseScreen,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(
        find.byKey(const Key(sseCloseConnectButtonWidgetKey)),
        findsOneWidget,
      );

      await tester.tap(find.byKey(const Key(sseConnectButtonWidgetKey)));

      await tester.pump();

      expect(find.byKey(const Key(sseConnectButtonWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(loadDataTaskGetWidgetKey)), findsOneWidget);
    });

    testWidgets('Should call bloc to connect sse - Failure case',
        (WidgetTester tester) async {
      when(mockTaskSseBloc.stream).thenAnswer(
        (_) => Stream<TaskSseState>.fromIterable(<TaskSseState>[
          expectTaskSseGetTaskStateError,
        ]),
      );
      when(mockTaskSseBloc.state).thenReturn(expectTaskSseGetTaskStateError);

      await tester.pumpWidget(
        MaterialApp(
          home: expectTaskGetSseScreen,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(
        find.byKey(const Key(sseCloseConnectButtonWidgetKey)),
        findsOneWidget,
      );

      await tester.tap(find.byKey(const Key(sseConnectButtonWidgetKey)));

      await tester.pump();

      expect(find.byKey(const Key(sseCloseConnectButtonWidgetKey)),
          findsOneWidget);
      expect(find.byKey(const Key(oopsErrorTaskGetWidgetKey)), findsOneWidget);
    });
  });

  group('Should call bloc to close connection sse', () {
    testWidgets('Should call bloc to close connection sse - Success case',
        (WidgetTester tester) async {
      when(mockTaskSseBloc.stream).thenAnswer(
        (_) => Stream<TaskSseState>.fromIterable(<TaskSseState>[
          expectTaskSseCloseConnectState,
        ]),
      );
      when(mockTaskSseBloc.state).thenReturn(expectTaskSseCloseConnectState);

      await tester.pumpWidget(
        MaterialApp(
          home: expectTaskGetSseScreen,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(
        find.byKey(const Key(sseCloseConnectButtonWidgetKey)),
        findsOneWidget,
      );
      expect(find.byKey(const Key(sseConnectButtonWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(loadDataTaskGetWidgetKey)), findsOneWidget);
    });

    testWidgets('Should call bloc to close connection sse - Failure case',
        (WidgetTester tester) async {
      when(mockTaskSseBloc.stream).thenAnswer(
        (_) => Stream<TaskSseState>.fromIterable(<TaskSseState>[
          expectTaskSseCloseConnectStateError,
        ]),
      );
      when(mockTaskSseBloc.state)
          .thenReturn(expectTaskSseCloseConnectStateError);

      await tester.pumpWidget(
        MaterialApp(
          home: expectTaskGetSseScreen,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(
        find.byKey(const Key(sseCloseConnectButtonWidgetKey)),
        findsOneWidget,
      );
      expect(find.byKey(const Key(sseConnectButtonWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(oopsErrorTaskGetWidgetKey)), findsOneWidget);
    });
  });
}
