/// Response status code enum based on backend ResponseCode.java
enum ResponseCode {
  // ===================== Basic error code =====================
  // success
  success(200, "Success"),

  // Client Error (400-499)
  parameterError(400, "Parameter error"),
  unauthorized(401, "Unauthorized"),
  forbidden(403, "Illegal request"),
  notFound(404, "Resource not found"),
  methodNotAllowed(405, "Method not allowed"),
  requestTimeout(408, "Request timeout"),
  conflict(409, "Resource conflict"),
  unsupportedMediaType(415, "Unsupported media type"),
  tooManyRequests(429, "Too many requests"),

  // Server Error (500-599)
  internalError(500, "Internal error"),
  notImplemented(501, "Not implemented"),
  badGateway(502, "Bad gateway"),
  serviceUnavailable(503, "Service unavailable"),
  gatewayTimeout(504, "Gateway timeout"),

  // ==================== Business error codes (1000-1999) ====================
  // User-related errors (1000-1099)
  userNotFound(1000, "User not found"),
  userAlreadyExists(1001, "User already exists"),
  userAccountClosed(1002, "User account closed"),
  userAccountDisabled(1003, "User account disabled"),
  userPasswordIncorrect(1004, "User password incorrect"),
  userPasswordNotSet(1005, "User password not set"),
  userPasswordTooShort(1006, "Password too short"),
  userPasswordTooLong(1007, "Password too long"),
  userPhoneNotFound(1008, "User phone not found"),
  userNotAuthenticated(1009, "User not authenticated"),
  userNotLogin(1010, "User logout"),

  // Errors related to mobile phone numbers (1100-1199)
  invalidMobileFormat(1100, "Invalid mobile format"),
  mobileAlreadyRegistered(1101, "Mobile already registered"),
  mobileNotRegistered(1102, "Mobile not registered"),
  mobileVerificationFailed(1103, "Mobile verification failed"),

  // SMS verification code related errors (1200-1299)
  smsSendFailed(1200, "SMS send failed"),
  smsServiceError(1201, "SMS service error"),
  verificationCodeExpired(1202, "Verification code expired"),
  verificationCodeInvalid(1203, "Verification code invalid"),
  verificationCodeAlreadySent(1204, "Verification code already sent"),
  verificationCodeNotFound(1205, "Verification code not found"),
  verificationCodeTooFrequent(1206, "Verification code too frequent"),

  // Parameter validation errors (1300-1399)
  invalidParams(1300, "Invalid parameters"),
  requiredParamMissing(1301, "Required parameter missing"),
  paramFormatError(1302, "Parameter format error"),
  paramLengthError(1303, "Parameter length error"),
  paramValueError(1304, "Parameter value error"),

  // ID card OCR related errors (1400-1499)
  ocrServiceError(1400, "OCR service error"),
  ocrImageInvalid(1401, "OCR image invalid"),
  ocrImageTooLarge(1402, "OCR image too large"),
  ocrImageFormatError(1403, "OCR image format error"),
  ocrRecognitionFailed(1404, "OCR recognition failed"),
  ocrIdCardInvalid(1405, "OCR ID card invalid"),
  ocrFaceRecognitionFailed(1406, "OCR face recognition failed"),
  ocrLivenessDetectionFailed(1407, "OCR liveness detection failed"),
  ocrTokenFailed(1408, "OCR token failed"),

  // User information related errors (1500-1599)
  userInfoIncomplete(1500, "User information incomplete"),
  userInfoAlreadyUploaded(1501, "User information already uploaded"),
  userInfoUploadFailed(1502, "User information upload failed"),
  userInfoValidationFailed(1503, "User information validation failed"),
  userContactSameAsApplicant(1504, "Contact same as applicant"),
  userContactDuplicate(1505, "Contact duplicate"),
  userWorkInfoInvalid(1506, "User work information invalid"),
  userIncomeInfoInvalid(1507, "User income information invalid"),

  // Partner related errors (1600-1699)
  partnerNotFound(1600, "Partner not found"),
  partnerServiceError(1601, "Partner service error"),
  partnerApiError(1602, "Partner API error"),
  partnerConfigError(1603, "Partner configuration error"),
  partnerResponseError(1604, "Partner response error"),
  partnerTimeoutError(1605, "Partner timeout error"),
  partnerAuthError(1606, "Partner authentication error"),
  partnerRateLimitError(1607, "Partner rate limit error"),

  // Credit related errors (1700-1799)
  creditQueryFailed(1700, "Credit query failed"),
  creditApplicationFailed(1701, "Credit application failed"),
  creditAmountInvalid(1702, "Credit amount invalid"),
  creditPeriodInvalid(1703, "Credit period invalid"),
  creditPurposeInvalid(1704, "Credit purpose invalid"),
  creditLimitExceeded(1705, "Credit limit exceeded"),
  creditAlreadyApplied(1706, "Credit already applied"),
  creditStatusInvalid(1707, "Credit status invalid"),
  creditContractError(1708, "Credit contract error"),
  creditSubmitFailed(1709, "Credit submit failed"),

  // Bank related errors (1800-1899)
  bankNotFound(1800, "Bank not found"),
  bankListError(1801, "Bank list error"),
  bankBindFailed(1802, "Bank bind failed"),
  bankUnbindFailed(1803, "Bank unbind failed"),
  bankCardInvalid(1804, "Bank card invalid"),
  bankAccountInvalid(1805, "Bank account invalid"),
  bankVerificationFailed(1806, "Bank verification failed"),
  bankPartnerBindFailed(1807, "Bank partner bind failed"),

  // Order related errors (1900-1999)
  orderNotFound(1900, "Order not found"),
  orderCreateFailed(1901, "Order create failed"),
  orderStatusError(1902, "Order status error"),
  orderUpdateFailed(1903, "Order update failed"),
  orderCancelFailed(1904, "Order cancel failed"),
  orderRepaymentFailed(1905, "Order repayment failed"),
  orderContractError(1906, "Order contract error"),

  // ==================== System error code (2000-2999) ====================
  systemError(2000, "System error"),
  databaseError(2001, "Database error"),
  networkError(2002, "Network error"),
  configError(2003, "Configuration error"),
  redisServiceError(2004, "Redis service error"),
  jwtTokenError(2005, "JWT token error"),
  jwtTokenExpired(2006, "JWT token expired"),
  jwtTokenInvalid(2007, "JWT token invalid"),
  encryptionError(2008, "Encryption error"),
  decryptionError(2009, "Decryption error"),
  fileUploadError(2010, "File upload error"),
  fileDownloadError(2011, "File download error"),
  fileFormatError(2012, "File format error"),
  fileSizeError(2013, "File size error"),

  // ==================== Unknown error ====================
  unknownError(9999, "Unknown error");

  const ResponseCode(this.code, this.message);

  final int code;
  final String message;

  /// Get enum by status code
  static ResponseCode getByCode(int code) {
    for (ResponseCode responseCode in ResponseCode.values) {
      if (responseCode.code == code) {
        return responseCode;
      }
    }
    return ResponseCode.unknownError;
  }

  /// Get enum by string status code
  static ResponseCode getByCodeString(String codeStr) {
    try {
      int code = int.parse(codeStr);
      return getByCode(code);
    } catch (e) {
      return ResponseCode.unknownError;
    }
  }

  /// Check if status is success
  bool get isSuccess => this == ResponseCode.success;

  /// Check if status is client error
  bool get isClientError => code >= 400 && code < 500;

  /// Check if status is server error
  bool get isServerError => code >= 500 && code < 600;

  /// Check if status is business error
  bool get isBusinessError => code >= 1000 && code < 2000;

  /// Check if status is system error
  bool get isSystemError => code >= 2000 && code < 3000;

  /// Check if forced logout is required
  bool get requiresLogout {
    return [
      ResponseCode.unauthorized,
      ResponseCode.userNotAuthenticated,
      ResponseCode.userNotLogin,
      ResponseCode.jwtTokenExpired,
      ResponseCode.jwtTokenInvalid,
      ResponseCode.jwtTokenError,
    ].contains(this);
  }

  /// Check if re-authentication is required
  bool get requiresReauth {
    return [
      ResponseCode.userPasswordIncorrect,
      ResponseCode.verificationCodeExpired,
      ResponseCode.verificationCodeInvalid,
      ResponseCode.mobileVerificationFailed,
    ].contains(this);
  }
}
