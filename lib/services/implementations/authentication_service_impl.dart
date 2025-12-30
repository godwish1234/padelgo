import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padelgo/localizations/locale_keys.g.dart';
import 'package:padelgo/services/interfaces/authentication_service.dart';
import 'package:padelgo/models/auth_response.dart';
import 'package:padelgo/models/user_model.dart';
import 'package:padelgo/constants/end_point.dart';
import 'package:padelgo/config/environment.dart';
import 'package:padelgo/utils/secure_storage_util.dart';
import 'package:http/http.dart' as http;

class AuthenticationServiceImpl implements AuthenticationService {
  UserModel? _currentUser;
  String? _authToken;

  @override
  Future<AuthResponse?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final url = Uri.parse('${EnvironmentConfig.baseUrl}${EndPoint.login}');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final authResponse = AuthResponse.fromJson(jsonResponse);

        if (authResponse.success) {
          _authToken = authResponse.data.token;
          _currentUser = authResponse.data.user;

          await SecureStorageUtil.saveAuthToken(_authToken!);
          await SecureStorageUtil.saveLoginInfo(jsonEncode({
            'user': _currentUser!.toJson(),
            'token': _authToken,
          }));

          return authResponse;
        }
      }

      // Show error message from response
      String errorMessage = LocaleKeys.login_validation.tr();
      try {
        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse.containsKey('message')) {
          errorMessage = jsonResponse['message'] ?? errorMessage;
        }
      } catch (e) {
        debugPrint('Error parsing error message: $e');
      }

      Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      debugPrint('Login error: $e');
    }
    return null;
  }

  @override
  Future<AuthResponse?> createUserWithEmailAndPassword(
    String name,
    String email,
    String phone,
    String password,
    String passwordConfirmation,
  ) async {
    try {
      final url = Uri.parse('${EnvironmentConfig.baseUrl}${EndPoint.register}');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final authResponse = AuthResponse.fromJson(jsonResponse);

        if (authResponse.success) {
          _authToken = authResponse.data.token;
          _currentUser = authResponse.data.user;

          await SecureStorageUtil.saveAuthToken(_authToken!);
          await SecureStorageUtil.saveLoginInfo(jsonEncode({
            'user': _currentUser!.toJson(),
            'token': _authToken,
          }));

          return authResponse;
        }
      }

      String errorMessage = 'Registration failed. Please try again.';
      try {
        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse.containsKey('message')) {
          errorMessage = jsonResponse['message'] ?? errorMessage;
        }
      } catch (e) {
        debugPrint('Error parsing error message: $e');
      }

      debugPrint('Registration failed with status: ${response.statusCode}');
      Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      return null;
    } catch (e) {
      debugPrint('Create user error: $e');
      return null;
    }
  }

  @override
  Future<bool> isAlreadyLoggedIn() async {
    if (_authToken != null && _currentUser != null) {
      return true;
    }

    final token = await SecureStorageUtil.getAuthToken();
    final loginInfo = await SecureStorageUtil.getLoginInfo();

    if (token != null && loginInfo != null) {
      _authToken = token;
      try {
        final Map<String, dynamic> loginData = jsonDecode(loginInfo);
        if (loginData.containsKey('user')) {
          _currentUser = UserModel.fromJson(loginData['user']);
          return true;
        }
      } catch (e) {
        debugPrint('Error parsing login info: $e');
      }
    }

    return false;
  }

  @override
  bool isLoggedIn() {
    return _authToken != null && _currentUser != null;
  }

  @override
  dynamic getCurrentLoginInfo() {
    return _currentUser;
  }

  @override
  Future<void> clearLoginInfo() async {
    _authToken = null;
    _currentUser = null;
    await SecureStorageUtil.clearAuthData();
  }

  @override
  void signOut() async {
    await clearLoginInfo();
  }
}
