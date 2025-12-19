import 'package:flutter/cupertino.dart';
import 'package:padelgo/enums/response_code.dart';

class ApiResponse<T> {
  final bool isSuccess;
  final ResponseCode responseCode;
  final String? message;
  final T? data;
  final Map<String, dynamic>? rawResponse;

  const ApiResponse({
    required this.isSuccess,
    required this.responseCode,
    this.message,
    this.data,
    this.rawResponse,
  });

  factory ApiResponse.success({
    T? data,
    String? message,
    Map<String, dynamic>? rawResponse,
  }) {
    return ApiResponse<T>(
      isSuccess: true,
      responseCode: ResponseCode.success,
      data: data,
      message: message,
      rawResponse: rawResponse,
    );
  }

  factory ApiResponse.error({
    required ResponseCode responseCode,
    String? message,
    Map<String, dynamic>? rawResponse,
  }) {
    return ApiResponse<T>(
      isSuccess: false,
      responseCode: responseCode,
      message: message,
      rawResponse: rawResponse,
    );
  }

  factory ApiResponse.fromJson(
    Map<String, dynamic> json, {
    T Function(Map<String, dynamic>)? dataParser,
  }) {
    final code = json['code'];
    ResponseCode responseCode;

    if (code is int) {
      responseCode = ResponseCode.getByCode(code);
    } else if (code is String) {
      responseCode = ResponseCode.getByCodeString(code);
    } else {
      responseCode = ResponseCode.unknownError;
    }

    final isSuccess = responseCode.isSuccess;
    final message = json['msg']?.toString() ?? json['message']?.toString();

    T? data;
    if (isSuccess && json['data'] != null && dataParser != null) {
      try {
        if (json['data'] is Map<String, dynamic>) {
          data = dataParser(json['data']);
        }
      } catch (e) {
        debugPrint('Error parsing API response data: ${e.toString()}');
      }
    }

    return ApiResponse<T>(
      isSuccess: isSuccess,
      responseCode: responseCode,
      message: message,
      data: data,
      rawResponse: json,
    );
  }

  bool get requiresLogout => responseCode.requiresLogout;

  bool get requiresReauth => responseCode.requiresReauth;

  String get userMessage => message ?? responseCode.message;

  @override
  String toString() {
    return 'ApiResponse{isSuccess: $isSuccess, responseCode: ${responseCode.code}, message: $message}';
  }
}
