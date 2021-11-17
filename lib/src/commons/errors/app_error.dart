import '../../utils/error_code_util.dart';

abstract class AppError implements Error {
  String get message;

  appErrorCodes get code;
}
