import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';

class AppTrackingHelper {
  static const String _trackingUsageDescription =
      'This app would like to track your activity across other companies\' apps and websites to provide personalized loan offers and improve our services.';

  static Future<bool> requestTrackingPermission() async {
    try {
      if (!Platform.isIOS) {
        if (kDebugMode) {
          print('ATT: Not on iOS, skipping tracking permission request');
        }
        return true;
      }

      final status = await AppTrackingTransparency.trackingAuthorizationStatus;

      if (kDebugMode) {
        print('ATT: Current tracking status: $status');
      }

      if (status == TrackingStatus.authorized) {
        if (kDebugMode) {
          print('ATT: Tracking already authorized');
        }
        return true;
      }

      if (status == TrackingStatus.denied ||
          status == TrackingStatus.restricted) {
        if (kDebugMode) {
          print('ATT: Tracking denied or restricted');
        }
        return false;
      }

      if (status == TrackingStatus.notDetermined) {
        if (kDebugMode) {
          print('ATT: Requesting tracking permission...');
        }

        final requestResult =
            await AppTrackingTransparency.requestTrackingAuthorization();

        if (kDebugMode) {
          print('ATT: Permission request result: $requestResult');
        }

        return requestResult == TrackingStatus.authorized;
      }

      return false;
    } catch (e) {
      if (kDebugMode) {
        print('ATT: Error requesting tracking permission: $e');
      }
      return false;
    }
  }

  static Future<TrackingStatus> getTrackingStatus() async {
    try {
      if (!Platform.isIOS) {
        return TrackingStatus.authorized;
      }

      return await AppTrackingTransparency.trackingAuthorizationStatus;
    } catch (e) {
      if (kDebugMode) {
        print('ATT: Error getting tracking status: $e');
      }
      return TrackingStatus.notDetermined;
    }
  }

  static Future<bool> isTrackingAuthorized() async {
    final status = await getTrackingStatus();
    return status == TrackingStatus.authorized;
  }

  static String getTrackingExplanation() {
    return _trackingUsageDescription;
  }
  
  static Future<void> initializeTrackingPermissions() async {
    try {
      if (kDebugMode) {
        print('ATT: Initializing tracking permissions...');
      }

      final hasPermission = await requestTrackingPermission();

      if (kDebugMode) {
        if (hasPermission) {
          print(
              'ATT: Tracking permission granted - advertising ID collection enabled');
        } else {
          print(
              'ATT: Tracking permission denied - advertising ID collection disabled');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('ATT: Error initializing tracking permissions: $e');
      }
    }
  }
}
