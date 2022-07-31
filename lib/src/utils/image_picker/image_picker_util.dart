import '../../commons/errors/app_error.dart';
import '../error_code/error_code_util.dart';
import 'image_picker_stub_util.dart'
    if (dart.library.io) 'image_picker_for_mobile_util.dart'
    if (dart.library.html) 'image_picker_for_web_util.dart';

abstract class ImagePickerUtil {
  factory ImagePickerUtil() => getImagePickerUtil();

  Future<String?> getBase64Image() => _getBase64Image();

  Future<String?> _getBase64Image();
}

class ImagePickerUtilError implements AppError {
  ImagePickerUtilError({
    required String message,
    required AppErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final AppErrorCodes _code;

  static const String errorContext = 'Error in image picker util:';

  @override
  String get message => _message;

  @override
  AppErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace => throw '$errorContext $stackTrace';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}
