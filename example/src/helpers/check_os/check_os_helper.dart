import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

import '../../commons/errors/app_error.dart';
import '../../configs/error_messages/error_message_config.dart';
import '../../utils/error_code/error_code_util.dart';

enum osCodes { web, android, ios }

osCodes getOs() {
  try {
    if (kIsWeb) {
      return osCodes.web;
    } else if (Platform.isAndroid) {
      return osCodes.android;
    } else if (Platform.isIOS) {
      return osCodes.ios;
    }

    throw GetOsError(
      code: appErrorCodes.unknownError,
      message: cannotDetectOsMessage,
    );
  } catch (e) {
    throw GetOsError(
      code: appErrorCodes.unknownError,
      message: e.toString(),
    );
  }
}

class GetOsError implements AppError {
  GetOsError({
    required String message,
    required appErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final appErrorCodes _code;

  static const String errorContext = 'Error in function check os:';

  @override
  String get message => _message;

  @override
  appErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace => throw '$errorContext $stackTrace';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}
