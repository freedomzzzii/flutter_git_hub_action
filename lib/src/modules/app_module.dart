import 'package:flutter_modular/flutter_modular.dart';

import '../configs/routes/route_config.dart';
import '../helpers/check_os/check_os_helper.dart';
import '../modules/todo_module/presentations/screens/not_found_screen.dart';
import '../modules/todo_module/todo_module.dart';
import '../utils/firebase/firebase_message_util.dart';

class AppModule extends Module {
  AppModule() {
    // 3rd packages initialization
    _fbMessaging = FirebaseMessagingUtil(osCode: _osCode);
    _fbMessaging.requestNotificationPermission();
  }

  final osCodes _osCode = getOs();
  late final FirebaseMessagingUtil _fbMessaging;

  @override
  List<Bind<Object>> get binds => <Bind<Object>>[
        Bind<FirebaseMessagingUtil>(
          (_) => _fbMessaging,
        ),
        Bind<osCodes>(
          (_) => _osCode,
        ),
      ];

  @override
  List<ModularRoute<dynamic>> get routes => <ModularRoute<dynamic>>[
        ModuleRoute(initialRoute, module: TodoModule()),
        ChildRoute<ChildRoute<String>>(
          notFoundRoute,
          child: (_, __) => const NotFoundPage(),
        )
      ];
}
