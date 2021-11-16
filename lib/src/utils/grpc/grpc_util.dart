import 'package:grpc/grpc_connection_interface.dart';

import '../../commons/errors/app_error.dart';
import '../error_code/error_code_util.dart';
import 'grpc_stub_util.dart'
    if (dart.library.io) 'grpc_for_mobile_util.dart'
    if (dart.library.html) 'grpc_for_web_util.dart';

abstract class GrpcClientUtil {
  factory GrpcClientUtil() => getGrpcClientUtil();

  ClientChannelBase createChannel({required String host, required int port});
}

class GrpcClientUtilError implements AppError {
  GrpcClientUtilError({
    required String message,
    required appErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final appErrorCodes _code;

  static const String errorContext = 'Error in grpc client util:';

  @override
  String get message => _message;

  @override
  appErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace => throw '$errorContext $stackTrace';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}
