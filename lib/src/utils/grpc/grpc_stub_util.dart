import '../error_code/error_code_util.dart';
import 'grpc_util.dart';

GrpcClientUtil getGrpcClientUtil() => throw GrpcClientUtilError(
      message: 'GRPC is incompatibility with current platform',
      code: appErrorCodes.unknownError,
    );
