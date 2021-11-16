import 'package:flutter_starter_kit/src/utils/grpc/grpc_for_mobile_util.dart';
import 'package:flutter_starter_kit/src/utils/grpc/grpc_util.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:mockito/annotations.dart';

class FakeGrpcClientUtilForMobileFail extends Fake
    implements GrpcClientUtilForMobile {
  @override
  ClientChannelBase createChannel({required String host, required int port}) {
    throw GrpcClientUtilError(
      message: expectDataSourceError.message,
      code: expectDataSourceError.code,
    );
  }
}

@GenerateMocks(<Type>[ClientChannel])
void main() {
  group('GrpcClientUtilForMobile Class', () {
    test('Should have GrpcClientUtilForMobile Class', () {
      expect(GrpcClientUtilForMobile, GrpcClientUtilForMobile);
    });

    test('Should have createChannel method - Success case', () async {
      expect(
        GrpcClientUtilForMobile().createChannel(
          host: expectTaskGetResponseEntity.title,
          port: 123,
        ),
        isA<ClientChannelBase>(),
      );
    });

    test('Should have createChannel method - Failure case', () async {
      final FakeGrpcClientUtilForMobileFail expectGrpcClientUtilForMobile =
          FakeGrpcClientUtilForMobileFail();

      expect(
        () => expectGrpcClientUtilForMobile.createChannel(
          host: expectTaskGetResponseEntity.title,
          port: 123,
        ),
        throwsA(isA<GrpcClientUtilError>()),
      );

      expect(
        () => expectGrpcClientUtilForMobile.createChannel(
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
