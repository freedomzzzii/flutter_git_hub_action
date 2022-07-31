import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../error_code/error_code_util.dart';
import 'image_picker_util.dart';

class ImagePickerUtilForMobile implements ImagePickerUtil {
  ImagePickerUtilForMobile({required ImagePicker imagePicker})
      : _imagePicker = imagePicker;

  final ImagePicker _imagePicker;

  ImagePicker get imagePicker => _imagePicker;

  @override
  Future<String?> getBase64Image() async {
    try {
      final XFile? _image =
          await _imagePicker.pickImage(source: ImageSource.gallery);

      if (_image?.path != null) {
        final List<int> imageBytes = await File(_image!.path).readAsBytes();

        return base64Encode(imageBytes);
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

ImagePickerUtil getImagePickerUtil() =>
    ImagePickerUtilForMobile(imagePicker: ImagePicker());
