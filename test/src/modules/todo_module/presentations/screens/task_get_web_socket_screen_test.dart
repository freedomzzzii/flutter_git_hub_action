import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_starter_kit/src/configs/l10n/app_localizations.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/configs/widget_key/widget_key_config.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/presentations/screens/task_get_web_socket_screen.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/todo_module.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../..//modules/app_module_test.mocks.dart';
import '../../applications/bloc/task_bloc/task_bloc_test.mocks.dart';


void main() {
  final MockTaskBloc mockBloc = MockTaskBloc();

  setUp(() {
    initModule(
      TodoModule(),
      replaceBinds: <Bind<Object>>[
        Bind<Object>((_) => mockBloc),
      ],
    );

    Modular.navigatorDelegate = MockIModularNavigator();
  });

  tearDown(() {
    Modular.dispose();
  });

  group('TaskGetWebSocketScreenWidget Class', () {
    testWidgets('Should have mandatory menu', (WidgetTester tester) async {

      when(mockBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          TaskInitialState(),
        ]),
      );
      when(mockBloc.state).thenReturn(TaskInitialState());

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              return TaskGetWebSocketScreenWidget();
            },
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(
        find.byKey(const Key(connectButtonWidgetKey)),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key(addEventButtonWidgetKey)),
        findsOneWidget,
      );
    });

    testWidgets('Should have mandatory menu', (WidgetTester tester) async {

      when(mockBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskStreamGetStateSuccess,
        ]),
      );
      when(mockBloc.state)
          .thenReturn(expectTaskStreamGetStateSuccess);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              return TaskGetWebSocketScreenWidget();
            },
          ),
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
  });
}
