import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

import '../../commons/errors/app_error.dart';
import '../../configs/error_messages/error_message_config.dart';
import '../../utils/error_code/error_code_util.dart';

enum OsCodes { web, android, ios }

OsCodes getOs() {
  try {
    if (kIsWeb) {
      return OsCodes.web;
    } else if (Platform.isAndroid) {
      return OsCodes.android;
    } else if (Platform.isIOS) {
      return OsCodes.ios;
    }

    throw GetOsError(
      code: AppErrorCodes.unknownError,
      message: cannotDetectOsMessage,
    );
  } catch (e) {
    throw GetOsError(
      code: AppErrorCodes.unknownError,
      message: e.toString(),
    );
  }
}

class GetOsError implements AppError {
  GetOsError({
    required String message,
    required AppErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final AppErrorCodes _code;

  static const String errorContext =
      'An error occurred in the check os function:';

  @override
  String get message => _message;

  @override
  AppErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace => throw '$errorContext $stackTrace';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}
