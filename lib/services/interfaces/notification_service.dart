import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationService {
  Future<void> initialize();
  Future<String?> getFCMToken();
  Future<void> requestPermission();
  Future<void> subscribeToTopic(String topic);
  Future<void> unsubscribeFromTopic(String topic);
  void handleForegroundMessage(RemoteMessage message);
  void handleBackgroundMessage(RemoteMessage message);
  void handleNotificationTap(RemoteMessage message);
  Future<void> uploadFCMToken();
}
