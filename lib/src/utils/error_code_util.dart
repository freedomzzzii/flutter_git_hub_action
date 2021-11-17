import '../commons/constants/api_constant.dart';

enum appErrorCodes { missingRequiredFields, resourceNotFound, unknownError }

appErrorCodes getAppErrorCode({required dynamic code}) {
  switch (code) {
    case 400:
    case errorRequireFieldCodeAPI:
      return appErrorCodes.missingRequiredFields;
    case 404:
      return appErrorCodes.resourceNotFound;
    default:
      return appErrorCodes.unknownError;
  }
}
