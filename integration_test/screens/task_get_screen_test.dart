import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_starter_kit/src/configs/l10n/app_localizations.dart';
import 'package:flutter_starter_kit/src/configs/routes/route_config.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/models/task_bloc_models/task_get_bloc_model.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/applications/models/task_bloc_models/task_update_bloc_model.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/configs/widget_key/widget_key_config.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/presentations/screens/task_get_screen.dart';
import 'package:flutter_starter_kit/src/modules/todo_module/services/commons/request_query.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';

import '../main_integration_test.mocks.dart';

void screenTest(MockTaskBloc mockTaskBloc) {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('TaskGetScreenWidget Class', () {
    testWidgets('Should have mandatory menu', (WidgetTester tester) async {
      late BuildContext testContext;

      when(mockTaskBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateSuccess,
        ]),
      );
      when(mockTaskBloc.state).thenReturn(expectTaskGetStateSuccess);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              testContext = context;

              return TaskGetScreenWidget();
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
      when(mockTaskBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateSuccess,
        ]),
      );
      when(mockTaskBloc.state).thenReturn(expectTaskGetStateSuccess);

      await tester.pumpWidget(
        MaterialApp(
          home: TaskGetScreenWidget(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(appBarTitleWidgetKey)), findsOneWidget);
    });

    testWidgets('Should show load data text', (WidgetTester tester) async {
      when(mockTaskBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskInitialState,
        ]),
      );
      when(mockTaskBloc.state).thenReturn(expectTaskInitialState);

      await tester.pumpWidget(
        MaterialApp(
          home: TaskGetScreenWidget(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(loadDataTaskGetWidgetKey)), findsOneWidget);
    });
  });

  group('Should call bloc to get task', () {
    testWidgets('Should call bloc to get task - Success case (data empty)',
        (WidgetTester tester) async {
      when(mockTaskBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateSuccessDataEmpty,
        ]),
      );
      when(mockTaskBloc.state).thenReturn(expectTaskGetStateSuccessDataEmpty);

      await tester.pumpWidget(
        MaterialApp(
          home: TaskGetScreenWidget(),
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
      when(mockTaskBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateSuccess,
        ]),
      );
      when(mockTaskBloc.state).thenReturn(expectTaskGetStateSuccess);

      await tester.pumpWidget(
        MaterialApp(
          home: TaskGetScreenWidget(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsOneWidget);
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Should call bloc to get task - Success case (tap orderBy)',
        (WidgetTester tester) async {
      final TaskGetState expectBlocStateTwoData = TaskGetState(
        status: taskStatusState.success,
        query: expectTaskGetRequestBlocModel,
        data: <TaskGetResponseBlocModel>[
          expectTaskGetResponseBlocModel,
          expectTaskGetResponseBlocModel
        ],
      );

      when(mockTaskBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateSuccess,
          expectBlocStateTwoData,
        ]),
      );
      when(mockTaskBloc.state).thenReturn(expectTaskGetStateSuccess);

      await tester.pumpWidget(
        MaterialApp(
          home: TaskGetScreenWidget(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsOneWidget);
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );

      await tester.tap(find.byKey(const Key(orderByDropdownWidgetKey)));
      await tester.pump();

      when(
        mockTaskBloc.add(
          const TaskGotEvent(
            model: TaskGetRequestBlocModel(
              sortBy: titleQueryValue,
              orderBy: ascQueryValue,
            ),
          ),
        ),
      ).thenAnswer((_) => Future<TaskState>.value(expectBlocStateTwoData));

      await tester.tap(find.text(ascQueryValue).last);

      await tester.pump();

      expect(find.byType(Card), findsNWidgets(2));
    });

    testWidgets('Should call bloc to get task - Success case (tap sortBy)',
        (WidgetTester tester) async {
          final TaskGetState expectBlocStateTwoData = TaskGetState(
        status: taskStatusState.success,
        query: expectTaskGetRequestBlocModel,
        data: <TaskGetResponseBlocModel>[
          expectTaskGetResponseBlocModel,
          expectTaskGetResponseBlocModel
        ],
      );

      when(mockTaskBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateSuccess,
          expectBlocStateTwoData,
        ]),
      );
      when(mockTaskBloc.state).thenReturn(expectTaskGetStateSuccess);

      await tester.pumpWidget(
        MaterialApp(
          home: TaskGetScreenWidget(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsOneWidget);
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );

      await tester.tap(find.byKey(const Key(sortByDropdownWidgetKey)));

      await tester.pump();

      when(
        mockTaskBloc.add(
          const TaskGotEvent(
            model: TaskGetRequestBlocModel(
              sortBy: createdAtQueryValue,
              orderBy: descQueryValue,
            ),
          ),
        ),
      ).thenAnswer((_) => Future<TaskState>.value(expectBlocStateTwoData));

      await tester.tap(find.text(createdAtQueryValue).last);

      await tester.pump();

      expect(find.byType(Card), findsNWidgets(2));
    });

    testWidgets('Should call bloc to get task - Failure case (error from bloc)',
        (WidgetTester tester) async {
      when(mockTaskBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateError,
        ]),
      );
      when(mockTaskBloc.state).thenReturn(expectTaskGetStateError);

      await tester.pumpWidget(
        MaterialApp(
          home: TaskGetScreenWidget(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsNothing);
      expect(find.byKey(const Key(oopsErrorTaskGetWidgetKey)), findsOneWidget);
    });
  });

  group('Should call bloc to update task', () {
    testWidgets('Should call bloc to update task - Success case (isDone)',
        (WidgetTester tester) async {
      const TaskUpdateBodyRequestBlocModel
          expectTaskUpdateBodyRequestBlocModelIsDone =
          TaskUpdateBodyRequestBlocModel(
        isDone: true,
      );
      const TaskUpdateState expectBlocStateUpdateIsDone = TaskUpdateState(
        status: taskStatusState.success,
      );
      final TaskGetState expectTaskGetStateSuccessIsDone = TaskGetState(
        status: taskStatusState.success,
        query: expectTaskGetStateSuccess.query,
        data: <TaskGetResponseBlocModel>[
          TaskGetResponseBlocModel(
            id: expectTaskGetResponseEntity.id,
            title: expectTaskGetResponseEntity.title,
            isDone: expectTaskUpdateBodyRequestBlocModelIsDone.isDone!,
            imageUrl: expectTaskGetResponseEntity.imageUrl,
            createdAt: expectTaskGetResponseEntity.createdAt,
          )
        ],
      );

      when(mockTaskBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateSuccess,
          expectBlocStateUpdateIsDone,
          expectTaskGetStateSuccessIsDone,
        ]),
      );
      when(mockTaskBloc.state).thenReturn(expectTaskGetStateSuccess);

      await tester.pumpWidget(
        MaterialApp(
          home: TaskGetScreenWidget(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsOneWidget);
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );

      when(
        mockTaskBloc.add(
          TaskUpdatedEvent(
            model: expectTaskUpdateBodyRequestBlocModelIsDone,
            queryParams: expectTaskUpdateQueryParamsRequestBlocModel,
          ),
        ),
      ).thenAnswer((_) => Future<TaskState>.value(expectBlocStateUpdateIsDone));

      when(mockTaskBloc.add(TaskGotEvent(model: expectTaskGetRequestBlocModel)))
          .thenAnswer(
        (_) => Future<TaskState>.value(expectBlocStateUpdateIsDone),
      );

      await tester.tap(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
      );

      await tester.pump();

      expect(find.text('Status: true'), findsOneWidget);

      expect(find.byType(Card), findsNWidgets(1));
    });

    testWidgets('''
Should call bloc to update task - Success case (navigate to update screen)''',
        (WidgetTester tester) async {
      final TaskUpdateBlocModel expectTaskUpdateBlocModelTitleImageUrl =
          TaskUpdateBlocModel(
        id: expectTaskGetResponseEntity.id,
        isDone: expectTaskGetResponseEntity.isDone,
        title: expectDataSourceError.message,
        imageUrl: '''
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkqAcAAIUAgUW0RjgAAAAASUVORK5CYII=''',
      );
      final TaskUpdateState expectBlocStateUpdateIsDone = TaskUpdateState(
        data: expectTaskUpdateBlocModelTitleImageUrl,
      );

      when(Modular.to.pushNamed(updateTaskRoute))
          .thenAnswer((_) => Future<void>.value());
      when(mockTaskBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateSuccess,
          expectBlocStateUpdateIsDone,
        ]),
      );
      when(mockTaskBloc.state).thenReturn(expectTaskGetStateSuccess);

      await tester.pumpWidget(
        MaterialApp(
          home: TaskGetScreenWidget(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsOneWidget);
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );

      when(
        mockTaskBloc.add(
          TaskSelectedToUpdatedEvent(
            model: expectTaskUpdateBlocModelTitleImageUrl,
          ),
        ),
      ).thenAnswer((_) => Future<TaskState>.value(expectBlocStateUpdateIsDone));

      await tester.tap(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
      );

      await tester.pump();

      verify(Modular.to.pushNamed(updateTaskRoute)).called(1);
    });

    testWidgets('''
Should call bloc to update task - Failure case (error from bloc update btn)''',
        (WidgetTester tester) async {
          const TaskUpdateState expectBlocStateUpdate = TaskUpdateState(
        status: taskStatusState.failure,
      );

      when(mockTaskBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateSuccess,
          expectBlocStateUpdate,
        ]),
      );
      when(mockTaskBloc.state).thenReturn(expectTaskGetStateSuccess);

      await tester.pumpWidget(
        MaterialApp(
          home: TaskGetScreenWidget(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsOneWidget);
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );

      when(
        mockTaskBloc.add(
          TaskSelectedToUpdatedEvent(
            model: expectTaskUpdateBlocModel,
          ),
        ),
      ).thenThrow(expectTaskUpdateUseCaseError);

      await tester.tap(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
      );

      await tester.pump();

      expect(find.byKey(const Key(oopsErrorTaskGetWidgetKey)), findsOneWidget);

      expect(find.byKey(const Key(snackBarFailureWidgetKey)), findsOneWidget);
    });

    testWidgets('''
Should call bloc to update task - Failure case (error from bloc isDone btn)''',
        (WidgetTester tester) async {
          const TaskUpdateState expectBlocStateUpdate = TaskUpdateState(
        status: taskStatusState.failure,
      );

      when(mockTaskBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateSuccess,
          expectBlocStateUpdate,
        ]),
      );
      when(mockTaskBloc.state).thenReturn(expectTaskGetStateSuccess);

      await tester.pumpWidget(
        MaterialApp(
          home: TaskGetScreenWidget(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsOneWidget);
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );

      when(
        mockTaskBloc.add(
          TaskUpdatedEvent(
            model: const TaskUpdateBodyRequestBlocModel(
              isDone: true,
            ),
            queryParams: expectTaskUpdateQueryParamsRequestBlocModel,
          ),
        ),
      ).thenThrow(expectTaskUpdateUseCaseError);

      await tester.tap(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
      );

      await tester.pump();

      expect(find.byKey(const Key(oopsErrorTaskGetWidgetKey)), findsOneWidget);

      expect(find.byKey(const Key(snackBarFailureWidgetKey)), findsOneWidget);
    });
  });

  group('Should call bloc to delete task', () {
    testWidgets('Should call bloc to delete task - Success case',
        (WidgetTester tester) async {
          const TaskDeleteState expectBlocStateDelete = TaskDeleteState(
        status: taskStatusState.success,
      );
      final TaskGetState expectTaskGetStateSuccessDelete = TaskGetState(
        status: taskStatusState.success,
        query: expectTaskGetStateSuccess.query,
        data: const <TaskGetResponseBlocModel>[],
      );

      when(mockTaskBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateSuccess,
          expectBlocStateDelete,
          expectTaskGetStateSuccessDelete,
        ]),
      );
      when(mockTaskBloc.state).thenReturn(expectTaskGetStateSuccess);

      await tester.pumpWidget(
        MaterialApp(
          home: TaskGetScreenWidget(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsOneWidget);
      expect(find.byType(Card), findsNWidgets(1));
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(
            const Key('${titleTaskGetWidgetKey}0'),
          ),
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );

      when(
        mockTaskBloc.add(
          TaskDeletedEvent(
            queryParams: expectTaskDeleteQueryParamsRequestBlocModel,
          ),
        ),
      ).thenAnswer((_) => Future<TaskState>.value(expectBlocStateDelete));

      when(
        mockTaskBloc.add(
          TaskGotEvent(
            model: expectTaskGetRequestBlocModel,
          ),
        ),
      ).thenAnswer(
        (_) => Future<TaskState>.value(expectTaskGetStateSuccessDelete),
      );

      await tester.tap(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
      );

      await tester.pump();

      expect(find.byType(Card), findsNWidgets(0));
    });

    testWidgets(
        'Should call bloc to delete task - Failure case (error from bloc)',
        (WidgetTester tester) async {
          const TaskDeleteState expectBlocStateDelete = TaskDeleteState(
        status: taskStatusState.failure,
      );

      when(mockTaskBloc.stream).thenAnswer(
        (_) => Stream<TaskState>.fromIterable(<TaskState>[
          expectTaskGetStateSuccess,
          expectBlocStateDelete,
        ]),
      );
      when(mockTaskBloc.state).thenReturn(expectTaskGetStateSuccess);

      await tester.pumpWidget(
        MaterialApp(
          home: TaskGetScreenWidget(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      expect(find.byKey(const Key(sortByDropdownWidgetKey)), findsOneWidget);
      expect(find.byKey(const Key(orderByDropdownWidgetKey)), findsOneWidget);
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
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${isDoneBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${updateBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
        findsOneWidget,
      );

      when(
        mockTaskBloc.add(
          TaskDeletedEvent(
            queryParams: expectTaskDeleteQueryParamsRequestBlocModel,
          ),
        ),
      ).thenThrow(expectTaskDeleteUseCaseError);

      await tester.tap(
        find.descendant(
          of: find.byType(Card),
          matching: find.byKey(const Key('${deleteBtnTaskGetWidgetKey}0')),
        ),
      );

      await tester.pump();

      expect(find.byKey(const Key(oopsErrorTaskGetWidgetKey)), findsOneWidget);

      expect(find.byKey(const Key(snackBarFailureWidgetKey)), findsOneWidget);
    });
  });
}