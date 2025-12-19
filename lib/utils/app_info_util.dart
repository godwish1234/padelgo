import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:padelgo/models/user_apps_request.dart';

class AppInfoUtil {
  static const MethodChannel _channel = MethodChannel('app_info_channel');

  /// Get all installed applications from the device
  static Future<List<UserApp>> getInstalledApps() async {
    try {
      if (Platform.isAndroid) {
        return await _getAndroidInstalledApps();
      } else if (Platform.isIOS) {
        return await _getIOSInstalledApps();
      }
      return [];
    } catch (e) {
      if (kDebugMode) {
        print('Error getting installed apps: $e');
      }
      return [];
    }
  }

  /// Get installed apps for Android platform
  static Future<List<UserApp>> _getAndroidInstalledApps() async {
    try {
      final List<dynamic> result =
          await _channel.invokeMethod('getInstalledApps');

      return result.map<UserApp>((app) {
        final Map<String, dynamic> appData = Map<String, dynamic>.from(app);
        return UserApp(
          name: appData['name'] ?? '',
          packageName: appData['packageName'] ?? '',
          version: appData['version'] ?? '',
          installTime: appData['installTime'] ?? 0,
        );
      }).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting Android installed apps: $e');
      }
      return [];
    }
  }

  /// Get installed apps for iOS platform (limited due to iOS restrictions)
  static Future<List<UserApp>> _getIOSInstalledApps() async {
    try {
      // iOS has severe restrictions on getting installed apps
      // We can only get basic info about our own app
      final List<dynamic> result =
          await _channel.invokeMethod('getInstalledApps');

      return result.map<UserApp>((app) {
        final Map<String, dynamic> appData = Map<String, dynamic>.from(app);
        return UserApp(
          name: appData['name'] ?? '',
          packageName: appData['packageName'] ?? '',
          version: appData['version'] ?? '',
          installTime: appData['installTime'] ?? 0,
        );
      }).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting iOS installed apps: $e');
      }
      return [];
    }
  }

  /// Create a UserAppsRequest object from the list of installed apps
  static Future<UserAppsRequest> createUserAppsRequest() async {
    final installedApps = await getInstalledApps();
    return UserAppsRequest(list: installedApps);
  }

  /// Filter apps to exclude system apps (optional)
  static List<UserApp> filterUserApps(List<UserApp> allApps) {
    return allApps.where((app) {
      // Filter out system apps and common pre-installed apps
      final systemPackages = [
        'com.android.systemui',
        'com.android.settings',
        'com.android.launcher',
        'com.google.android.gms',
        'com.android.vending',
        'com.android.chrome',
        'com.android.calculator2',
        'com.android.calendar',
        'com.android.camera2',
        'com.android.contacts',
        'com.android.phone',
        'com.android.messaging',
        'com.android.gallery3d',
        'com.android.music',
        'com.android.documentsui',
        'com.android.packageinstaller',
        'com.android.providers.downloads.ui',
        'com.android.inputmethod.latin',
      ];

      // Keep the app if it's not in the system packages list
      return !systemPackages.contains(app.packageName.toLowerCase()) &&
          !app.packageName.startsWith('com.android.') &&
          !app.packageName.startsWith('com.google.android.') &&
          app.name.isNotEmpty &&
          app.packageName.isNotEmpty;
    }).toList();
  }

  /// Get filtered user apps request (excluding system apps)
  static Future<UserAppsRequest> createFilteredUserAppsRequest() async {
    final installedApps = await getInstalledApps();
    final filteredApps = filterUserApps(installedApps);
    return UserAppsRequest(list: filteredApps);
  }
}
