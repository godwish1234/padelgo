class EndPoint {
  // application config
  static String appConfig = '/api/v2/config/';
  static String createAppConfig = '/api/v2/config';
  static String deleteAppConfig = '/api/v2/config/';

  // Authentication
  static String sendOtp = '/api/v2/sms/send-code';
  static String login = '/api/v2/auth/login';
  static String sendOtpWhatsapp = '/api/v2/whatsapp/send-code';
  static String loginWhatsapp = '/api/v2/auth/login-whatsapp';
  static String loginStatus = '/api/v2/auth/check-login';
  static String refreshToken = '/api/v2/auth/refresh-token';
  static String tokenStatus = '/api/v2/auth/token-status';
  static String logout = '/api/v2/auth/logout';

  // User status
  static String uploadStatus = '/api/v2/user-center/upload-status';
  static String bankBindStatus = '/api/v2/user-center/bank-bind-status';

  // User application
  static String saveUserApps = '/api/v2/user-apps/save';
  static String getUserApps = '/api/v2/user-apps/';
  static String uploadDevice = '/api/v2/device/upload';
  static String uploadFCMToken = '/api/v2/user-center/upload-fcm-token';

  // Enumerations
  static String getAreas = '/api/v2/area/areas';
  static String getEnums = '/api/v2/enums/all';
  static String getReligions = '/api/v2/enums/religions';
  static String getEducations = '/api/v2/enums/education-levels';
  static String getWorkExp = '/api/v2/enums/work-experiences';
  static String getWorkTypes = '/api/v2/enums/work-types';

  // partner
  static String getBankListSave = '/api/v2/partner/bank-list-partner';
  static String partnerList = '/api/v2/partner/api-list';
  static String getBankListDb = '/api/v2/partner/bank-list-db';
  static String getPartnerInfo = '/api/v2/partner/info/';
  static String queryCreditStatus = '/api/v2/partner/query-credit-status';
  static String apiPartnerInfo = '/api/v2/partner/partner-info';
  static String processApi = '/api/v2/partner/process-api';
  static String uploadToNewPartner = '/api/v2/partner/upload-to-new-partners';
  static String queryLoanProducts = '/api/v2/partner/query-loan-products';
  static String partnerContract = '/api/v2/partner/contract';
  static String partnerContractRecord = '/api/v2/partner/contract-records';
  static String partnerContractRecordStatus =
      '/api/v2/partner/contract-records/status/';
  static String submitLoan = '/api/v2/partner/submit-loan';
  static String loanPurposes = '/api/v2/partner/loan-purposes';
  static String bindCardRecords = '/api/v2/partner/bind-card-records';

  // user center
  static String uploadUserInfo = '/api/v2/user-center/uploadUserInfo';
  static String validateContacts = '/api/v2/user-center/validate-contacts';
  static String userBindBank = '/api/v2/user-center/bind-bank-card';
  static String userBank = '/api/v2/user-center/get-bank-card-list';
  static String updateRating = '/api/v2/user-center/updateRating';

  // loan
  static String searchLoanProducts = '/api/v2/loan/products/query';
  static String getLoanContract = '/api/v2/loan/contract';
  static String previewLoan = '/api/v2/loan/preview';
  static String submit = '/api/v2/loan/submit';

  // bank
  static String saveBankList = '/api/v2/bank/partner-list-save';
  static String getBankList = '/api/v2/bank/partner-list-db';
  static String getBankCardRecords = '/api/v2/bank/get_bind-card-records';
  static String bindBank = '/api/v2/bank/bind-bank-card';
  static String deleteBank = '/api/v2/bank/delete-bank-card';
  static String defaultBank = '/api/v2/bank/default-bank-card';

  // order
  static String orderStatus = '/api/v2/order/query_status';

  // credit
  static String creditStatus = '/api/v2/credit/query-credit-status';

  // repayment plan
  static String repaymentPlan = '/api/v2/repayment/query-repay-plan';
  static String repaymentDetails = '/api/v2/repay-details/from-partner';

  // OCR
  static String ocrToken = '/api/v2/ocr/license-token';
  static String ocrCheck = '/api/v2/ocr/check';
  static String livenessCheck = '/api/v2/ocr/liveness-check';
  static String faceRecog = '/api/v2/ocr/face-recognition';

  static String termPrivacy = '/agreement/agreement/uangme-privacy-screen';

  // CPI
  static String cpiProducts = '/api/v2/cpi-partner/enabled';
  static String homePartner = '/api/v2/cpi-partner/indexPartnerList';

  // close account
  static String closeAccount = '/api/v2/user-center/close-account';
}
