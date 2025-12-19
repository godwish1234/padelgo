import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:liveness_plugin/liveness_plugin.dart';
import 'package:padelgo/config/liveness_config.dart';
import 'package:get_it/get_it.dart';
import 'package:padelgo/services/interfaces/ocr_service.dart';

class LivenessService {
  static void initSDK({Market market = Market.BPS}) {
    LivenessPlugin.initSDKOfLicense(market);
  }

  static Future<String?> getLivenessLicense() async {
    try {
      final ocrService = GetIt.instance<OcrService>();
      final licenseEntity = await ocrService.getLivenessLicense();

      if (licenseEntity != null &&
          licenseEntity.isSuccess &&
          licenseEntity.license != null) {
        if (kDebugMode) {
          print(
              'Liveness license retrieved from API: ${licenseEntity.license}');
          print('License expires: ${licenseEntity.expiredTime}');
        }
        return licenseEntity.license;
      }

      if (LivenessConfig.livenessLicense != "YOUR_LIVENESS_LICENSE_HERE" &&
          LivenessConfig.livenessLicense.isNotEmpty) {
        if (kDebugMode) {
          print('Using fallback license from config');
        }
        return LivenessConfig.livenessLicense;
      }

      if (kDebugMode) {
        print('No license available from API or config');
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting liveness license: $e');
      }

      if (LivenessConfig.livenessLicense != "YOUR_LIVENESS_LICENSE_HERE" &&
          LivenessConfig.livenessLicense.isNotEmpty) {
        if (kDebugMode) {
          print('Using fallback license due to API error');
        }
        return LivenessConfig.livenessLicense;
      }

      return null;
    }
  }

  static Future<String> startLivenessDetection({
    List<int>? actions,
    Function? onShowLoading,
    Function? onHideLoading,
  }) async {
    final Completer<String> completer = Completer();
    String livenessId = "";

    try {
      onShowLoading?.call();

      final license = await getLivenessLicense();

      if (license != null && license.isNotEmpty) {
        initSDK();

        final licenseResult = await LivenessPlugin.setLicenseAndCheck(license);

        onHideLoading?.call();

        if (kDebugMode) {
          print('License check result: $licenseResult');
        }

        if (licenseResult == "SUCCESS") {
          List<int> livenessActions =
              actions ?? [1, 2, 3]; // MOUTH, BLINK, POS_YAW

          LivenessUtil.startLiveness(livenessActions,
              (bool isSuccess, Map? resultMap) {
            if (kDebugMode) {
              print("Liveness result: $isSuccess, data: $resultMap");
            }

            if (isSuccess && resultMap != null) {
              livenessId = resultMap["livenessId"] ?? "";
            }

            completer.complete(livenessId);
          });
        } else {
          completer.complete("");
        }
      } else {
        onHideLoading?.call();
        if (kDebugMode) {
          print('No license available');
        }
        completer.complete("");
      }
    } catch (e) {
      onHideLoading?.call();
      if (kDebugMode) {
        print('Error in liveness detection: $e');
      }
      completer.complete("");
    }

    return completer.future;
  }

  static Future<String> startLivenessWithCustomActions({
    List<int>? actionConfig,
    Function? onShowLoading,
    Function? onHideLoading,
  }) async {
    return startLivenessDetection(
      actions: actionConfig,
      onShowLoading: onShowLoading,
      onHideLoading: onHideLoading,
    );
  }

  static void configureLiveness({
    bool shuffle = true,
    List<DetectionType>? detectionTypes,
    DetectionLevel level = DetectionLevel.NORMAL,
    bool recordVideo = false,
    int maxRecordSeconds = 30,
  }) {
    if (detectionTypes != null) {
      LivenessPlugin.setActionSequence(shuffle, detectionTypes);
    }

    LivenessPlugin.setDetectionLevel(level);
    LivenessPlugin.setVideoConfig(recordVideo, maxRecordSeconds);
  }
}
