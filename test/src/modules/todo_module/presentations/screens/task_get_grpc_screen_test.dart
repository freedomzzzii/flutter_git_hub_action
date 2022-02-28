import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_starter_kit/src/configs/l10n/app_localizations.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/configs/widget_key/widget_key_config.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/presentations/screens/task_get_grpc_screen.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/todo_module.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../app_module_test.mocks.dart';
import '../../applications/bloc/task_bloc/task_bloc_test.mocks.dart';

void main() {
  final MockTaskBloc mockBloc = MockTaskBloc();
  final TaskGetGrpcScreen expectTaskGetGrpcScreen = TaskGetGrpcScreen(
    bloc: mockBloc,
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

  group('TaskGetGrpcScreen Class', () {
    testWidgets('Should have mandatory menu', (WidgetTester tester) async {
      late BuildContext testContext;

      when(mockBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateSuccess,
        ]),
      );
      when(mockBloc.state).thenReturn(expectTaskGetStateSuccess);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              testContext = context;

              return expectTaskGetGrpcScreen;
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
      expect(
        find.text(AppLocalizations.of(testContext).grpcBottomMenu),
        findsOneWidget,
      );
    });

    testWidgets('Should have mandatory app bar', (WidgetTester tester) async {
      when(mockBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateSuccess,
        ]),
      );
      when(mockBloc.state).thenReturn(expectTaskGetStateSuccess);

      await tester.pumpWidget(
        MaterialApp(
          home: expectTaskGetGrpcScreen,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(appBarTitleWidgetKey)), findsOneWidget);
    });

    testWidgets('Should show load data text', (WidgetTester tester) async {
      when(mockBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskInitialState,
        ]),
      );
      when(mockBloc.state).thenReturn(expectTaskInitialState);

      await tester.pumpWidget(
        MaterialApp(
          home: expectTaskGetGrpcScreen,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(loadDataTaskGetWidgetKey)), findsOneWidget);
    });
  });

  testWidgets('Should show load data text', (WidgetTester tester) async {
    when(mockBloc.stream).thenAnswer(
      (_) => Stream<TaskState>.fromIterable(<TaskState>[
        expectTaskUpdateState,
      ]),
    );
    when(mockBloc.state).thenReturn(expectTaskUpdateState);

    await tester.pumpWidget(
      MaterialApp(
        home: expectTaskGetGrpcScreen,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );

    expect(find.byKey(const Key(oopsErrorTaskGetWidgetKey)), findsOneWidget);
  });

  group('Should call bloc to get task', () {
    testWidgets('Should call bloc to get task - Success case (data empty)',
        (WidgetTester tester) async {
      when(mockBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateSuccessDataEmpty,
        ]),
      );
      when(mockBloc.state).thenReturn(expectTaskGetStateSuccessDataEmpty);

      await tester.pumpWidget(
        MaterialApp(
          home: expectTaskGetGrpcScreen,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(dataEmptyTaskGetWidgetKey)), findsOneWidget);
    });

    testWidgets('Should call bloc to get task - Success case (have data)',
        (WidgetTester tester) async {
      when(mockBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateSuccess,
        ]),
      );
      when(mockBloc.state).thenReturn(expectTaskGetStateSuccess);

      await tester.pumpWidget(
        MaterialApp(
          home: expectTaskGetGrpcScreen,
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

    testWidgets('Should call bloc to get task - Failure case (error from bloc)',
        (WidgetTester tester) async {
      when(mockBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateError,
        ]),
      );
      when(mockBloc.state).thenReturn(expectTaskGetStateError);

      await tester.pumpWidget(
        MaterialApp(
          home: expectTaskGetGrpcScreen,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(oopsErrorTaskGetWidgetKey)), findsOneWidget);
    });
  });
}
