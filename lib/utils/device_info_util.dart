import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:advertising_id/advertising_id.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:safe_device/safe_device.dart';
import 'package:padelgo/helpers/preference_helper.dart';

class DeviceInfoUtil {
  static const MethodChannel _channel = MethodChannel('app_info_channel');

  static Future<Map<String, dynamic>> generateDeviceInfoPayload(
      int userId) async {
    final deviceData = await _collectDeviceInfo();

    return {
      "userId": userId,
      "list": [deviceData]
    };
  }

  static Future<Map<String, dynamic>> _collectDeviceInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();

    Map<String, dynamic> deviceData = {
      "deviceId": await _getDeviceId(),
      "imei": await _getImei(),
      "os": Platform.isAndroid ? "Android" : "iOS",
      "model": await _getModel(),
      "version": await _getOSVersion(),
      "carrier": await _getCarrier(),
      "deviceFingerprint": await _getDeviceFingerprint(),
      "advertisingId": await _getAdvertisingId(),
      "brand": await _getBrand(),
      "totalRam": await _getTotalRam(),
      "currentRam": await _getCurrentRam(),
      "totalRom": await _getTotalRom(),
      "currentRom": await _getCurrentRom(),
      "deviceResolution": await _getDeviceResolution(),
      "totalBootedTime": await _getTotalBootedTime(),
      "currentBatteryLevel": await _getCurrentBatteryLevel(),
      "currentUsbStatus": await _getCurrentUsbStatus(),
      "phoneNumber": await _getPhoneNumber(),
      "appVersion": packageInfo.version,
      "country": await _getCountry(),
      "language": await _getLanguage(),
      "netType": await _getNetworkType(),
      "isRoot": await _isRooted() ? 1 : 0,
      "isEmulator": await _isEmulator() ? 1 : 0,
      "altitude": await _getAltitude(),
      "pressure": await _getPressure(),
      "ip": await _getIpAddress(),
      "regId": await _getRegId(),
      "androidId": await _getAndroidId(),
      "ikiDeviceId": await _getIkiDeviceId(),
      "userLevel": 0,
      "firmwareNo": await _getFirmwareNo(),
      "builderHost": await _getBuilderHost(),
      "builderTag": await _getBuilderTag(),
      "bootTime": await _getBootTime(),
      "timeZone": await _getTimeZone(),
      "screenBrightness": await _getScreenBrightness(),
      "chargeStatus": await _getChargeStatus(),
      "batteryTemperature": await _getBatteryTemperature(),
      "systemInitializeId": await _getSystemInitializeId(),
      "cpuMaxFrequency": await _getCpuMaxFrequency(),
      "cpuFramework": await _getCpuFramework(),
      "cpuModel": await _getCpuModel(),
      "totalMemory": await _getTotalMemory(),
      "availableMemory": await _getAvailableMemory(),
      "basebandVersion": await _getBasebandVersion(),
      "kernelVersion": await _getKernelVersion(),
      "wifiName": await _getWifiName(),
      "wifiIp": await _getWifiIp(),
      "wifiMacAddress": await _getWifiMacAddress(),
      "wifiBssid": await _getWifiBssid(),
      "wifiGateWay": await _getWifiGateWay(),
      "wifiNetMask": await _getWifiNetMask(),
      "wifiMainDns": await _getWifiMainDns(),
      "wifiAssistantDns": await _getWifiAssistantDns(),
      "blueToothMacAddress": await _getBlueToothMacAddress(),
      "stepNum": await _getStepNum(),
      "orientationAngle": await _getOrientationAngle(),
      "pitchAngle": await _getPitchAngle(),
      "rollAngle": await _getRollAngle(),
      "mutiApp": await _getMutiApp(),
      "mutiAppLevel": await _getMutiAppLevel(),
      "mutiAppPm": await _getMutiAppPm(),
      "mutiAppPmList": await _getMutiAppPmList(),
      "mutiCheckService": await _getMutiCheckService(),
      "mutiCheckPath": await _getMutiCheckPath(),
      "filesDirPath": await _getFilesDirPath(),
      "scanWifiList": await _getScanWifiList(),
      "historyConnectWifiList": await _getHistoryConnectWifiList(),
    };

    return deviceData;
  }

  static Future<String> _getDeviceId() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id;
      } else {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? '';
      }
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getImei() async {
    try {
      if (Platform.isAndroid) {
        final imeiInfo = await _channel.invokeMethod('getImeiInfo');
        if (imeiInfo is List && imeiInfo.isNotEmpty) {
          return imeiInfo[0]?.toString() ?? '';
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getModel() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.model;
      } else {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.model;
      }
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getOSVersion() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.version.release;
      } else {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.systemVersion;
      }
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getBrand() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.brand;
      } else {
        return 'Apple';
      }
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getAdvertisingId() async {
    try {
      // Check if we have stored GAID
      String? storedGaid = await PkPreferenceHelper.getGaid();
      if (storedGaid != null && storedGaid.isNotEmpty) {
        return storedGaid;
      }

      // Get new GAID
      final gaid = await AdvertisingId.id(true) ?? '';
      if (gaid.isNotEmpty) {
        await PkPreferenceHelper.saveGaid(gaid);
      }
      return gaid;
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getLanguage() async {
    try {
      final languages = await Devicelocale.preferredLanguages;
      return languages?.first ?? '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getCountry() async {
    try {
      final locale = await Devicelocale.currentLocale;
      if (locale != null && locale.length >= 5) {
        return locale.split('_').last;
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getNetworkType() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi)) {
        return 'WiFi';
      } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
        return 'Mobile';
      } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
        return 'Ethernet';
      }
      return 'None';
    } catch (e) {
      return '';
    }
  }

  static Future<bool> _isRooted() async {
    try {
      return await SafeDevice.isJailBroken;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> _isEmulator() async {
    try {
      return !(await SafeDevice.isRealDevice);
    } catch (e) {
      return false;
    }
  }

  static Future<String> _getCarrier() async {
    try {
      if (Platform.isAndroid) {
        final localeInfo = await _channel.invokeMethod('getLocaleInfo');
        if (localeInfo is Map) {
          return localeInfo['network_operator_name']?.toString() ?? '';
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getDeviceFingerprint() async {
    try {
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.fingerprint;
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getTotalRam() async {
    try {
      if (Platform.isAndroid) {
        final storageInfo = await _channel.invokeMethod('getStorageInfo');
        if (storageInfo is Map) {
          final totalRam = storageInfo['ram_total_size'];
          if (totalRam != null) {
            final totalRamMB = (totalRam / (1024 * 1024)).round();
            return '${totalRamMB}MB';
          }
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getCurrentRam() async {
    try {
      if (Platform.isAndroid) {
        final storageInfo = await _channel.invokeMethod('getStorageInfo');
        if (storageInfo is Map) {
          final usedRam = storageInfo['ram_used_size'];
          if (usedRam != null) {
            final usedRamMB = (usedRam / (1024 * 1024)).round();
            return '${usedRamMB}MB';
          }
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getTotalRom() async {
    try {
      if (Platform.isAndroid) {
        final storageInfo = await _channel.invokeMethod('getStorageInfo');
        if (storageInfo is Map) {
          final totalRom = storageInfo['internal_storage_total'];
          if (totalRom != null) {
            final totalRomGB = (totalRom / (1024 * 1024 * 1024)).round();
            return '${totalRomGB}GB';
          }
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getCurrentRom() async {
    try {
      if (Platform.isAndroid) {
        final storageInfo = await _channel.invokeMethod('getStorageInfo');
        if (storageInfo is Map) {
          final totalRom = storageInfo['internal_storage_total'];
          final usableRom = storageInfo['internal_storage_usable'];
          if (totalRom != null && usableRom != null) {
            final usedRom = totalRom - usableRom;
            final usedRomGB = (usedRom / (1024 * 1024 * 1024)).round();
            return '${usedRomGB}GB';
          }
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getDeviceResolution() async {
    try {
      if (Platform.isAndroid) {
        final screenInfo = await _channel.invokeMethod('getScreenInfo');
        if (screenInfo is Map) {
          final resolution = screenInfo['displayMetrics']?.toString() ?? '';
          // Limit resolution to 15 characters to fit database column
          return resolution.length > 15
              ? resolution.substring(0, 15)
              : resolution;
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getTotalBootedTime() async {
    try {
      if (Platform.isAndroid) {
        final generalInfo = await _channel.invokeMethod('getGeneralInfo');
        if (generalInfo is Map) {
          return generalInfo['elapsed_realtime']?.toString() ?? '';
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getCurrentBatteryLevel() async {
    try {
      if (Platform.isAndroid) {
        final batteryStatus = await _channel.invokeMethod('getBatteryStatus');
        if (batteryStatus is Map) {
          return batteryStatus['battery_pct']?.toString() ?? '';
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getCurrentUsbStatus() async {
    try {
      if (Platform.isAndroid) {
        final batteryStatus = await _channel.invokeMethod('getBatteryStatus');
        if (batteryStatus is Map) {
          final isUsbCharge = batteryStatus['is_usb_charge'] ?? 0;
          return isUsbCharge == 1 ? 'Connected' : 'Disconnected';
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getPhoneNumber() async {
    try {
      if (Platform.isAndroid) {
        final imeiInfo = await _channel.invokeMethod('getImeiInfo');
        if (imeiInfo is List && imeiInfo.length > 2) {
          return imeiInfo[2]?.toString() ?? '';
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<double> _getAltitude() async => 0.0;
  static Future<double> _getPressure() async => 0.0;

  static Future<String> _getIpAddress() async {
    try {
      if (Platform.isAndroid) {
        final networkInfo = await _channel.invokeMethod('getNetworkInfo');
        if (networkInfo is List && networkInfo.length > 1) {
          return networkInfo[1]?.toString() ?? '';
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getRegId() async =>
      await PkPreferenceHelper.getFcmRegId();

  static Future<String> _getAndroidId() async {
    try {
      if (Platform.isAndroid) {
        final androidId = await _channel.invokeMethod('getAndroidId');
        return androidId?.toString() ?? '';
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getIkiDeviceId() async => '';

  static Future<String> _getFirmwareNo() async {
    try {
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.version.release;
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getBuilderHost() async {
    try {
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.host;
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getBuilderTag() async {
    try {
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.tags;
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getBootTime() async {
    try {
      if (Platform.isAndroid) {
        final buildTime = await _channel.invokeMethod('getBuildTime');
        return buildTime?.toString() ?? '';
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getTimeZone() async => DateTime.now().timeZoneName;

  static Future<String> _getScreenBrightness() async => '';

  static Future<int> _getChargeStatus() async {
    try {
      if (Platform.isAndroid) {
        final batteryStatus = await _channel.invokeMethod('getBatteryStatus');
        if (batteryStatus is Map) {
          return batteryStatus['is_charging'] ?? 0;
        }
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  static Future<String> _getBatteryTemperature() async {
    try {
      if (Platform.isAndroid) {
        final batteryStatus = await _channel.invokeMethod('getBatteryStatus');
        if (batteryStatus is Map) {
          return batteryStatus['temperature']?.toString() ?? '';
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getSystemInitializeId() async => '';
  static Future<String> _getCpuMaxFrequency() async => '';
  static Future<String> _getCpuFramework() async => '';
  static Future<String> _getCpuModel() async => '';

  static Future<String> _getTotalMemory() async {
    try {
      if (Platform.isAndroid) {
        final storageInfo = await _channel.invokeMethod('getStorageInfo');
        if (storageInfo is Map) {
          final totalMemoryBytes = storageInfo['ram_total_size'];
          if (totalMemoryBytes != null) {
            // Convert bytes to MB and limit to 10 characters
            final totalMemoryMB = (totalMemoryBytes / (1024 * 1024)).round();
            return '${totalMemoryMB}MB';
          }
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getAvailableMemory() async {
    try {
      if (Platform.isAndroid) {
        final storageInfo = await _channel.invokeMethod('getStorageInfo');
        if (storageInfo is Map) {
          final availableMemoryBytes = storageInfo['ram_usable_size'];
          if (availableMemoryBytes != null) {
            // Convert bytes to MB and limit to 10 characters
            final availableMemoryMB =
                (availableMemoryBytes / (1024 * 1024)).round();
            return '${availableMemoryMB}MB';
          }
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getBasebandVersion() async => '';
  static Future<String> _getKernelVersion() async => '';

  static Future<String> _getWifiName() async {
    try {
      if (Platform.isAndroid) {
        final networkInfo = await _channel.invokeMethod('getNetworkInfo');
        if (networkInfo is List &&
            networkInfo.length > 4 &&
            networkInfo[4] is List) {
          final currentWifi = networkInfo[4] as List;
          if (currentWifi.isNotEmpty) {
            return currentWifi[0]?.toString() ?? '';
          }
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getWifiIp() async {
    try {
      if (Platform.isAndroid) {
        final networkInfo = await _channel.invokeMethod('getNetworkInfo');
        if (networkInfo is List && networkInfo.length > 1) {
          return networkInfo[1]?.toString() ?? '';
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getWifiMacAddress() async {
    try {
      if (Platform.isAndroid) {
        final networkInfo = await _channel.invokeMethod('getNetworkInfo');
        if (networkInfo is List && networkInfo.length > 2) {
          return networkInfo[2]?.toString() ?? '';
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getWifiBssid() async {
    try {
      if (Platform.isAndroid) {
        final networkInfo = await _channel.invokeMethod('getNetworkInfo');
        if (networkInfo is List &&
            networkInfo.length > 4 &&
            networkInfo[4] is List) {
          final currentWifi = networkInfo[4] as List;
          if (currentWifi.length > 1) {
            return currentWifi[1]?.toString() ?? '';
          }
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getWifiGateWay() async => '';
  static Future<String> _getWifiNetMask() async => '';
  static Future<String> _getWifiMainDns() async => '';
  static Future<String> _getWifiAssistantDns() async => '';

  static Future<String> _getBlueToothMacAddress() async {
    try {
      if (Platform.isAndroid) {
        final networkInfo = await _channel.invokeMethod('getNetworkInfo');
        if (networkInfo is List && networkInfo.length > 3) {
          return networkInfo[3]?.toString() ?? '';
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<int> _getStepNum() async => 0;

  static Future<String> _getOrientationAngle() async {
    try {
      if (Platform.isAndroid) {
        final screenInfo = await _channel.invokeMethod('getScreenInfo');
        if (screenInfo is Map) {
          return screenInfo['orientation']?.toString() ?? '';
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getPitchAngle() async {
    try {
      if (Platform.isAndroid) {
        final phoneTilt = await _channel.invokeMethod('getPhoneTilt');
        return phoneTilt?.toString() ?? '';
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getRollAngle() async => '';

  static Future<int> _getMutiApp() async {
    try {
      if (Platform.isAndroid) {
        final generalInfo = await _channel.invokeMethod('getGeneralInfo');
        if (generalInfo is Map) {
          return generalInfo['is_simulator'] ?? 0;
        }
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  static Future<int> _getMutiAppLevel() async => 0;
  static Future<String> _getMutiAppPm() async => '';
  static Future<String> _getMutiAppPmList() async => '';
  static Future<String> _getMutiCheckService() async => '';
  static Future<String> _getMutiCheckPath() async => '';
  static Future<String> _getFilesDirPath() async => '';

  static Future<String> _getScanWifiList() async {
    try {
      if (Platform.isAndroid) {
        final networkInfo = await _channel.invokeMethod('getNetworkInfo');
        if (networkInfo is List &&
            networkInfo.length > 5 &&
            networkInfo[5] is List) {
          final configuredNetworks = networkInfo[5] as List;
          return configuredNetworks
              .map((network) =>
                  network is List ? network.join(',') : network.toString())
              .join(';');
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static Future<String> _getHistoryConnectWifiList() async => '';

  static Future<Map<String, dynamic>> getDeviceData() async {
    return await _collectDeviceInfo();
  }

  static Future<Map<String, dynamic>> prepareUploadPayload(int userId) async {
    return await generateDeviceInfoPayload(userId);
  }
}
