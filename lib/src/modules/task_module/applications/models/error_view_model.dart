import 'package:equatable/equatable.dart';

import '../../../../utils/error_code/error_code_util.dart';

class ErrorViewModel extends Equatable {
  const ErrorViewModel({
    required String message,
    required AppErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final AppErrorCodes _code;

  String get message => _message;

  AppErrorCodes get code => _code;

  @override
  List<Object> get props => <Object>[_message, _code];
}
