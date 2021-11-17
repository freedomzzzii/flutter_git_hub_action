import '../error_code/error_code_util.dart';
import 'image_picker_util.dart';

ImagePickerUtil getImagePickerUtil() => throw ImagePickerUtilError(
  message: 'Image Picker function incompatibility with current platform',
      code: appErrorCodes.unknownError,
    );
