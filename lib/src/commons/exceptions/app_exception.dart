import '../../utils/error_code_util.dart';

abstract class AppException implements Exception {
  String get message;

  appErrorCodes get code;
}
