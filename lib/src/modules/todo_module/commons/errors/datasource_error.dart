import '../../../../commons/errors/app_error.dart';
import '../../../../utils/error_code_util.dart';

class DataSourceError implements AppError {
  DataSourceError({
    required String message,
    required appErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final appErrorCodes _code;

  static const String errorContext = 'Error in data source:';

  @override
  String get message => _message;

  @override
  appErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace => throw '$errorContext $stackTrace';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}
