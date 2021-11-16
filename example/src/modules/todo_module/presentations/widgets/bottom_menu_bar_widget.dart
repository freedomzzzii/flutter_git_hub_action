import 'package:flutter/material.dart';

import '../../../../configs/l10n/app_localizations.dart';

class BottomMenuBarWidget extends StatelessWidget {
  const BottomMenuBarWidget({required int currentTabIndex, Key? key})
      : _currentTabIndex = currentTabIndex,
        super(key: key);

  final int _currentTabIndex;

  void _navigateToScreen(int newTabIndex) {
    // navigate screen
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: AppLocalizations.of(context).createBottomMenu,
          icon: const Icon(Icons.create),
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context).listBottomMenu,
          icon: const Icon(Icons.list),
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context).updateBottomMenu,
          icon: const Icon(Icons.update),
        ),
      ],
      selectedItemColor: Colors.blue,
      currentIndex: _currentTabIndex,
      onTap: (int newTabIndex) => _navigateToScreen(newTabIndex),
    );
  }
}
