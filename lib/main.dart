import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'src/configs/env/env_config.dart';
import 'src/configs/l10n/app_localizations.dart';
import 'src/configs/routes/route_config.dart';
import 'src/modules/app_module.dart';
import 'src/modules/app_screen.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    final Trace myTrace = FirebasePerformance.instance.newTrace('dot_env');

    myTrace.start();
    await dotenv.load(fileName: envFileName);
    myTrace.stop();

    return runApp(
      ModularApp(
        module: AppModule(),
        child: const AppScreen(),
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
        initialRoute: initialRoute,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
