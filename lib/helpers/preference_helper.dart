import 'package:shared_preferences/shared_preferences.dart';

class PkPreferenceHelper {
  static const String _GAID_KEY = "gaid_key";

  static Future<void> saveGaid(String gaid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_GAID_KEY, gaid);
  }

  static Future<String?> getGaid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_GAID_KEY);
  }

  static Future<void> clearGaid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_GAID_KEY);
  }

  static saveFirstInstallation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("loan_firstInstallation", true);
  }

  static Future<bool> getFirstInstallation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("loan_firstInstallation") ?? true;
  }

  static setCommitedProtocol() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("loan_first_commit_protocol", false);
  }

  static Future<bool> isFirstCommitProtocol() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("loan_first_commit_protocol") ?? true;
  }

  static Future<int> getEnv() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? env = prefs.getInt("loan_env");
    return env ?? 1;
  }

  static saveEnv(int env) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("loan_env", env);
  }

  static const String _NEW_ORDER_BADGE_COUNT_KEY = "new_order_badge_count";

  static Future<int> getNewOrderBadgeCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload(); // Force reload from disk
    return prefs.getInt(_NEW_ORDER_BADGE_COUNT_KEY) ?? 0;
  }

  static Future<void> incrementNewOrderBadgeCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final currentCount = prefs.getInt(_NEW_ORDER_BADGE_COUNT_KEY) ?? 0;
    final newCount = currentCount + 1;
    await prefs.setInt(_NEW_ORDER_BADGE_COUNT_KEY, newCount);
    await prefs.commit();
  }

  static Future<void> clearNewOrderBadgeCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_NEW_ORDER_BADGE_COUNT_KEY, 0);
    await prefs.commit();
  }

  static Future<String> getFingerprint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("finger_print") ?? "";
  }

  static saveFingerprint(String fingerPrint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("finger_print", fingerPrint);
  }

  static Future<bool> isUseProxy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("loan_is_use_proxy") ?? false;
  }

  static Future<bool> setUseProxy(bool isProxy) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("loan_is_use_proxy", isProxy);
  }

  static Future<bool> isShowUnexpectedDialog(String loanId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("loan_is_show_unexpected_dialog$loanId") ?? true;
  }

  static Future<bool> setShowReleaseFailedDialog(
      String loanId, bool needShowWhenFailed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(
        "loan_is_show_release_failed_dialog$loanId", needShowWhenFailed);
  }

  static Future<bool> isShowReleaseFailedDialog(String loanId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("loan_is_show_release_failed_dialog$loanId") ?? true;
  }

  static Future<bool> setShowReleaseSuccessDialog(
      bool showReleaseSuccess) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(
        "loan_is_show_release_success_dialog", showReleaseSuccess);
  }

  static Future<bool> isShowReleaseSuccessDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("loan_is_show_release_success_dialog") ?? true;
  }

  static Future<bool> setDoneRegist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("loan_is_done_regist", true);
  }

  static Future<bool> isDoneRegist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("loan_is_done_regist") ?? false;
  }

  static Future<bool> setShowUnexpectedDialog(
      String loanId, bool needShowWhenFailed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(
        "loan_is_show_unexpected_dialog$loanId", needShowWhenFailed);
  }

  static Future<bool> needShowWhenFailed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("loan_need_show_when_failed") ?? true;
  }

  static Future<bool> setNeedShowWhenFailed(bool needShowWhenFailed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("loan_need_show_when_failed", needShowWhenFailed);
  }

  static Future<String> getProxy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loan_proxy") ?? "";
  }

  static Future<bool> setProxy(String proxy) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("loan_proxy", proxy);
  }

  static Future<String> getLocalPublicKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loan_public_key") ?? "";
  }

  static savePublicKey(String publicKeyMap) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loan_public_key", publicKeyMap);
  }

  static saveLoginInfoStr(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loan_login_info1", value);
  }

  static Future<String> getLoginInfoStr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loan_login_info1") ?? "";
  }

  static saveTempLocation(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loan_info_temp_loc", value);
  }

  static Future<String> getTempLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loan_info_temp_loc") ?? "";
  }

  static saveSelectedPurpose(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loan_selected_purpose_x", value);
  }

  static Future<String> getSelectedPurpose() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loan_selected_purpose_x") ?? "";
  }

  static saveConfigStr(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loan_config", value);
  }

  static Future<String> getConfigStr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loan_config") ?? "";
  }

  static saveAccountStr(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loan_account", value);
  }

  static Future<String> getAccountStr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loan_account") ?? "";
  }

  static saveUserBaseStr(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loan_user_base", value);
  }

  static Future<String> getUserBaseStr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loan_user_base") ?? "";
  }

  static saveUserStateStr(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loan_user_state", value);
  }

  static Future<String> getUserStateStr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loan_user_state") ?? "";
  }

  static setLiveness(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loan_liveness", value);
  }

  static Future<String> getLiveness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loan_liveness") ?? "";
  }

  static setPhoneNum(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loan_phone_num", value);
  }

  static Future<String> getPhoneNum() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loan_phone_num") ?? "";
  }

  static setIsAgreeAgreement(bool isAgree) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("is_agree_agreement", isAgree);
  }

  static Future<bool> getIsAgreeAgreement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("is_agree_agreement") ?? false;
  }

  static savePricyDigisign(bool isopen) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("pricy_digisign_open", isopen);
  }

  static Future<bool> getPricyDigisign() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("pricy_digisign_open") ?? false;
  }

  static setShowCreditActiveDialog(bool show) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("loan_show_credit_active", show);
  }

  static Future<bool> hasShowCreditActiveDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("loan_show_credit_active") ?? false;
  }

  static setShowActiveSuccessDialog(bool show) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("loan_show_credit_active_success", show);
  }

  static Future<bool> hasShowActiveSuccessDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("loan_show_credit_active_success") ?? false;
  }

  static setLocalEnterInfoStep(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("loan_enter_info_step", value);
  }

  static Future<int> getLocalEnterInfoStep() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("loan_enter_info_step") ?? 1;
  }

  static setCouponReadId(String ids) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loan_coupon_read_id", ids);
  }

  static Future<String> getCouponReadId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loan_coupon_read_id") ?? '';
  }

  static setBankNo(String bankNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loan_bank_no", bankNo);
  }

  static Future<String> getBankNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loan_bank_no") ?? '';
  }

  static setBankName(String bankName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loan_bank_name", bankName);
  }

  static Future<String> getBankName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loan_bank_name") ?? '';
  }

  static setBankNameShower(String bankName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loan_bank_name_shower", bankName);
  }

  static Future<String> getBankNameShower() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loan_bank_name_shower") ?? '';
  }

  static setReportFullDeviceInfoFirst(bool show) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("report_full_device_info_status", show);
  }

  static Future<bool> reportFullDeviceInfoFirst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("report_full_device_info_status") ?? true;
  }

  static setReportFullDeviceInfoTime(int time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("report_full_device_info_time", time);
  }

  static Future<int> reportFullDeviceInfoTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("report_full_device_info_time") ?? 0;
  }

  static setReportAppListInfoFirst(bool show) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("report_app_list_info_status", show);
  }

  static Future<bool> reportAppListInfoFirst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("report_app_list_info_status") ?? true;
  }

  static setReportAppListInfoTime(int time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("report_app_list_info_time", time);
  }

  static Future<int> reportAppListInfoTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("report_app_list_info_time") ?? 0;
  }

  static setReportAppListInfoNoLoginTime(int time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("report_app_list_info_no_login_time", time);
  }

  static Future<int> reportAppListInfoNoLoginTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("report_app_list_info_no_login_time") ?? 0;
  }

  static setNeedShowPraiseDialog(bool show) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("need_show_praise_dialog", show);
  }

  static Future<bool> getNeedShowPraiseDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("need_show_praise_dialog") ?? false;
  }

  static setShouldShowPraiseDialog(bool show) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("should_show_praise_dialog", show);
  }

  static Future<bool> getShouldShowPraiseDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("should_show_praise_dialog") ?? true;
  }

  static saveTkbData(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loan_tkb_data", value);
  }

  static Future<String> getTkbData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loan_tkb_data") ?? "";
  }

  static setFcmRegId(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("fcm_reg_id", value);
  }

  static Future<String> getFcmRegId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("fcm_reg_id") ?? "";
  }

  static saveAppID(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("app_id", value);
  }

  static Future<String> getAppID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("app_id") ?? '';
  }

  static saveSubmitBank(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("submit_bank", value);
  }

  static Future<String> getSubmitBank() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("submit_bank") ?? '';
  }

  static saveSubmitUse(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("submit_use", value);
  }

  static Future<String> getSubmitUse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("submit_use") ?? '';
  }

  static savePersonal(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("submit_personal", value);
  }

  static Future<String> getSubmitPersonal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("submit_personal") ?? '';
  }

  static saveSubmitWork(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("submit_work", value);
  }

  static Future<String> getSubmitWork() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("submit_work") ?? '';
  }

  static saveSubmitSocial(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("submit_social", value);
  }

  static Future<String> getSubmitSocial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("submit_social") ?? '';
  }

  static saveSubmitLiveness(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("submit_liveness", value);
  }

  static Future<String> getSubmitLiveness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("submit_liveness") ?? '';
  }

  static saveHasWork(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("has_work", value);
  }

  static Future<String> getHasWork() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("has_work") ?? '';
  }

  static saveIdSuccess(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("id_success", value);
  }

  static Future<bool> getIdSuccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("id_success") ?? false;
  }

  static saveKtp(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("cache_ktp", value);
  }

  static Future<bool> getKtp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("cache_ktp") ?? false;
  }

  static saveDeviceId(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("device_id", value);
  }

  static Future<String> getDeivceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("device_id") ?? "";
  }

  static saveDeviceFingerprint(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("device_fingerprint", value);
  }

  static Future<String> getDeviceFingerprint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("device_fingerprint") ?? "";
  }

  static saveDeviceRiskScore(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("device_risk_score", value);
  }

  static Future<int> getDeviceRiskScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("device_risk_score") ?? 0;
  }

  // Personal Information storage methods
  static savePersonalInformation(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user_personal_information", value);
  }

  static Future<String> getPersonalInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_personal_information") ?? "";
  }

  static Future<void> clearPersonalInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_personal_information");
  }

  static Future<void> saveMotherName(String motherName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_mother_name", motherName);
  }

  static Future<String> getMotherName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_mother_name") ?? "";
  }

  static Future<void> clearMotherName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_mother_name");
  }

  // OCR and Face data storage methods
  static Future<void> saveOcrData(String ocrDataJson) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_ocr_data", ocrDataJson);
  }

  static Future<String> getOcrData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_ocr_data") ?? "";
  }

  static Future<void> clearOcrData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_ocr_data");
  }

  static Future<void> saveFaceImageData(String base64FaceImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_face_image", base64FaceImage);
  }

  static Future<String> getFaceImageData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_face_image") ?? "";
  }

  static Future<void> clearFaceImageData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_face_image");
  }

  static Future<void> saveFaceVerificationScore(double score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("face_verification_score", score);
  }

  static Future<double?> getFaceVerificationScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble("face_verification_score");
  }

  static Future<void> clearFaceVerificationScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("face_verification_score");
  }

  // Clear all user data
  static Future<void> clearAllUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static saveDeviceSecurityLevel(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("device_security_level", value);
  }

  static Future<int> getDeviceSecurityLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("device_security_level") ?? 0;
  }

  // KTP Image storage methods
  static Future<void> saveKtpImageData(String base64ImageData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("captured_ktp_image", base64ImageData);
  }

  static Future<String?> getKtpImageData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("captured_ktp_image");
  }

  static Future<void> clearKtpImageData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("captured_ktp_image");
  }

  // Facial Recognition status methods
  static Future<void> saveFacialRecognitionStatus(bool completed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("facial_recognition_completed", completed);
  }

  static Future<bool> getFacialRecognitionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("facial_recognition_completed") ?? false;
  }

  static Future<void> clearFacialRecognitionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("facial_recognition_completed");
  }

  // Clear all identity verification data
  static Future<void> clearAllIdentityData() async {
    await clearKtpImageData();
    await clearFacialRecognitionStatus();
    await clearLivenessCheckData();
  }

  // Liveness Check data storage methods
  static Future<void> saveLivenessScore(double score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("liveness_score", score);
  }

  static Future<double?> getLivenessScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble("liveness_score");
  }

  static Future<void> saveLivenessDetectionResult(String result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("liveness_detection_result", result);
  }

  static Future<String?> getLivenessDetectionResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("liveness_detection_result");
  }

  static Future<void> clearLivenessCheckData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("liveness_score");
    await prefs.remove("liveness_detection_result");
  }

  // Get all liveness check data at once
  static Future<Map<String, dynamic>> getLivenessCheckData() async {
    final score = await getLivenessScore();
    final result = await getLivenessDetectionResult();

    return {
      'score': score,
      'detectionResult': result,
      'hasData': score != null || (result != null && result.isNotEmpty),
    };
  }

  // Bank Account Information storage methods
  static Future<void> saveBankAccountName(String bankName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_bank_name", bankName);
  }

  static Future<String> getBankAccountName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_bank_name") ?? '';
  }

  static Future<void> saveBankAccountNumber(String accountNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_bank_account_number", accountNumber);
  }

  static Future<String> getBankAccountNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_bank_account_number") ?? '';
  }

  static Future<void> saveBankCode(String bankCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_bank_code", bankCode);
  }

  static Future<String> getBankCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_bank_code") ?? '';
  }

  static Future<void> clearBankAccountName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_bank_name");
  }

  static Future<void> clearBankAccountNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_bank_account_number");
  }

  static Future<void> clearBankCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_bank_code");
  }

  // Clear all bank account data
  static Future<void> clearAllBankAccountData() async {
    await clearBankAccountName();
    await clearBankAccountNumber();
    await clearBankCode();
  }

  // Get all bank account data at once
  static Future<Map<String, String>> getBankAccountData() async {
    final bankName = await getBankAccountName();
    final accountNumber = await getBankAccountNumber();
    final bankCode = await getBankCode();

    return {
      'bankName': bankName,
      'accountNumber': accountNumber,
      'bankCode': bankCode,
    };
  }

  // Login Status storage methods
  static Future<void> saveLoginStatus(String loginStatusJson) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_login_status", loginStatusJson);
  }

  static Future<String> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_login_status") ?? "";
  }

  static Future<void> clearLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_login_status");
  }

  // Simple login state flag
  static Future<void> setIsLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("is_logged_in", isLoggedIn);
  }

  static Future<bool> getIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("is_logged_in") ?? false;
  }

  static Future<void> clearIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("is_logged_in");
  }

  static Future<void> saveSelectedLanguage(String languageId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("selected_language", languageId);
  }

  static Future<String?> getSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("selected_language");
  }

  static Future<void> clearSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("selected_language");
  }

  static Future<void> setHasShownRejectionRedirect(bool hasShown) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("has_shown_rejection_redirect", hasShown);
  }

  static Future<bool> getHasShownRejectionRedirect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("has_shown_rejection_redirect") ?? false;
  }

  static Future<void> clearHasShownRejectionRedirect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("has_shown_rejection_redirect");
  }

  // Rating Dialog Preferences
  static const String _HAS_SHOWN_RATING_DIALOG_KEY = "has_shown_rating_dialog";
  static const String _HAS_COMPLETED_UPLOAD_INFO_KEY =
      "has_completed_upload_info";
  static const String _USER_RATING_KEY = "user_rating";

  static Future<void> setHasShownRatingDialog(bool hasShown) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_HAS_SHOWN_RATING_DIALOG_KEY, hasShown);
  }

  static Future<bool> getHasShownRatingDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_HAS_SHOWN_RATING_DIALOG_KEY) ?? false;
  }

  static Future<void> setHasCompletedUploadInfo(bool hasCompleted) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_HAS_COMPLETED_UPLOAD_INFO_KEY, hasCompleted);
  }

  static Future<bool> getHasCompletedUploadInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_HAS_COMPLETED_UPLOAD_INFO_KEY) ?? false;
  }

  static Future<void> setUserRating(int rating) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_USER_RATING_KEY, rating);
  }

  static Future<int?> getUserRating() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_USER_RATING_KEY);
  }

  static Future<void> clearRatingData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_HAS_SHOWN_RATING_DIALOG_KEY);
    await prefs.remove(_HAS_COMPLETED_UPLOAD_INFO_KEY);
    await prefs.remove(_USER_RATING_KEY);
  }
}
