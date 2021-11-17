import '../../utils/error_code_util.dart';
import 'image_picker_helper.dart';

ImagePickerUtil getImagePickerUtil() => throw ImagePickerUtilError(
      message: 'Error cannot use package `image_picker` and `image_picker_web`',
      code: appErrorCodes.unknownError,
    );
