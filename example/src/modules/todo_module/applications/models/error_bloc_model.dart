import 'package:equatable/equatable.dart';

import '../../../../utils/error_code/error_code_util.dart';

class ErrorBlocModel extends Equatable {
  const ErrorBlocModel({
    required String message,
    required appErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final appErrorCodes _code;

  String get message => _message;

  appErrorCodes get code => _code;

  @override
  List<Object> get props => <Object>[_message, _code];
}
