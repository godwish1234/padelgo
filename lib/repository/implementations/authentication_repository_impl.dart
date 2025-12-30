import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:padelgo/constants/end_point.dart';
import 'package:padelgo/models/auth_response.dart';
import 'package:padelgo/repository/base/rest_api_repository_base.dart';
import 'package:padelgo/repository/interfaces/authentication_repository.dart';
import 'package:padelgo/utils/secure_storage_util.dart';

class AuthenticationRepositoryImpl extends RestApiRepositoryBase
    implements AuthenticationRepository {
  @override
  Future<AuthResponse?> login(String email, String password) async {
    try {
      final responseData = await post(EndPoint.login, {
        'email': email,
        'password': password,
      });

      if (kDebugMode) {
        print('Login response data: $responseData');
      }

      final response = AuthResponse.fromJson(responseData);

      if (response.success) {
        await _saveAuthData(response);
      }

      return response;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to login: $e');
      }
      rethrow;
    }
  }

  @override
  Future<AuthResponse?> register(
    String name,
    String email,
    String phone,
    String password,
    String passwordConfirmation,
  ) async {
    try {
      final responseData = await post(EndPoint.register, {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });

      if (kDebugMode) {
        print('Register response data: $responseData');
      }

      final response = AuthResponse.fromJson(responseData);

      if (response.success) {
        await _saveAuthData(response);
      }

      return response;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Failed to register: $e');
      }
      rethrow;
    }
  }

  Future<void> _saveAuthData(AuthResponse response) async {
    await SecureStorageUtil.saveAuthToken(response.data.token);
    await SecureStorageUtil.saveLoginInfo(jsonEncode({
      'user': response.data.user.toJson(),
      'token': response.data.token,
    }));
  }

  @override
  Future<void> logout() async {
    try {
      // Call logout API
      await post(EndPoint.logout, {});
    } catch (e) {
      if (kDebugMode) {
        print('Logout API error: $e');
      }
      // Continue with local logout even if API fails
    } finally {
      // Clear local auth data
      await SecureStorageUtil.clearAuthData();
    }
  }
}
