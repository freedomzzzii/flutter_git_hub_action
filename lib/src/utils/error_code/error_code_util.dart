import '../../commons/constants/api_constant.dart';

enum AppErrorCodes { missingRequiredFields, resourceNotFound, unknownError }

AppErrorCodes getAppErrorCode({required dynamic code}) {
  switch (code) {
    case 400:
    case errorRequireFieldCodeAPI:
      return AppErrorCodes.missingRequiredFields;
    case 404:
      return AppErrorCodes.resourceNotFound;
    default:
      return AppErrorCodes.unknownError;
  }
}
