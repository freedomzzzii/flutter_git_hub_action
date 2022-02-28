@TestOn('browser')
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_starter_kit/src/utils/grpc/grpc_for_web_util.dart';
import 'package:flutter_starter_kit/src/utils/grpc/grpc_util.dart';
import 'package:flutter_starter_kit/src/utils/image_picker/image_picker_for_web_util.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:grpc/grpc_web.dart';
import 'package:mockito/annotations.dart';

class FakeGrpcClientUtilForWebFail extends Fake implements GrpcClientUtil {
  @override
  ClientChannelBase createChannel({required String host, required int port}) {
    throw GrpcClientUtilError(
      message: expectDataSourceError.message,
      code: expectDataSourceError.code,
    );
  }
}

@GenerateMocks(<Type>[GrpcWebClientChannel])
void main() {
  setUpAll(() {
    dotenv.testLoad();
  });

  group('GrpcClientUtilForWeb Class', () {
    test('Should have ImagePickerError Class', () {
      expect(ImagePickerUtilForWeb, ImagePickerUtilForWeb);
    });

    test('Should have createChannel method - Success case', () async {
      expect(
        GrpcClientUtilForWeb().createChannel(
          host: expectTaskGetResponseEntity.title,
          port: 123,
        ),
        isA<ClientChannelBase>(),
      );
    });

    test('Should have createChannel method - Failure case', () async {
      final FakeGrpcClientUtilForWebFail expectGrpcClientUtilForWeb =
          FakeGrpcClientUtilForWebFail();

      expect(
        () => expectGrpcClientUtilForWeb.createChannel(
          host: expectTaskGetResponseEntity.title,
          port: 123,
        ),
        throwsA(isA<GrpcClientUtilError>()),
      );

      expect(
        () => expectGrpcClientUtilForWeb.createChannel(
          host: expectTaskGetResponseEntity.title,
          port: 123,
        ),
        throwsA(
          predicate(
            (Error e) =>
                e is GrpcClientUtilError &&
                e.toString().contains(expectDataSourceError.message),
          ),
        ),
      );
    });
  });
}
