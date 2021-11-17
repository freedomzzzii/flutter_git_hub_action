import '../../../../commons/exceptions/app_exception.dart';
import '../../../../utils/error_code_util.dart';

class FieldRequiredException implements AppException {
  const FieldRequiredException({
    required String message,
    required appErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final appErrorCodes _code;

  static const String exceptionContext = 'Exception required field:';

  @override
  String get message => _message;

  @override
  appErrorCodes get code => _code;

  @override
  String toString() => '$exceptionContext code: $_code $_message is required';
}

class FieldValidationException implements AppException {
  const FieldValidationException({
    required String message,
    required appErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final appErrorCodes _code;

  static const String exceptionContext = 'Exception validation field:';

  @override
  String get message => _message;

  @override
  appErrorCodes get code => _code;

  @override
  String toString() => '$exceptionContext code: $_code $_message is empty';
}
