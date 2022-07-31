import 'package:flutter/material.dart';

import '../../../../configs/l10n/app_localizations.dart';

class CommonNotFoundScreen extends StatelessWidget {
  const CommonNotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(AppLocalizations.of(context).notFoundPage),
      ),
    );
  }
}
