import '../../../../commons/errors/app_error.dart';
import '../../../../utils/error_code/error_code_util.dart';

class TaskCreateUseCaseError implements AppError {
  TaskCreateUseCaseError({
    required String message,
    required appErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final appErrorCodes _code;

  static const String errorContext = 'Error in create task use case:';

  @override
  String get message => _message;

  @override
  appErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace => throw '$errorContext $stackTrace';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}

class TaskGetUseCaseError implements AppError {
  TaskGetUseCaseError({
    required String message,
    required appErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final appErrorCodes _code;

  static const String errorContext = 'Error in get task use case:';

  @override
  String get message => _message;

  @override
  appErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace => throw '$errorContext $stackTrace';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}

class TaskUpdateUseCaseError implements AppError {
  TaskUpdateUseCaseError({
    required String message,
    appErrorCodes code = appErrorCodes.unknownError,
  })  : _message = message,
        _code = code;

  final String _message;
  final appErrorCodes _code;
  static const String errorContext = 'Error in update task use case:';

  @override
  String get message => _message;

  @override
  appErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace =>
      throw '$errorContext code: $_code, message: $_message';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}

class TaskDeleteUseCaseError implements AppError {
  TaskDeleteUseCaseError({
    required String message,
    appErrorCodes code = appErrorCodes.unknownError,
  })  : _message = message,
        _code = code;

  final String _message;
  final appErrorCodes _code;

  static const String errorContext = 'Error in delete task use case:';

  @override
  String get message => _message;

  @override
  appErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace =>
      throw '$errorContext code: $_code, message: $_message';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}

class TaskStreamGetUseCaseError implements AppError {
  TaskStreamGetUseCaseError({
    required String message,
    appErrorCodes code = appErrorCodes.unknownError,
  })  : _message = message,
        _code = code;

  final String _message;
  final appErrorCodes _code;

  static const String errorContext = 'Error in stream get use case:';

  @override
  String get message => _message;

  @override
  appErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace =>
      throw '$errorContext code: $_code, message: $_message';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}

class TaskSendDataUseCaseError implements AppError {
  TaskSendDataUseCaseError({
    required String message,
    appErrorCodes code = appErrorCodes.unknownError,
  })  : _message = message,
        _code = code;

  final String _message;
  final appErrorCodes _code;

  static const String errorContext = 'Error in task send data use case:';

  @override
  String get message => _message;

  @override
  appErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace =>
      throw '$errorContext code: $_code, message: $_message';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}

class TaskDisconnectUseCaseError implements AppError {
  TaskDisconnectUseCaseError({
    required String message,
    appErrorCodes code = appErrorCodes.unknownError,
  })  : _message = message,
        _code = code;

  final String _message;
  final appErrorCodes _code;

  static const String errorContext = 'Error in task disconnect use case:';

  @override
  String get message => _message;

  @override
  appErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace =>
      throw '$errorContext code: $_code, message: $_message';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}
