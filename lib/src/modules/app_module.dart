import 'package:flutter_modular/flutter_modular.dart';

import '../configs/routes/route_config.dart';
import '../modules/todo_module/presentations/screens/not_found_screen.dart';
import '../modules/todo_module/todo_module.dart';

class AppModule extends Module {
  @override
  List<ModularRoute<dynamic>> get routes => <ModularRoute<dynamic>>[
        ModuleRoute(initialRoute, module: TodoModule()),
        ChildRoute<ChildRoute<String>>(
          notFoundRoute,
          child: (_, __) => const NotFoundPage(),
        )
      ];
}
