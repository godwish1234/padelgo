import 'package:padelgo/enums/response_code.dart';

class ApiException implements Exception {
  final ResponseCode responseCode;
  final String? message;
  final dynamic originalResponse;

  const ApiException({
    required this.responseCode,
    this.message,
    this.originalResponse,
  });

  factory ApiException.fromResponse(dynamic response) {
    ResponseCode responseCode = ResponseCode.unknownError;
    String? message;

    if (response is Map<String, dynamic>) {
      final code = response['code'];

      if (code is int) {
        responseCode = ResponseCode.getByCode(code);
      } else if (code is String) {
        responseCode = ResponseCode.getByCodeString(code);
      }

      message = response['msg']?.toString() ?? response['message']?.toString();
    }

    return ApiException(
      responseCode: responseCode,
      message: message,
      originalResponse: response,
    );
  }

  bool get requiresLogout => responseCode.requiresLogout;

  bool get requiresReauth => responseCode.requiresReauth;

  String get userMessage => message ?? responseCode.message;

  @override
  String toString() {
    return 'ApiException: ${responseCode.code} - $userMessage';
  }
}

class AuthenticationException extends ApiException {
  const AuthenticationException({
    required super.responseCode,
    super.message,
    super.originalResponse,
  });

  factory AuthenticationException.fromResponse(dynamic response) {
    final apiException = ApiException.fromResponse(response);
    return AuthenticationException(
      responseCode: apiException.responseCode,
      message: apiException.message,
      originalResponse: apiException.originalResponse,
    );
  }
}

class NetworkException extends ApiException {
  const NetworkException({
    super.message,
    super.originalResponse,
  }) : super(
          responseCode: ResponseCode.networkError,
        );
}

class ServerException extends ApiException {
  const ServerException({
    ResponseCode? responseCode,
    super.message,
    super.originalResponse,
  }) : super(
          responseCode: responseCode ?? ResponseCode.internalError,
        );
}
