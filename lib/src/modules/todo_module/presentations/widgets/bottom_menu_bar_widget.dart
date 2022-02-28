import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../configs/l10n/app_localizations.dart';
import '../../../../configs/routes/route_config.dart';

class BottomMenuBarWidget extends StatelessWidget {
  const BottomMenuBarWidget({required int currentTabIndex, Key? key})
      : _currentTabIndex = currentTabIndex,
        super(key: key);

  final int _currentTabIndex;

  void _navigateToScreen(int newTabIndex) {
    try {
      switch (newTabIndex) {
        case 0:
          Modular.to.pushNamed(createTaskRoute);
          break;
        case 1:
          Modular.to.pushNamed(initialRoute);
          break;
        case 2:
          Modular.to.pushNamed(updateTaskRoute);
          break;
        case 3:
          Modular.to.pushNamed(getTaskGrpcRoute);
          break;
        case 4:
          Modular.to.pushNamed(getTaskSseRoute);
          break;
        case 5:
          Modular.to.pushNamed(getTaskWebSocketRoute);
          break;
        default:
          Modular.to.pushNamed(notFoundRoute);
          break;
      }
    } catch (e) {
      Modular.to.pushNamed(notFoundRoute);
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
          label: AppLocalizations.of(context).updateBottomMenu,
          icon: const Icon(Icons.update),
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context).grpcBottomMenu,
          icon: const Icon(Icons.update),
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context).sseBottomMenu,
          icon: const Icon(Icons.list),
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context).webSocketMenu,
          icon: const Icon(Icons.web),
        ),
      ],
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      currentIndex: _currentTabIndex,
      onTap: (int newTabIndex) => _navigateToScreen(newTabIndex),
    );
  }
}
