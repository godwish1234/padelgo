import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:padelgo/constants/url.dart';

import 'package:padelgo/initialization/services/navigation_service.dart';
import 'package:padelgo/repository/base/session_expired_exception.dart';
import 'package:padelgo/services/interfaces/authentication_service.dart';
import 'package:padelgo/services/api_error_handler.dart';
import 'package:padelgo/models/api_response.dart';
import 'package:padelgo/enums/response_code.dart';

import 'package:padelgo/ui/base/loading_state_manager.dart';
import 'package:padelgo/ui/components/offline_widget.dart';
import 'package:padelgo/ui/components/server_unavailable_widget.dart';
import 'package:padelgo/utils/secure_storage_util.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestApiRepositoryBase {
  static bool isShowingOfflineScreen = false;
  static bool isShowingServerUnavailableScreen = false;
  static bool _globalServerError = false;

  late final String _baseEndpoint;
  final ApiErrorHandler _errorHandler = ApiErrorHandler();

  static const Duration _apiTimeout = Duration(seconds: 90);

  RestApiRepositoryBase({String? base}) {
    _initializeBaseEndpoint(base);
  }

  static bool get hasGlobalServerError => _globalServerError;

  static void resetGlobalErrorState() {
    _globalServerError = false;
  }

  static void setGlobalServerError() {
    _globalServerError = true;
    LoadingStateManager().notifyBusyState(false);
  }

  Future<void> _initializeBaseEndpoint(String? base) async {
    if (base != null) {
      _baseEndpoint = base;
    } else {
      final prefs = await SharedPreferences.getInstance();
      final successfulBaseUrl = prefs.getString('successful_base_url');
      _baseEndpoint = successfulBaseUrl ?? UrlLink.officialUrl;
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final locationData = await SecureStorageUtil.getLocationData();

      if (locationData['latitude'] != null) {
        headers['lat'] = locationData['latitude']!;
      }

      if (locationData['longitude'] != null) {
        headers['lon'] = locationData['longitude']!;
      }

      if (locationData['ipAddress'] != null) {
        headers['ip'] = locationData['ipAddress']!;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding location headers: $e');
      }
    }

    return headers;
  }

  Future<dynamic> get(String endPoint,
      {Map<String, String>? customHeaders,
      Map<String, dynamic>? body,
      bool suppressErrorToast = false}) async {
    if (_globalServerError) {
      throw Exception('Server unavailable - previous API call failed');
    }

    if (!await _hasInternetConnection()) {
      setGlobalServerError();
      _showOfflineScreen();
      throw Exception('No internet connection');
    }

    try {
      Map<String, String> headers = await _getHeaders();

      if (customHeaders != null) {
        headers.addAll(customHeaders);
      }

      String? authToken = await SecureStorageUtil.getAuthToken();

      if (kDebugMode) {
        print(authToken);
      }

      if (authToken == null || authToken.isEmpty) {
        try {
          final authService = GetIt.instance<AuthenticationService>();
          final loginInfo = authService.getCurrentLoginInfo();
          if (loginInfo != null && loginInfo.authorization != null) {
            authToken = loginInfo.authorization!;
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error getting authorization from LoginInfo: $e');
          }
        }
      }

      if (authToken == null || authToken.isEmpty) {
        final prefs = await SharedPreferences.getInstance();
        authToken = prefs.getString("userToken");
      }

      if (authToken != null && authToken.isNotEmpty) {
        if (!authToken.startsWith('Bearer ')) {
          authToken = 'Bearer $authToken';
        }
        headers["Authorization"] = authToken;
      }

      String fullUrl = _baseEndpoint + endPoint;
      if (body != null && body.isNotEmpty) {
        final uri = Uri.parse(fullUrl);
        final newUri = uri.replace(queryParameters: {
          ...uri.queryParameters,
          ...body.map((key, value) => MapEntry(key, value.toString())),
        });
        fullUrl = newUri.toString();
      }

      HttpClient client = HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

      if (kDebugMode) {
        print("Executing Api: $fullUrl");
      }

      try {
        HttpClientRequest request =
            await client.getUrl(Uri.parse(fullUrl)).timeout(_apiTimeout);

        headers.forEach((key, value) => request.headers.add(key, value));

        HttpClientResponse response =
            await request.close().timeout(_apiTimeout);

        final responseBody =
            await response.transform(utf8.decoder).join().timeout(_apiTimeout);
        final decodedResponse = jsonDecode(responseBody);

        await _handleHttpAndApiResponse(response.statusCode, decodedResponse,
            suppressErrorToast: suppressErrorToast);

        return decodedResponse;
      } on SocketException {
        setGlobalServerError();
        _showServerUnavailableScreen();
        throw Exception('Server unavailable - please try again later');
      } on TimeoutException {
        setGlobalServerError();
        _showOfflineScreen();
        throw Exception('Connection timed out');
      }
    } on SessionExpiredException {
      LoadingStateManager().notifyBusyState(false);
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('GET request error: $e');
      }
      rethrow;
    }
  }

  Future<dynamic> post(String endPoint, Map<String, dynamic> data,
      {Map<String, String>? customHeaders,
      bool suppressErrorToast = false}) async {
    if (_globalServerError) {
      throw Exception('Server unavailable - previous API call failed');
    }

    if (!await _hasInternetConnection()) {
      setGlobalServerError();
      _showOfflineScreen();
      throw Exception('No internet connection');
    }

    try {
      Map<String, String> headers = await _getHeaders();

      if (customHeaders != null) {
        headers.addAll(customHeaders);
      }

      String? authToken = await SecureStorageUtil.getAuthToken();

      if (kDebugMode) {
        print(authToken);
      }

      if (authToken == null || authToken.isEmpty) {
        try {
          final authService = GetIt.instance<AuthenticationService>();
          final loginInfo = authService.getCurrentLoginInfo();
          if (loginInfo != null && loginInfo.authorization != null) {
            authToken = loginInfo.authorization!;
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error getting authorization from LoginInfo: $e');
          }
        }
      }

      if (authToken == null || authToken.isEmpty) {
        final prefs = await SharedPreferences.getInstance();
        authToken = prefs.getString("userToken");
      }
      if (authToken != null && authToken.isNotEmpty) {
        if (!authToken.startsWith('Bearer ')) {
          authToken = 'Bearer $authToken';
        }
        headers["Authorization"] = authToken;
      }

      HttpClient client = HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

      if (kDebugMode) {
        print("Executing Api: $_baseEndpoint + $endPoint");
      }
      try {
        HttpClientRequest request = await client
            .postUrl(Uri.parse(_baseEndpoint + endPoint))
            .timeout(_apiTimeout);

        headers.forEach((key, value) => request.headers.add(key, value));

        String jsonData = jsonEncode(data);
        request.add(utf8.encode(jsonData));

        HttpClientResponse response =
            await request.close().timeout(_apiTimeout);

        final responseBody =
            await response.transform(utf8.decoder).join().timeout(_apiTimeout);
        final decodedResponse = jsonDecode(responseBody);

        await _handleHttpAndApiResponse(response.statusCode, decodedResponse,
            suppressErrorToast: suppressErrorToast);

        return decodedResponse;
      } on SocketException {
        setGlobalServerError();
        _showServerUnavailableScreen();
        throw Exception('Server unavailable - please try again later');
      } on TimeoutException {
        setGlobalServerError();
        _showOfflineScreen();
        throw Exception('Connection timed out');
      }
    } on SessionExpiredException {
      LoadingStateManager().notifyBusyState(false);
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('POST request error: $e');
      }
      rethrow;
    }
  }

  Future<dynamic> delete(String endPoint,
      {Map<String, String>? customHeaders,
      Map<String, dynamic>? body,
      bool suppressErrorToast = false}) async {
    if (_globalServerError) {
      throw Exception('Server unavailable - previous API call failed');
    }

    if (!await _hasInternetConnection()) {
      setGlobalServerError();
      _showOfflineScreen();
      throw Exception('No internet connection');
    }

    try {
      Map<String, String> headers = await _getHeaders();

      if (customHeaders != null) {
        headers.addAll(customHeaders);
      }

      String? authToken = await SecureStorageUtil.getAuthToken();

      if (kDebugMode) {
        print(authToken);
      }

      if (authToken == null || authToken.isEmpty) {
        try {
          final authService = GetIt.instance<AuthenticationService>();
          final loginInfo = authService.getCurrentLoginInfo();
          if (loginInfo != null && loginInfo.authorization != null) {
            authToken = loginInfo.authorization!;
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error getting authorization from LoginInfo: $e');
          }
        }
      }

      if (authToken == null || authToken.isEmpty) {
        final prefs = await SharedPreferences.getInstance();
        authToken = prefs.getString("userToken");
      }

      if (authToken != null && authToken.isNotEmpty) {
        if (!authToken.startsWith('Bearer ')) {
          authToken = 'Bearer $authToken';
        }
        headers["Authorization"] = authToken;
      }

      String fullUrl = _baseEndpoint + endPoint;
      if (body != null && body.isNotEmpty) {
        final uri = Uri.parse(fullUrl);
        final newUri = uri.replace(queryParameters: {
          ...uri.queryParameters,
          ...body.map((key, value) => MapEntry(key, value.toString())),
        });
        fullUrl = newUri.toString();
      }

      HttpClient client = HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

      if (kDebugMode) {
        print("Executing DELETE Api: $fullUrl");
      }

      try {
        HttpClientRequest request =
            await client.deleteUrl(Uri.parse(fullUrl)).timeout(_apiTimeout);

        headers.forEach((key, value) => request.headers.add(key, value));

        HttpClientResponse response =
            await request.close().timeout(_apiTimeout);

        final responseBody =
            await response.transform(utf8.decoder).join().timeout(_apiTimeout);
        final decodedResponse = jsonDecode(responseBody);

        await _handleHttpAndApiResponse(response.statusCode, decodedResponse,
            suppressErrorToast: suppressErrorToast);

        return decodedResponse;
      } on SocketException {
        setGlobalServerError();
        _showServerUnavailableScreen();
        throw Exception('Server unavailable - please try again later');
      } on TimeoutException {
        setGlobalServerError();
        _showOfflineScreen();
        throw Exception('Connection timed out');
      }
    } on SessionExpiredException {
      LoadingStateManager().notifyBusyState(false);
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('DELETE request error: $e');
      }
      rethrow;
    }
  }

  Future<bool> _hasInternetConnection() async {
    try {
      final connectivityResults = await Connectivity().checkConnectivity();
      return connectivityResults.isNotEmpty &&
          !connectivityResults.contains(ConnectivityResult.none);
    } catch (e) {
      if (kDebugMode) {
        print('Error checking connectivity: $e');
      }
      return false;
    }
  }

  void _showOfflineScreen() {
    if (isShowingOfflineScreen) return;
    isShowingOfflineScreen = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final navigationService = GetIt.instance<NavigationService>();
        final context = navigationService.navigatorKey.currentContext;
        final eventProvider = GetIt.instance<EventProvider>();

        if (context != null) {
          final result = navigationService.push(
            const OfflineWidget(),
          );

          result.then((_) {
            isShowingOfflineScreen = false;
            resetGlobalErrorState();

            eventProvider.sendEvent(NetworkRestoreEvent());
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error showing offline screen: $e');
        }
        isShowingOfflineScreen = false;
        resetGlobalErrorState();
      }
    });
  }

  void _showServerUnavailableScreen() {
    if (isShowingServerUnavailableScreen) return;
    isShowingServerUnavailableScreen = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final navigationService = GetIt.instance<NavigationService>();
        final context = navigationService.navigatorKey.currentContext;
        final eventProvider = GetIt.instance<EventProvider>();

        if (context != null) {
          final result = navigationService.push(
            const ServerUnavailableWidget(),
          );

          result.then((_) {
            isShowingServerUnavailableScreen = false;
            resetGlobalErrorState();

            eventProvider.sendEvent(NetworkRestoreEvent());
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error showing server unavailable screen: $e');
        }
        isShowingServerUnavailableScreen = false;
        resetGlobalErrorState();
      }
    });
  }

  Future<void> handleInvalidToken() async {
    if (kDebugMode) {
      print("Handling invalid token - clearing storage");
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var containsUserToken = prefs.containsKey("userToken");
    if (!containsUserToken) return;

    try {
      await SecureStorageUtil.clearAuthData();
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing secure storage: $e');
      }
    }

    await prefs.remove('userToken');
    await prefs.remove("captured_ktp");
    await prefs.remove('captured_face');

    try {
      final authService = GetIt.instance<AuthenticationService>();
      await authService.clearLoginInfo();
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing via auth service: $e');
      }
    }

    LoadingStateManager().notifyBusyState(false);
  }

  Future<void> _handleHttpAndApiResponse(int httpStatusCode, dynamic response,
      {bool suppressErrorToast = false}) async {
    bool hasApiErrorHandling = false;

    if (response is Map<String, dynamic>) {
      final code = response['code'];

      if (code != null) {
        ResponseCode responseCode;

        if (code is int) {
          responseCode = ResponseCode.getByCode(code);
        } else if (code is String) {
          responseCode = ResponseCode.getByCodeString(code);
        } else {
          responseCode = ResponseCode.unknownError;
        }

        if (!responseCode.isSuccess) {
          hasApiErrorHandling = true;

          await _errorHandler.handleError(
            response: response,
            showToast: !suppressErrorToast,
            handleLogout: true,
          );

          if (suppressErrorToast) {
            final errorMessage =
                response['msg'] ?? response['message'] ?? responseCode.message;

            throw Exception(errorMessage);
          }

          // if (responseCode.requiresLogout && wasHandled) {
          //   throw SessionExpiredException(
          //       'Session expired due to: ${responseCode.message}');
          // }
        }
      }
    }

    if (!hasApiErrorHandling && httpStatusCode != 200) {
      await _handleHttpStatusError(httpStatusCode);
    }
  }

  Future<void> _handleHttpStatusError(int statusCode) async {
    ResponseCode responseCode;
    String errorMessage;

    switch (statusCode) {
      case 400:
        responseCode = ResponseCode.parameterError;
        errorMessage = 'Bad request. Please check your input.';
        break;
      case 401:
        responseCode = ResponseCode.unauthorized;
        errorMessage = 'Unauthorized. Please login again.';
        break;
      case 403:
        responseCode = ResponseCode.forbidden;
        errorMessage = 'Access forbidden.';
        break;
      case 404:
        responseCode = ResponseCode.notFound;
        errorMessage = 'Resource not found.';
        break;
      case 408:
        responseCode = ResponseCode.requestTimeout;
        errorMessage = 'Request timeout. Please try again.';
        break;
      case 429:
        responseCode = ResponseCode.tooManyRequests;
        errorMessage = 'Too many requests. Please wait a moment.';
        break;
      case 500:
        responseCode = ResponseCode.internalError;
        errorMessage = 'Server error. Please try again later.';
        break;
      case 502:
        responseCode = ResponseCode.badGateway;
        errorMessage = 'Bad gateway. Please try again later.';
        break;
      case 503:
        responseCode = ResponseCode.serviceUnavailable;
        errorMessage = 'Service unavailable. Please try again later.';
        break;
      case 504:
        responseCode = ResponseCode.gatewayTimeout;
        errorMessage = 'Gateway timeout. Please try again.';
        break;
      default:
        responseCode = ResponseCode.unknownError;
        errorMessage = 'Server error ($statusCode). Please try again.';
        break;
    }

    await _errorHandler.handleErrorByCode(
      code: responseCode.code,
      message: errorMessage,
      showToast: true,
      handleLogout: responseCode.requiresLogout,
    );

    if (responseCode.requiresLogout) {
      throw SessionExpiredException('HTTP $statusCode: $errorMessage');
    } else {
      throw Exception('HTTP $statusCode: $errorMessage');
    }
  }

  ApiResponse<T> createApiResponse<T>(
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

  Future<ApiResponse<T>> handleResponse<T>(
    dynamic response, {
    T Function(Map<String, dynamic>)? dataParser,
    bool showToast = true,
    bool handleLogout = true,
  }) async {
    final apiResponse = createApiResponse<T>(response, dataParser: dataParser);

    if (!apiResponse.isSuccess) {
      await _errorHandler.handleError(
        response: response,
        showToast: showToast,
        handleLogout: handleLogout,
      );
    }

    return apiResponse;
  }

  Future<bool> handleInvalidSession() async {
    if (kDebugMode) {
      print("Handling invalid session - refreshing session data");
    }

    try {
      Restart.restartApp();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Error refreshing session: $e");
      }
      return false;
    }
  }
}

class EventProvider with ChangeNotifier {
  dynamic _lastEvent;

  dynamic get lastEvent => _lastEvent;

  void sendEvent(dynamic event) {
    _lastEvent = event;
    notifyListeners();
  }
}

class PageBackEvent {
  final dynamic result;
  PageBackEvent(this.result);
}

class NetworkRestoreEvent {}
