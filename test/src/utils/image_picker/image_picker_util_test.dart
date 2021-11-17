import 'package:flutter_starter_kit/src/utils/image_picker/image_picker_util.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(<Type>[ImagePickerUtil])
void main() {
  group('ImagePickerUtilError Class', () {
    test('Should have ImagePickerUtilError Class', () {
      expect(ImagePickerUtilError, ImagePickerUtilError);
    });

    test('Should have mandatory properties', () {
      expect(expectImagePickerError.code, expectDataSourceError.code);
      expect(expectImagePickerError.message, expectDataSourceError.message);
    });
  });
}
