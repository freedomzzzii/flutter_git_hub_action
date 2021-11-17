import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:poc_clean_arch/src/configs/l10n/app_localizations.dart';
import 'package:poc_clean_arch/src/configs/routes/route_config.dart';
import 'package:poc_clean_arch/src/modules/todo_module/applications/bloc/task_bloc/task_bloc.dart';
import 'package:poc_clean_arch/src/modules/todo_module/presentations/widgets/bottom_menu_bar_widget.dart';
import 'package:poc_clean_arch/src/modules/todo_module/todo_module.dart';

import '../../../app_module_test.mocks.dart';
import '../../task_impl_usecase_test.mocks.dart';

void main() {
  setUpAll(() {
    initModule(
      TodoModule(),
      replaceBinds: <Bind<Object>>[
        Bind<Object>((_) => TaskBloc(usecase: MockTaskImplUseCase())),
      ],
    );

    Modular.navigatorDelegate = MockIModularNavigator();
  });

  group('BottomMenuBarWidget Class', () {
    testWidgets('Should have mandatory menu', (WidgetTester tester) async {
      late BuildContext testContext;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              testContext = context;

              return const BottomMenuBarWidget(
                currentTabIndex: 1,
              );
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

    testWidgets('Should navigate to screen (list, create, update)',
        (WidgetTester tester) async {
      late BuildContext testContext;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              testContext = context;

              return const BottomMenuBarWidget(
                currentTabIndex: 1,
              );
            },
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

      when(Modular.to.pushNamed(initialRoute))
          .thenAnswer((_) => Future<void>.value());

      await tester
          .tap(find.text(AppLocalizations.of(testContext).listBottomMenu));

      await tester.pumpAndSettle();

      verify(Modular.to.pushNamed(initialRoute)).called(1);

      when(Modular.to.pushNamed(createTaskRoute))
          .thenAnswer((_) => Future<void>.value());

      await tester
          .tap(find.text(AppLocalizations.of(testContext).createBottomMenu));

      await tester.pumpAndSettle();

      verify(Modular.to.pushNamed(createTaskRoute)).called(1);

      when(Modular.to.pushNamed(updateTaskRoute))
          .thenAnswer((_) => Future<void>.value());

      await tester
          .tap(find.text(AppLocalizations.of(testContext).updateBottomMenu));

      await tester.pumpAndSettle();

      verify(Modular.to.pushNamed(updateTaskRoute)).called(1);
    });
  });
}
