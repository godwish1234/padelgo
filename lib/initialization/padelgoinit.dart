import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:padelgo/dependency_injection/service_locator.dart';
import 'package:padelgo/helpers/app_tracking_helper.dart';
import 'package:padelgo/services/interfaces/authentication_service.dart';
import 'package:padelgo/services/interfaces/location_service.dart';
import 'package:padelgo/services/interfaces/startup_service.dart';
import 'package:padelgo/services/interfaces/notification_service.dart';
import 'package:padelgo/utils/secure_storage_util.dart';

class PadelGoInit {
  static Future<void> launchInit() async {
    await setupServiceLocator();

    await AppTrackingHelper.initializeTrackingPermissions();
    _initializeDeviceInfo();
    await _initializeLocationData();
    await _initializeNotificationService();
  }

  static Future<void> _initializeNotificationService() async {
    try {
      final notificationService = GetIt.instance<NotificationService>();
      await notificationService.initialize();

      final authService = GetIt.instance<AuthenticationService>();
      if (authService.isLoggedIn()) {
        await notificationService.uploadFCMToken();
      }

      if (kDebugMode) {
        print('Notification service initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing notification service: $e');
      }
    }
  }

  static Future<void> _initializeDeviceInfo() async {
    try {
      final authService = GetIt.instance<AuthenticationService>();

      if (authService.isLoggedIn()) {}

      final startupService = GetIt.instance<StartupService>();
      final response = await startupService.uploadDeviceInfo();

      if (response?.isSuccess == true) {
        final deviceId = response?.deviceId ?? '';

        if (deviceId.isNotEmpty) {
          FirebaseCrashlytics.instance.setCustomKey("deviceUUID", deviceId);
        }
      } else {
        if (kDebugMode) {
          print('Device upload failed: ${response?.msg ?? 'Unknown error'}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing device info: $e');
      }
    }
  }

  static Future<void> _initializeLocationData() async {
    try {
      final locationService = GetIt.instance<LocationService>();

      final storedLocation = await locationService.getStoredLocationData();

      if (storedLocation == null ||
          storedLocation.ipAddress == null ||
          storedLocation.ipAddress == '0.0.0.0' ||
          storedLocation.ipAddress!.isEmpty) {
        if (kDebugMode) {
          print('No valid IP address stored - retrieving IP address...');
        }
        await _updateIpAddressSync();
      } else {
        if (kDebugMode) {
          print(
              'Using existing location data from storage (IP: ${storedLocation.ipAddress})');
        }
        _updateIpAddressInBackground();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing location data: $e');
      }
    }
  }

  static Future<void> _updateIpAddressSync() async {
    try {
      final locationService = GetIt.instance<LocationService>();

      final ipAddress = await locationService.getIpAddress();

      if (ipAddress != null && ipAddress.isNotEmpty) {
        await SecureStorageUtil.saveIpAddress(ipAddress);
        await SecureStorageUtil.saveLocationTimestamp(
            DateTime.now().millisecondsSinceEpoch.toString());

        if (kDebugMode) {
          print('✅ IP address retrieved and saved successfully: $ipAddress');
        }
      } else {
        if (kDebugMode) {
          print('⚠️ Failed to get IP address - will retry later');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ IP address update failed: $e');
      }
    }
  }

  static void _updateIpAddressInBackground() {
    Future.microtask(() async {
      try {
        final locationService = GetIt.instance<LocationService>();

        final ipAddress = await locationService.getIpAddress();

        if (ipAddress != null) {
          await SecureStorageUtil.saveIpAddress(ipAddress);
          await SecureStorageUtil.saveLocationTimestamp(
              DateTime.now().millisecondsSinceEpoch.toString());

          if (kDebugMode) {
            print('IP address updated successfully: $ipAddress');
          }
        } else {
          if (kDebugMode) {
            print('Failed to get IP address');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Background IP address update failed: $e');
        }
      }
    });
  }

  static Future<bool> updateLocationDataAfterLogin() async {
    try {
      final locationService = GetIt.instance<LocationService>();

      if (kDebugMode) {
        print('Updating location data after login...');
      }

      final ipAddress = await locationService.getIpAddress();
      if (kDebugMode) {
        print('Retrieved IP address: $ipAddress');
      }

      final hasPermission = await locationService.hasLocationPermission();

      if (!hasPermission) {
        final granted = await locationService.requestLocationPermission();
        if (!granted) {
          if (kDebugMode) {
            print('Location permission denied - saving IP only');
          }
          if (ipAddress != null && ipAddress.isNotEmpty) {
            try {
              await SecureStorageUtil.saveIpAddress(ipAddress);
              await SecureStorageUtil.saveLocationTimestamp(
                  DateTime.now().millisecondsSinceEpoch.toString());
              if (kDebugMode) {
                print('✅ IP address saved successfully without GPS location');
              }
              return true;
            } catch (e) {
              if (kDebugMode) {
                print('Failed to save IP address: $e');
              }
            }
          }
          return false;
        }
      }

      final location = await locationService.getCurrentLocation();

      if (location != null && ipAddress != null) {
        await locationService.saveLocationData(location, ipAddress);
        return true;
      } else if (ipAddress != null && ipAddress.isNotEmpty) {
        try {
          await SecureStorageUtil.saveIpAddress(ipAddress);
          await SecureStorageUtil.saveLocationTimestamp(
              DateTime.now().millisecondsSinceEpoch.toString());
          if (kDebugMode) {
            print('✅ IP address saved successfully (GPS location unavailable)');
          }
          return true;
        } catch (e) {
          if (kDebugMode) {
            print('Failed to save IP address: $e');
          }
          return false;
        }
      } else {
        if (kDebugMode) {
          print('❌ Failed to get IP address after login');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Location update after login failed: $e');
      }
      return false;
    }
  }
}
