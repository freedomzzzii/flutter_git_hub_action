import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:grpc/grpc_web.dart';

import '../../commons/constants/env_constant.dart';
import '../error_code/error_code_util.dart';
import 'grpc_util.dart';

class GrpcClientUtilForWeb implements GrpcClientUtil {
  @override
  ClientChannelBase createChannel({required String host, required int port}) {
    try {
      return GrpcWebClientChannel.xhr(
        Uri.parse('${dotenv.env[grpcWebSchemeEnv]}://$host:$port'),
      );
    } catch (e) {
      throw GrpcClientUtilError(
        message: e.toString(),
        code: AppErrorCodes.unknownError,
      );
    }
  }
}

GrpcClientUtil getGrpcClientUtil() => GrpcClientUtilForWeb();
