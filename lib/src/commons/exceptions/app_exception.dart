import '../../utils/error_code/error_code_util.dart';

abstract class AppException implements Exception {
  String get message;

  AppErrorCodes get code;
}
