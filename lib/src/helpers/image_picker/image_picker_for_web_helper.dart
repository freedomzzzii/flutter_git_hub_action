import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker_web/image_picker_web.dart';

import '../../utils/error_code_util.dart';
import 'image_picker_helper.dart';

class ImagePickerUtilForWeb implements ImagePickerUtil {
  @override
  Future<String?> getBase64Image() async {
    try {
      final Object? image =
          await ImagePickerWeb.getImage(outputType: ImageType.bytes);

      if (image != null) {
        return const Base64Codec().encode(image as Uint8List);
      }
    } catch (e) {
      throw ImagePickerUtilError(
        message: e.toString(),
        code: appErrorCodes.unknownError,
      );
    }
  }
}

ImagePickerUtil getImagePickerUtil() => ImagePickerUtilForWeb();
