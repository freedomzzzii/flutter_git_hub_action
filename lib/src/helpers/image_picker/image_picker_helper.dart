import '../../commons/errors/app_error.dart';
import '../../utils/error_code_util.dart';
import 'image_picker_stub_helper.dart'
    if (dart.library.io) 'image_picker_for_mobile_helper.dart'
    if (dart.library.html) 'image_picker_for_web_helper.dart';

/// Base class for ImagePicker on mobile and web
abstract class ImagePickerUtil {
  /// Constructor
  factory ImagePickerUtil() => getImagePickerUtil();

  /// Get image and convert image to base64
  Future<String?> getBase64Image() => _getBase64Image();

  Future<String?> _getBase64Image();
}

///
class ImagePickerUtilError implements AppError {
  ///
  ImagePickerUtilError({
    required String message,
    required appErrorCodes code,
  })  : _message = message,
        _code = code;

  final String _message;
  final appErrorCodes _code;

  /// errorContext is title error message
  static const String errorContext = 'Error in image picker util:';

  @override
  String get message => _message;

  @override
  appErrorCodes get code => _code;

  @override
  StackTrace? get stackTrace => throw '$errorContext $stackTrace';

  @override
  String toString() => '$errorContext code: $_code, message: $_message';
}
