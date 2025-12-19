import 'package:liveness_plugin/liveness_plugin.dart';

class LivenessUtil {
  /// Starts liveness detection with specified actions
  ///
  /// [action] List of integers representing detection types:
  /// - 1: MOUTH action
  /// - 2: BLINK action
  /// - 3: POS_YAW (head turn) action
  ///
  /// [livenessCallback] Callback function to handle detection results
  static startLiveness(List<int>? action, LivenessCallback livenessCallback) {
    if (action?.isNotEmpty ?? false) {
      List<DetectionType> act = [];
      action?.forEach((element) {
        if (element == 1) {
          act.add(DetectionType.MOUTH);
        } else if (element == 2) {
          act.add(DetectionType.BLINK);
        } else if (element == 3) {
          act.add(DetectionType.POS_YAW);
        }
      });

      if (act.length > 0) {
        LivenessPlugin.setActionSequence(true, act);
      }
    }

    LivenessPlugin.startLivenessDetection(
        _LivenessResultCallback(livenessCallback));
  }
}

/// Internal callback class that implements LivenessDetectionCallback
/// and forwards results to the user-provided callback
class _LivenessResultCallback extends LivenessDetectionCallback {
  LivenessCallback livenessCallback;

  _LivenessResultCallback(this.livenessCallback);

  @override
  void onGetDetectionResult(bool isSuccess, Map? resultMap) {
    // Expected result format:
    // {isSuccess: true, livenessId: 26a6f415-a45a-4edb-b460-4920db7e057c,
    // message: SUCCESS, imageSequenceList: [], base64Image: ...}
    livenessCallback(isSuccess, resultMap);
  }
}

/// Typedef for the liveness detection callback function
///
/// [isSuccess] Whether the liveness detection was successful
/// [resultMap] Map containing detection results including livenessId, message, etc.
typedef LivenessCallback = Function(bool isSuccess, Map? resultMap);
