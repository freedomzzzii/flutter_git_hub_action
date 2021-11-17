import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:poc_clean_arch/src/helpers/image_picker/image_picker_helper.dart';

import '../../../test_data/mock_test_data.dart';

@GenerateMocks(<Type>[ImagePickerUtil])
void main() {
  group('ImagePickerError Class', () {
    test('Should have ImagePickerError Class', () {
      expect(ImagePickerUtilError, ImagePickerUtilError);
    });

    test('Should have mandatory properties', () {
      expect(expectImagePickerError.code, expectDataSourceError.code);
      expect(expectImagePickerError.message, expectDataSourceError.message);
    });
  });
}
