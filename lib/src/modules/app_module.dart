import 'package:get/get.dart';

import '../core/navigation/navigation_core.dart';
import '../helpers/check_os/check_os_helper.dart';
import '../utils/firebase/firebase_message_util.dart';
import 'common_module/common_module.dart';
import 'task_module/task_module.dart';

final TaskModule taskModule = TaskModule();
final CommonModule commonModule = CommonModule();

final List<GetPage<Map<String, dynamic>>> allRouteScreen =
    <GetPage<Map<String, dynamic>>>[
  ...taskModule.routeScreen,
  ...commonModule.routeScreen,
];

abstract class Module {
  List<GetPage<Map<String, dynamic>>> get routeScreen =>
      <GetPage<Map<String, dynamic>>>[];

  List<SubPath> get subPaths => <SubPath>[];

  String get mainPath => '';

  String getFullPath({
    required SubPath subPath,
    Map<String, String>? replaceParameters,
    String? params,
  }) =>
      '';
}

class AppBinding implements Bindings {
  AppBinding({required OsCodes os}) : _os = os;

  final OsCodes _os;

  OsCodes get os => _os;

  @override
  void dependencies() {
    Get.put<FirebaseMessagingUtil>(initFbMessaging(_os));
    Get.put<OsCodes>(_os);
  }
}
