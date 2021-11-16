enum appErrorCodes { missingRequiredFields, resourceNotFound, unknownError }

appErrorCodes getAppErrorCode({required dynamic code}) {
  switch (code) {
    case 400:
      return appErrorCodes.missingRequiredFields;
    case 404:
      return appErrorCodes.resourceNotFound;
    default:
      return appErrorCodes.unknownError;
  }
}
