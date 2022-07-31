import 'package:get/get.dart';

import '../../commons/errors/app_error.dart';
import '../../configs/error_messages/error_message_config.dart';
import '../../core/navigation/navigation_core.dart';
import '../../utils/error_code/error_code_util.dart';
import '../app_module.dart';
import 'configs/routes/route_config.dart';
import 'presentations/screens/common_not_found_screen.dart';

class CommonModule implements Module {
  @override
  String get mainPath => commonMainPath;

  @override
  List<SubPath> get subPaths => <SubPath>[commonNotFoundPath];

  @override
  String getFullPath({
    required SubPath subPath,
    Map<String, String>? replaceParameters,
    String? params,
  }) {
    try {
      final bool result = subPaths.contains(subPath);

      if (result) {
        return combinePath(
          mainPath: mainPath,
          subPath: subPath,
          replaceParameters: replaceParameters,
          params: params,
        );
      }

      navigationGetX.replace(getFullPath(subPath: commonNotFoundPath));
      throw NavigationError(
        message: cannotFindPathToNavigate,
        code: AppErrorCodes.resourceNotFound,
      );
    } catch (e) {
      if (e is NavigationError && e.message != cannotFindPathToNavigate) {
        navigationGetX.replace(getFullPath(subPath: commonNotFoundPath));
      }

      throw NavigationError(
        message: e is AppError ? e.message : e.toString(),
        code: AppErrorCodes.resourceNotFound,
      );
    }
  }

  @override
  List<GetPage<Map<String, dynamic>>> get routeScreen =>
      <GetPage<Map<String, dynamic>>>[
        GetPage<Map<String, dynamic>>(
          name: getFullPath(subPath: commonNotFoundPath),
          page: () => const CommonNotFoundScreen(),
        ),
      ];
}
