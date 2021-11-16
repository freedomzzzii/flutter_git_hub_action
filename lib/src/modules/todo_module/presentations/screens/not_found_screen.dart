import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../configs/l10n/app_localizations.dart';
import '../widgets/bottom_menu_bar_widget.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(AppLocalizations.of(context).notFoundPage),
      ),
      bottomNavigationBar: const BottomMenuBarWidget(
        currentTabIndex: 2,
      ),
    );
  }
}
