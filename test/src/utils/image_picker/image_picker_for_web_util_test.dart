@TestOn('browser')
import 'package:flutter_starter_kit/src/utils/image_picker/image_picker_for_web_util.dart';
import 'package:flutter_starter_kit/src/utils/image_picker/image_picker_util.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeImagePickerForWeb extends Fake implements ImagePickerUtilForWeb {
  @override
  Future<String?> getBase64Image() async {
    return expectTaskGetResponseEntity.imageUrl;
  }
}

class FakeImagePickerForWebFail extends Fake implements ImagePickerUtilForWeb {
  @override
  Future<String?> getBase64Image() async {
    throw ImagePickerUtilError(
      message: expectDataSourceError.message,
      code: expectDataSourceError.code,
    );
  }
}

void main() {
  group('ImagePickerForWeb Class', () {
    test('Should have ImagePickerError Class', () {
      expect(ImagePickerUtilForWeb, ImagePickerUtilForWeb);
    });

    test('Should have getBase64Image method - Success case', () async {
      final FakeImagePickerForWeb expectFakeImagePickerForWeb =
          FakeImagePickerForWeb();
      final String? expectValue =
          await expectFakeImagePickerForWeb.getBase64Image();

      expect(expectValue, expectTaskGetResponseEntity.imageUrl);
    });

    test('Should have getBase64Image method - Failure case', () async {
      final FakeImagePickerForWebFail expectImagePickerUtilForWeb =
          FakeImagePickerForWebFail();

      expect(
        () async => expectImagePickerUtilForWeb.getBase64Image(),
        throwsA(isA<ImagePickerUtilError>()),
      );
    });
  });
}