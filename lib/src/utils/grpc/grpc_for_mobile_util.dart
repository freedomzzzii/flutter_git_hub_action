import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';

import '../error_code/error_code_util.dart';
import 'grpc_util.dart';

class GrpcClientUtilForMobile implements GrpcClientUtil {
  @override
  ClientChannelBase createChannel({required String host, required int port}) {
    try {
      return ClientChannel(
        host,
        port: port,
        options: ChannelOptions(
          credentials: const ChannelCredentials.insecure(),
          codecRegistry: CodecRegistry(
            codecs: <Codec>[const GzipCodec(), const IdentityCodec()],
          ),
        ),
      );
    } catch (e) {
      throw GrpcClientUtilError(
        message: e.toString(),
        code: AppErrorCodes.unknownError,
      );
    }
  }
}

GrpcClientUtil getGrpcClientUtil() => GrpcClientUtilForMobile();
