import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';
import 'src/configs/l10n/app_localizations.dart';
import 'src/helpers/check_os/check_os_helper.dart';
import 'src/modules/app_module.dart';
import 'src/modules/common_module/configs/routes/route_config.dart';
import 'src/modules/task_module/configs/routes/route_config.dart';

Future<void> main() async {
  try {
    configureApp();

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    final Trace _dotENVTrace = FirebasePerformance.instance.newTrace('dot_env');
    final AppBinding _initialAppBinding = AppBinding(os: getOs());

    _dotENVTrace.start();
    await dotenv.load();
    _dotENVTrace.stop();

    return runApp(
      GetMaterialApp(
        initialRoute: taskModule.getFullPath(subPath: taskListEditPath),
        initialBinding: _initialAppBinding,
        getPages: allRouteScreen,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  } catch (e) {
    return runApp(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return Center(
                child: Text(AppLocalizations.of(context).oopsErrorEnv),
              );
            },
          ),
        ),
        initialRoute: commonModule.getFullPath(subPath: commonNotFoundPath),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
