import 'package:flutter_starter_kit/src/utils/grpc/grpc_util.dart';
import 'package:flutter_starter_kit/src/utils/test_data/mock_test_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(<Type>[GrpcClientUtil, ClientChannelBase])
void main() {
  group('GrpcClientUtilError Class', () {
    test('Should have GrpcClientUtilError Class', () {
      expect(GrpcClientUtilError, GrpcClientUtilError);
    });

    test('Should have mandatory properties', () {
      expect(expectGrpcClientUtilError.code, expectDataSourceError.code);
      expect(expectGrpcClientUtilError.message, expectDataSourceError.message);
    });
  });
}
