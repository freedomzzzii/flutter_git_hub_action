import 'package:get/get.dart';

import '../../commons/errors/app_error.dart';
import '../../configs/error_messages/error_message_config.dart';
import '../../utils/error_code/error_code_util.dart';

abstract class Navigation {
  /// navigate to next screen
  void push(String path);

  /// navigate to previous screen
  void pop();

  /// navigate and remove all previous screens from the tree.
  void replaceAll(String path);

  /// navigate and remove the previous screen from the tree
  void replace(String path);
}

final NavigationGetX navigationGetX = NavigationGetX();

class NavigationGetX implements Navigation {
  @override
  void pop() => Get.back();

  @override
  void push(String path) => Get.toNamed(path);

  @override
  void replaceAll(String path) => Get.offAllNamed(path);

  @override
  void replace(String path) => Get.offNamed(path);
}

class SubPath {
  SubPath({required String name, required String path})
      : _name = name,
        _path = path;

  final String _name;
  final String _path;

  String get name => _name;

  String get path => _path;
}

String combinePath({
  required String mainPath,
  required SubPath subPath,
  Map<String, String>? replaceParameters,
  String? params,
}) {
  try {
    String path = params == null
        ? '$mainPath${subPath.path}'
        : '$mainPath${subPath.path}?$params';

    if (replaceParameters != null) {
      replaceParameters.forEach((String key, String value) {
        if (!path.contains(key)) {
          throw NavigationError(
            code: AppErrorCodes.unknownError,
            message: cannotReplaceParameter,
          );
        }

        path = path.replaceAll(':$key', value);
      });
    }

    return path;
  } catch (e) {
    throw NavigationError(
      code: AppErrorCodes.unknownError,
      message: e is NavigationError ? e.message : cannotCombinePath,
    );
  }
}

class NavigationError implements AppError {
  NavigationError({
    required String message,
    required AppErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final AppErrorCodes _code;

  static const String errorContext = 'An error occurred in the navigation:';

  @override
  String get message => _message;

  @override
  AppErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace => throw '$errorContext $stackTrace';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}
