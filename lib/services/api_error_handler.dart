import 'package:flutter/foundation.dart';
import 'package:padelgo/enums/response_code.dart';
import 'package:padelgo/utils/toast_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:padelgo/utils/secure_storage_util.dart';
import 'package:padelgo/helpers/preference_helper.dart';

class ApiErrorHandler {
  static final ApiErrorHandler _instance = ApiErrorHandler._internal();
  factory ApiErrorHandler() => _instance;
  ApiErrorHandler._internal();

  Future<bool> handleError({
    required dynamic response,
    bool showToast = true,
    bool handleLogout = true,
  }) async {
    ResponseCode responseCode;
    String? errorMessage;

    if (response is Map<String, dynamic>) {
      final code = response['code'];
      final message = response['msg'] ?? response['message'];

      if (code is int) {
        responseCode = ResponseCode.getByCode(code);
      } else if (code is String) {
        responseCode = ResponseCode.getByCodeString(code);
      } else {
        responseCode = ResponseCode.unknownError;
      }

      errorMessage = message?.toString();
    } else {
      responseCode = ResponseCode.unknownError;
      errorMessage = response?.toString();
    }

    return await _processError(
      responseCode: responseCode,
      errorMessage: errorMessage,
      showToast: showToast,
      handleLogout: handleLogout,
    );
  }

  Future<bool> handleErrorByCode({
    required int code,
    String? message,
    bool showToast = true,
    bool handleLogout = true,
  }) async {
    final responseCode = ResponseCode.getByCode(code);
    return await _processError(
      responseCode: responseCode,
      errorMessage: message,
      showToast: showToast,
      handleLogout: handleLogout,
    );
  }

  Future<bool> _processError({
    required ResponseCode responseCode,
    String? errorMessage,
    bool showToast = true,
    bool handleLogout = true,
  }) async {
    if (kDebugMode) {
      print(
          'API Error Handler - Code: ${responseCode.code}, Message: ${responseCode.message}');
      if (errorMessage != null) {
        print('API Error Handler - Custom Message: $errorMessage');
      }
    }

    if (handleLogout && responseCode.requiresLogout) {
      await _handleLogoutError(responseCode, errorMessage);
      return true;
    }

    if (responseCode.requiresReauth) {
      await _handleReauthError(responseCode, errorMessage, showToast);
      return true;
    }

    switch (responseCode) {
      case ResponseCode.networkError:
      case ResponseCode.requestTimeout:
      case ResponseCode.gatewayTimeout:
        if (showToast) {
          ToastUtil.showError(
              'Network connection error. Please check your connection and try again.');
        }
        break;

      case ResponseCode.serviceUnavailable:
        if (showToast) {
          ToastUtil.showError(
              'Service temporarily unavailable. Please try again later.');
        }
        break;

      case ResponseCode.tooManyRequests:
        if (showToast) {
          ToastUtil.showError(
              'Too many requests. Please wait a moment and try again.');
        }
        break;

      case ResponseCode.verificationCodeExpired:
        if (showToast) {
          ToastUtil.showError(
              'Verification code has expired. Please request a new one.');
        }
        break;

      case ResponseCode.verificationCodeInvalid:
        if (showToast) {
          ToastUtil.showError(
              'Invalid verification code. Please check and try again.');
        }
        break;

      case ResponseCode.verificationCodeTooFrequent:
        if (showToast) {
          ToastUtil.showError(
              'Please wait before requesting another verification code.');
        }
        break;

      case ResponseCode.userInfoIncomplete:
        if (showToast) {
          ToastUtil.showError('Please complete your profile information.');
        }
        break;

      case ResponseCode.creditLimitExceeded:
        if (showToast) {
          ToastUtil.showError(
              'Credit limit exceeded. Please adjust your application.');
        }
        break;

      case ResponseCode.creditAlreadyApplied:
        if (showToast) {
          ToastUtil.showError(
              'You have already applied for credit. Please wait for approval.');
        }
        break;

      case ResponseCode.bankCardInvalid:
        if (showToast) {
          ToastUtil.showError(
              'Invalid bank card information. Please check and try again.');
        }
        break;

      case ResponseCode.ocrRecognitionFailed:
        if (showToast) {
          ToastUtil.showError(
              'Document recognition failed. Please take a clearer photo.');
        }
        break;

      case ResponseCode.ocrLivenessDetectionFailed:
        if (showToast) {
          ToastUtil.showError(
              'Face verification failed. Please try again in good lighting.');
        }
        break;

      case ResponseCode.parameterError:
      case ResponseCode.invalidParams:
        if (showToast) {
          ToastUtil.showError(errorMessage ?? 'Invalid request parameters.');
        }
        break;

      case ResponseCode.forbidden:
        if (showToast) {
          ToastUtil.showError(
              'Access denied. Please contact support if this persists.');
        }
        break;

      case ResponseCode.notFound:
        if (showToast) {
          ToastUtil.showError('Requested resource not found.');
        }
        break;

      case ResponseCode.internalError:
      case ResponseCode.systemError:
        if (showToast) {
          ToastUtil.showError('System error occurred. Please try again later.');
        }
        break;

      default:
        if (showToast) {
          final message = errorMessage?.isNotEmpty == true
              ? errorMessage!
              : responseCode.message;
          ToastUtil.showError(message);
        }
        break;
    }

    return false;
  }

  Future<void> _handleLogoutError(
      ResponseCode responseCode, String? errorMessage) async {
    if (kDebugMode) {
      print(
          'Handling logout error: ${responseCode.code} - ${responseCode.message}');
    }

    try {
      await _clearAuthenticationData();

      String message;
      switch (responseCode) {
        case ResponseCode.jwtTokenExpired:
          message = 'Your session has expired. Please login again.';
          break;
        case ResponseCode.jwtTokenInvalid:
          message = 'Invalid session. Please login again.';
          break;
        case ResponseCode.userNotAuthenticated:
          message = 'Authentication required. Please login.';
          break;
        case ResponseCode.unauthorized:
          message = 'Unauthorized access. Please login again.';
          break;
        default:
          message = errorMessage ?? 'Authentication error. Please login again.';
          break;
      }

      ToastUtil.showError(message);

      if (kDebugMode) {
        print('Authentication data cleared. App should redirect to login.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during logout handling: $e');
      }
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
      } catch (clearError) {
        if (kDebugMode) {
          print('Error clearing preferences as fallback: $clearError');
        }
      }
    }
  }

  Future<void> _handleReauthError(
      ResponseCode responseCode, String? errorMessage, bool showToast) async {
    if (kDebugMode) {
      print(
          'Handling reauth error: ${responseCode.code} - ${responseCode.message}');
    }

    if (showToast) {
      String message;
      switch (responseCode) {
        case ResponseCode.userPasswordIncorrect:
          message = 'Incorrect password. Please try again.';
          break;
        case ResponseCode.mobileVerificationFailed:
          message = 'Mobile verification failed. Please try again.';
          break;
        default:
          message = errorMessage ?? 'Verification failed. Please try again.';
          break;
      }
      ToastUtil.showError(message);
    }
  }

  Future<void> _clearAuthenticationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      await SecureStorageUtil.clearAuthData();
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing secure storage: $e');
      }
    }

    try {
      await prefs.remove('userToken');
      await prefs.remove('captured_ktp');
      await prefs.remove('captured_face');
      await prefs.remove('successful_base_url');
      await prefs.remove('user_id');
      await prefs.remove('login_info');
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing shared preferences: $e');
      }
    }

    // Clear all user personal information and verification data
    try {
      await PkPreferenceHelper.clearAllUserData();
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing user personal data: $e');
      }
    }

    try {
      // final authService = GetIt.instance<AuthenticationService>();
      // await authService.clearLoginInfo();
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing via auth service: $e');
      }
    }

    if (kDebugMode) {
      print('All authentication data has been cleared');
    }
  }

  bool requiresSpecialHandling(int code) {
    final responseCode = ResponseCode.getByCode(code);
    return responseCode.requiresLogout || responseCode.requiresReauth;
  }

  String getUserFriendlyMessage(int code, [String? customMessage]) {
    final responseCode = ResponseCode.getByCode(code);

    if (customMessage?.isNotEmpty == true) {
      return customMessage!;
    }

    switch (responseCode) {
      case ResponseCode.networkError:
        return 'Network connection error. Please check your internet connection.';
      case ResponseCode.internalError:
        return 'Server error. Please try again later.';
      case ResponseCode.unauthorized:
        return 'Session expired. Please login again.';
      case ResponseCode.forbidden:
        return 'Access denied. Please contact support.';
      case ResponseCode.notFound:
        return 'Requested information not found.';
      case ResponseCode.tooManyRequests:
        return 'Too many requests. Please wait a moment.';
      default:
        return responseCode.message;
    }
  }
}
