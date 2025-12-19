import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:easy_localization/easy_localization.dart';

class UpgraderConfig {
  static Upgrader? getUpgrader() {
    if (kDebugMode) {
      return null;
    }

    Upgrader.clearSavedSettings();

    return Upgrader(
      durationUntilAlertAgain: const Duration(days: 1),
      debugDisplayAlways: false,
      debugDisplayOnce: false,
      debugLogging: false,
      countryCode: 'ID',
      messages: UpgraderMessages(code: 'en'),
    );
  }

  static UpgraderMessages getLocalizedMessages(BuildContext context) {
    return UpgraderMessages(
      code: context.locale.languageCode,
    );
  }
}
