import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker_web/image_picker_web.dart';

import '../error_code/error_code_util.dart';
import 'image_picker_util.dart';

class ImagePickerUtilForWeb implements ImagePickerUtil {
  @override
  Future<String?> getBase64Image() async {
    try {
      final Uint8List? image =
          await ImagePickerWeb.getImageAsBytes();

      if (image != null) {
        return const Base64Codec().encode(image);
      }

      return null;
    } catch (e) {
      throw ImagePickerUtilError(
        message: e.toString(),
        code: AppErrorCodes.unknownError,
      );
    }
  }
}

ImagePickerUtil getImagePickerUtil() => ImagePickerUtilForWeb();
