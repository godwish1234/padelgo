// Liveness Detection Configuration
//
// This file contains configuration settings for the liveness detection functionality.
// Update these values according to your liveness service provider's requirements.

class LivenessConfig {
  // Liveness License Configuration
  // TODO: Set your actual liveness license here
  // You can get this from your liveness service provider
  static const String livenessLicense = "YOUR_LIVENESS_LICENSE_HERE";

  // API Configuration (if you're fetching license from backend)
  static const String apiBaseUrl = "https://your-api-base-url.com";
  static const String licenseEndpoint = "/api/v1/liveness/license";

  // Liveness Detection Settings
  static const List<int> defaultActions = [1, 2, 3]; // MOUTH, BLINK, POS_YAW
  static const bool shuffleActions = true;
  static const int maxRecordSeconds = 30;
  static const bool enableVideoRecording = false;

  // Timeout Settings
  static const int actionTimeoutMillis = 10000; // 10 seconds
  static const int detectionTimeoutMillis = 30000; // 30 seconds

  // Quality Settings
  static const int resultPictureSize = 600; // pixels
  static const int imageQuality = 80; // 0-100

  // Detection Configuration
  static const bool detectOcclusion = true;
  static const String detectionLevel = "NORMAL"; // EASY, NORMAL, HARD
}

// Usage Instructions:
//
// 1. Replace "YOUR_LIVENESS_LICENSE_HERE" with your actual license
// 2. Update apiBaseUrl if you're fetching license from your backend
// 3. Adjust detection settings according to your requirements
// 4. Import this file in your liveness service: import 'package:padelgo/config/liveness_config.dart';
