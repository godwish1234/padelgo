import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtil {
  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // Auth token keys
  static const String _authTokenKey = 'auth_token';
  static const String _loginInfoKey = 'login_info';

  // Location keys
  static const String _latitudeKey = 'user_latitude';
  static const String _longitudeKey = 'user_longitude';
  static const String _ipAddressKey = 'user_ip_address';
  static const String _locationTimestampKey = 'location_timestamp';

  /// Save authorization token securely
  static Future<void> saveAuthToken(String token) async {
    try {
      await _secureStorage.write(key: _authTokenKey, value: token);
    } catch (e) {
      debugPrint('Error saving auth token: $e');
      rethrow;
    }
  }

  /// Get authorization token from secure storage
  static Future<String?> getAuthToken() async {
    try {
      return await _secureStorage.read(key: _authTokenKey);
    } catch (e) {
      debugPrint('Error reading auth token: $e');
      return null;
    }
  }

  /// Save login info JSON securely
  static Future<void> saveLoginInfo(String loginInfoJson) async {
    try {
      await _secureStorage.write(key: _loginInfoKey, value: loginInfoJson);
    } catch (e) {
      debugPrint('Error saving login info: $e');
      rethrow;
    }
  }

  /// Get login info JSON from secure storage
  static Future<String?> getLoginInfo() async {
    try {
      return await _secureStorage.read(key: _loginInfoKey);
    } catch (e) {
      debugPrint('Error reading login info: $e');
      return null;
    }
  }

  /// Clear all authentication data
  static Future<void> clearAuthData() async {
    try {
      await _secureStorage.delete(key: _authTokenKey);
      await _secureStorage.delete(key: _loginInfoKey);
    } catch (e) {
      debugPrint('Error clearing auth data: $e');
      rethrow;
    }
  }

  /// Check if auth token exists
  static Future<bool> hasAuthToken() async {
    try {
      final token = await getAuthToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking auth token: $e');
      return false;
    }
  }

  /// Clear all secure storage (for debugging/testing)
  static Future<void> clearAll() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      debugPrint('Error clearing all secure storage: $e');
      rethrow;
    }
  }

  // Location data methods

  /// Save user latitude securely
  static Future<void> saveLatitude(String latitude) async {
    try {
      await _secureStorage.write(key: _latitudeKey, value: latitude);
    } catch (e) {
      debugPrint('Error saving latitude: $e');
      rethrow;
    }
  }

  /// Get user latitude from secure storage
  static Future<String?> getLatitude() async {
    try {
      return await _secureStorage.read(key: _latitudeKey);
    } catch (e) {
      debugPrint('Error reading latitude: $e');
      return null;
    }
  }

  /// Save user longitude securely
  static Future<void> saveLongitude(String longitude) async {
    try {
      await _secureStorage.write(key: _longitudeKey, value: longitude);
    } catch (e) {
      debugPrint('Error saving longitude: $e');
      rethrow;
    }
  }

  /// Get user longitude from secure storage
  static Future<String?> getLongitude() async {
    try {
      return await _secureStorage.read(key: _longitudeKey);
    } catch (e) {
      debugPrint('Error reading longitude: $e');
      return null;
    }
  }

  /// Save user IP address securely
  static Future<void> saveIpAddress(String ipAddress) async {
    try {
      await _secureStorage.write(key: _ipAddressKey, value: ipAddress);
    } catch (e) {
      debugPrint('Error saving IP address: $e');
      rethrow;
    }
  }

  /// Get user IP address from secure storage
  static Future<String?> getIpAddress() async {
    try {
      return await _secureStorage.read(key: _ipAddressKey);
    } catch (e) {
      debugPrint('Error reading IP address: $e');
      return null;
    }
  }

  /// Save location data timestamp
  static Future<void> saveLocationTimestamp(String timestamp) async {
    try {
      await _secureStorage.write(key: _locationTimestampKey, value: timestamp);
    } catch (e) {
      debugPrint('Error saving location timestamp: $e');
      rethrow;
    }
  }

  /// Get location data timestamp
  static Future<String?> getLocationTimestamp() async {
    try {
      return await _secureStorage.read(key: _locationTimestampKey);
    } catch (e) {
      debugPrint('Error reading location timestamp: $e');
      return null;
    }
  }

  /// Save all location data at once
  static Future<void> saveLocationData({
    required String latitude,
    required String longitude,
    required String ipAddress,
  }) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

      await Future.wait([
        saveLatitude(latitude),
        saveLongitude(longitude),
        saveIpAddress(ipAddress),
        saveLocationTimestamp(timestamp),
      ]);
    } catch (e) {
      debugPrint('Error saving location data: $e');
      rethrow;
    }
  }

  /// Get all location data
  static Future<Map<String, String?>> getLocationData() async {
    try {
      final results = await Future.wait([
        getLatitude(),
        getLongitude(),
        getIpAddress(),
        getLocationTimestamp(),
      ]);

      return {
        'latitude': results[0],
        'longitude': results[1],
        'ipAddress': results[2],
        'timestamp': results[3],
      };
    } catch (e) {
      debugPrint('Error getting location data: $e');
      return {
        'latitude': null,
        'longitude': null,
        'ipAddress': null,
        'timestamp': null,
      };
    }
  }

  /// Clear all location data
  static Future<void> clearLocationData() async {
    try {
      await Future.wait([
        _secureStorage.delete(key: _latitudeKey),
        _secureStorage.delete(key: _longitudeKey),
        _secureStorage.delete(key: _ipAddressKey),
        _secureStorage.delete(key: _locationTimestampKey),
      ]);
    } catch (e) {
      debugPrint('Error clearing location data: $e');
      rethrow;
    }
  }

  static Future<void> saveString(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      debugPrint('Error saving string with key $key: $e');
      rethrow;
    }
  }

  static Future<String?> getString(String key) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      debugPrint('Error reading string with key $key: $e');
      return null;
    }
  }

  /// Delete a value by custom key
  static Future<void> deleteKey(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      debugPrint('Error deleting key $key: $e');
      rethrow;
    }
  }
}
