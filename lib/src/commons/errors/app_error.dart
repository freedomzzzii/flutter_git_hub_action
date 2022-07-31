import '../../utils/error_code/error_code_util.dart';

abstract class AppError implements Error {
  String get message;

  AppErrorCodes get code;
}
