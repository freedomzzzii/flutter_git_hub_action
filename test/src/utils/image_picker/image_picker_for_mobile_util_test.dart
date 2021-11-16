@TestOn('!browser')
import 'dart:io';

import 'package:flutter_starter_kit/src/utils/image_picker/image_picker_for_mobile_util.dart';
import 'package:flutter_starter_kit/src/utils/image_picker/image_picker_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'image_picker_for_mobile_util_test.mocks.dart';

@GenerateMocks(<Type>[ImagePicker])
void main() {
  final MockImagePicker mockImagePicker = MockImagePicker();
  final ImagePickerUtilForMobile expectImagePickerUtil =
      ImagePickerUtilForMobile(imagePicker: mockImagePicker);

  Directory directory = Directory.current;
  const String pathImage = '/test/test_resource/test_image.png';
  late XFile expectImage;
  late String expectImagePath;

  setUpAll(() async {
    while (!await directory.list().any(
          (FileSystemEntity entity) => entity.path.endsWith('pubspec.yaml'),
        )) {
      directory = directory.parent;
    }

    expectImagePath = '${directory.path}$pathImage';
    expectImage = XFile(expectImagePath);
  });

  tearDown(() {
    clearInteractions(mockImagePicker);
  });

  group('ImagePickerUtilForMobile Class', () {
    test('Should have ImagePickerUtilForMobile Class', () {
      expect(ImagePickerUtilForMobile, ImagePickerUtilForMobile);
    });

    test('Should have mandatory properties', () {
      expect(expectImagePickerUtil.imagePicker, mockImagePicker);
    });

    test('Should have getImage method - Success case', () async {
      when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) => Future<XFile>.value(expectImage));

      final String? expectSelectImageFromDevice =
          await expectImagePickerUtil.getBase64Image();

      expect(expectSelectImageFromDevice?.isNotEmpty, true);
    });

    test('Should have getImage method - Failure case', () async {
      when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenThrow(UnimplementedError());

      expect(
        () async => expectImagePickerUtil.getBase64Image(),
        throwsA(isA<ImagePickerUtilError>()),
      );

      verify(mockImagePicker.pickImage(source: ImageSource.gallery)).called(1);
    });
  });
}
