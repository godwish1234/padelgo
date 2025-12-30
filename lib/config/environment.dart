import 'package:flutter/foundation.dart';

enum Environment {
  test,
  production,
}

class EnvironmentConfig {
  static Environment get environment {
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'production');
    switch (flavor.toLowerCase()) {
      case 'test':
      case 'dev':
      case 'development':
        return Environment.test;
      case 'production':
      case 'prod':
      default:
        return Environment.production;
    }
  }

  static bool get isTest => environment == Environment.test;
  static bool get isProduction => environment == Environment.production;

  static String get baseUrl {
    switch (environment) {
      case Environment.test:
        return 'http://103.87.67.237';
      case Environment.production:
        return 'http://103.87.67.237';
    }
  }

  static String get displayName {
    switch (environment) {
      case Environment.test:
        return 'Test Environment';
      case Environment.production:
        return 'Production Environment';
    }
  }

  static void printEnvironmentInfo() {
    if (kDebugMode) {
      print('🚀 Starting app with $displayName');
      print('🌐 Base URL: $baseUrl');
      print(
          '🏷️ Flavor: ${const String.fromEnvironment('FLAVOR', defaultValue: 'production')}');
    }
  }
}
