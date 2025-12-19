import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DeviceInfoService {
  static const MethodChannel _channel = MethodChannel('app_info_channel');

  Future<List<List<dynamic>>> getInstallationList() async {
    try {
      final List<dynamic> result = await _channel.invokeMethod('getInstallationList');
      return result.map((e) => List<dynamic>.from(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Failed to get installation list: $e');
      }
      return [];
    }
  }
}