import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../configs/l10n/app_localizations.dart';
import '../configs/routes/route_config.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: initialRoute,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    ).modular();
  }
}
