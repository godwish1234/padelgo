import 'dart:io';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/foundation.dart';

class AppsFlyerUtil {
  static AppsflyerSdk? _appsflyerSdk;

  static String? _afStatus;

  static Future<void> init() async {
    final Map<String, Object> options = {
      "afDevKey":
          Platform.isIOS ? "ErDDv7KwyF6kjTMMNqQKJJ" : "HeifSG89N8czCxtsNEgpqJ",
      "afAppId": Platform.isIOS ? "6749564952" : "com.pilihid.kreditid.padelgo",
      "isDebug": !kReleaseMode,
      "timeToWaitForATTUserAuthorization": 60.0,
    };

    _appsflyerSdk = AppsflyerSdk(options);

    _appsflyerSdk!.onInstallConversionData((res) {
      if (kDebugMode) {
        print("📦 Conversion data: $res");
      }

      try {
        if (res is Map) {
          final payload = res["payload"] ?? res["data"];
          if (payload is Map) {
            final afStatus = payload["af_status"] ?? payload["afStatus"];
            _afStatus = afStatus?.toString();
            if (kDebugMode) {
              print("🎯 af_status: $_afStatus");
            }
          }
        }
      } catch (e) {
        if (kDebugMode) print("⚠️ Error parsing af_status: $e");
      }
    });

    _appsflyerSdk!.onAppOpenAttribution((res) {
      if (kDebugMode) print("📲 onAppOpenAttribution: $res");
    });

    _appsflyerSdk!.onDeepLinking((res) {
      if (kDebugMode) print("🔗 onDeepLinking: $res");
    });

    await _appsflyerSdk!.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );

    if (kDebugMode) {
      print('✅ AppsFlyer SDK initialized');
    }
  }

  static AppsflyerSdk? get instance => _appsflyerSdk;

  static Future<String?> getAppsFlyerUID() async {
    if (_appsflyerSdk != null) {
      return await _appsflyerSdk!.getAppsFlyerUID();
    }
    return null;
  }

  static String? get afStatus => _afStatus;
}
