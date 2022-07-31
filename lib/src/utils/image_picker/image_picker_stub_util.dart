import '../error_code/error_code_util.dart';
import 'image_picker_util.dart';

ImagePickerUtil getImagePickerUtil() => throw ImagePickerUtilError(
      message: 'Error cannot use package `image_picker` and `image_picker_web`',
      code: AppErrorCodes.unknownError,
    );
