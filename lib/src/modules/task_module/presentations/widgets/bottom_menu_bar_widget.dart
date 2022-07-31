import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../../../../configs/l10n/app_localizations.dart';
import '../../../../core/navigation/navigation_core.dart';
import '../../../app_module.dart';
import '../../../common_module/configs/routes/route_config.dart';
import '../../configs/routes/route_config.dart';

class BottomMenuBarWidget extends StatelessWidget {
  const BottomMenuBarWidget({required int currentTabIndex, Key? key})
      : _currentTabIndex = currentTabIndex,
        super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  final int _currentTabIndex;

  void _navigateToScreen(int newTabIndex) {
    try {
      switch (newTabIndex) {
        case 0:
          navigationGetX
              .replaceAll(taskModule.getFullPath(subPath: taskCreatePath));
          analytics.logEvent(name: 'navigate_create');
          break;
        case 1:
          navigationGetX
              .replaceAll(taskModule.getFullPath(subPath: taskListEditPath));
          analytics.logEvent(name: 'navigate_edit');
          break;
        case 2:
          navigationGetX
              .replaceAll(taskModule.getFullPath(subPath: taskListPath));
          break;
        default:
          navigationGetX
              .replace(commonModule.getFullPath(subPath: commonNotFoundPath));
          break;
      }
    } catch (e) {
      navigationGetX
          .replace(commonModule.getFullPath(subPath: commonNotFoundPath));
    }
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
          label: AppLocalizations.of(context).grpcBottomMenu,
          icon: const Icon(Icons.update),
        ),
      ],
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      currentIndex: _currentTabIndex,
      onTap: (int newTabIndex) => _navigateToScreen(newTabIndex),
    );
  }
}
