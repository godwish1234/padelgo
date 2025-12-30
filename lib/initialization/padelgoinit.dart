import 'package:flutter/foundation.dart';
import 'package:padelgo/dependency_injection/service_locator.dart';
import 'package:padelgo/helpers/app_tracking_helper.dart';

class PadelGoInit {
  static Future<void> launchInit() async {
    await setupServiceLocator();

    await AppTrackingHelper.initializeTrackingPermissions();
    await _initializeNotificationService();
  }

  static Future<void> _initializeNotificationService() async {
    try {
      // final notificationService = GetIt.instance<NotificationService>();
      // await notificationService.initialize();

      // final authService = GetIt.instance<AuthenticationService>();
      // if (authService.isLoggedIn()) {
      //   await notificationService.uploadFCMToken();
      // }

      if (kDebugMode) {
        print('Notification service initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing notification service: $e');
      }
    }
  }
}
