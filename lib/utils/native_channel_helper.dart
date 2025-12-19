import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:padelgo/models/installed_app_info.dart';

class NativeChannelHelper {
  static final NativeChannelHelper _singleton = NativeChannelHelper._internal();

  factory NativeChannelHelper() {
    return _singleton;
  }

  NativeChannelHelper._internal();

  final MethodChannel _channel = const MethodChannel('padelgo/common');

  void toIntentActionView(String url) {
    _channel.invokeMethod(METHOD_OPEN_INTENT_ACTION_VIEW, {'targetUrl': url});
  }

  Future<String> getDeviceInfo() {
    return _channel.invokeMethod(METHOD_GET_DEVICE_INFO).then((value) {
      if (value is String) {
        return value;
      }
      return "";
    });
  }

  Future<String> getInstallation() {
    return _channel.invokeMethod(METHOD_INSTALLATION).then((value) {
      if (value is String) {
        return value;
      }
      return "";
    });
  }

  Future<List<InstalledAppInfo>> getInstallAppInfo(
      {List<String> apps = const []}) {
    return _channel.invokeMethod(
        METHOD_GET_INSTALL_APP_INFO, {'appList': apps}).then((value) {
      if (value is String) {
        try {
          List jsonMap = json.decode(value);
          List<InstalledAppInfo> appInfoList = [];
          for (var element in jsonMap) {
            appInfoList.add(InstalledAppInfo(
                name: element['name'] ?? '',
                package: element['packageName'] ?? '',
                version: element['version'] ?? '',
                installtime: element['installtime'] ?? '',
                lastUpdateTime: element['last_update_time'] ?? ''));
          }
          return appInfoList;
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
      return [];
    });
  }

  final String METHOD_OPEN_INTENT_ACTION_VIEW = "intent_action_view";
  final String METHOD_GET_DEVICE_INFO = "get_device_info";
  final String METHOD_GET_INSTALL_APP_INFO = "get_install_app_info";
  final String METHOD_INSTALLATION = "installation";
}
