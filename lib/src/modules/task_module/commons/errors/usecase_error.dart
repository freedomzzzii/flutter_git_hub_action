import '../../../../commons/errors/app_error.dart';
import '../../../../utils/error_code/error_code_util.dart';

class TaskCreateUseCaseError implements AppError {
  TaskCreateUseCaseError({
    required String message,
    required AppErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final AppErrorCodes _code;

  static const String errorContext = 'Error in create task use case:';

  @override
  String get message => _message;

  @override
  AppErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace => throw '$errorContext $stackTrace';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}

class TaskGetUseCaseError implements AppError {
  TaskGetUseCaseError({
    required String message,
    required AppErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final AppErrorCodes _code;

  static const String errorContext = 'Error in get task use case:';

  @override
  String get message => _message;

  @override
  AppErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace => throw '$errorContext $stackTrace';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}

class TaskUpdateUseCaseError implements AppError {
  TaskUpdateUseCaseError({
    required String message,
    AppErrorCodes code = AppErrorCodes.unknownError,
  })  : _message = message,
        _code = code;

  final String _message;
  final AppErrorCodes _code;
  static const String errorContext = 'Error in update task use case:';

  @override
  String get message => _message;

  @override
  AppErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace =>
      throw '$errorContext code: $_code, message: $_message';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}

class TaskDeleteUseCaseError implements AppError {
  TaskDeleteUseCaseError({
    required String message,
    AppErrorCodes code = AppErrorCodes.unknownError,
  })  : _message = message,
        _code = code;

  final String _message;
  final AppErrorCodes _code;

  static const String errorContext = 'Error in delete task use case:';

  @override
  String get message => _message;

  @override
  AppErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace =>
      throw '$errorContext code: $_code, message: $_message';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}
