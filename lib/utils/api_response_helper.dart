import 'package:flutter/foundation.dart';
import 'package:padelgo/enums/response_code.dart';
import 'package:padelgo/services/api_error_handler.dart';
import 'package:padelgo/models/api_response.dart';
import 'package:padelgo/exceptions/api_exception.dart';

class ApiResponseHelper {
  static final ApiErrorHandler _errorHandler = ApiErrorHandler();

  static Future<bool> handleResponse(
    dynamic response, {
    bool showToast = true,
    bool handleLogout = true,
  }) async {
    return await _errorHandler.handleError(
      response: response,
      showToast: showToast,
      handleLogout: handleLogout,
    );
  }

  static Future<bool> handleErrorByCode(
    int code, {
    String? message,
    bool showToast = true,
    bool handleLogout = true,
  }) async {
    return await _errorHandler.handleErrorByCode(
      code: code,
      message: message,
      showToast: showToast,
      handleLogout: handleLogout,
    );
  }

  static bool isSuccess(dynamic response) {
    if (response is Map<String, dynamic>) {
      final code = response['code'];

      if (code is int) {
        final responseCode = ResponseCode.getByCode(code);
        return responseCode.isSuccess;
      } else if (code is String) {
        final responseCode = ResponseCode.getByCodeString(code);
        return responseCode.isSuccess;
      }
    }
    return false;
  }

  static String? getErrorMessage(dynamic response) {
    if (response is Map<String, dynamic>) {
      return response['msg']?.toString() ?? response['message']?.toString();
    }
    return null;
  }

  static int? getErrorCode(dynamic response) {
    if (response is Map<String, dynamic>) {
      final code = response['code'];

      if (code is int) {
        return code;
      } else if (code is String) {
        return int.tryParse(code);
      }
    }
    return null;
  }

  static ApiResponse<T> createApiResponse<T>(
    dynamic response, {
    T Function(Map<String, dynamic>)? dataParser,
  }) {
    if (response is Map<String, dynamic>) {
      return ApiResponse<T>.fromJson(response, dataParser: dataParser);
    } else {
      return ApiResponse<T>.error(
        responseCode: ResponseCode.unknownError,
        message: 'Invalid response format',
      );
    }
  }

  static bool requiresLogout(dynamic response) {
    final code = getErrorCode(response);
    if (code != null) {
      final responseCode = ResponseCode.getByCode(code);
      return responseCode.requiresLogout;
    }
    return false;
  }

  static bool requiresReauth(dynamic response) {
    final code = getErrorCode(response);
    if (code != null) {
      final responseCode = ResponseCode.getByCode(code);
      return responseCode.requiresReauth;
    }
    return false;
  }

  static String getUserFriendlyMessage(dynamic response) {
    final code = getErrorCode(response);
    final message = getErrorMessage(response);

    if (code != null) {
      return _errorHandler.getUserFriendlyMessage(code, message);
    }

    return message ?? 'An unknown error occurred';
  }

  static ApiException createException(dynamic response) {
    return ApiException.fromResponse(response);
  }

  static void logError(dynamic response, [String? context]) {
    if (kDebugMode) {
      final code = getErrorCode(response);
      final message = getErrorMessage(response);
      print(
          'API Error${context != null ? ' [$context]' : ''}: Code: $code, Message: $message');
    }
  }
}
