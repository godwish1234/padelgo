import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:padelgo/enums/language.dart';
import 'package:padelgo/helpers/preference_helper.dart';

class LanguageService {
  static final LanguageService _instance = LanguageService._internal();
  factory LanguageService() => _instance;
  LanguageService._internal();

  static LanguageService get instance => _instance;

  Future<void> changeLanguage(BuildContext context, Language language) async {
    try {
      await PkPreferenceHelper.saveSelectedLanguage(language.id);

      await context.setLocale(language.toLocale());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeLanguageAfterModalDismiss(
      BuildContext context, Language language) async {
    try {
      await PkPreferenceHelper.saveSelectedLanguage(language.id);

      await Future.delayed(const Duration(milliseconds: 150));

      if (context.mounted) {
        await context.setLocale(language.toLocale());
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeLanguageSafely(
      BuildContext context, Language language) async {
    try {
      await PkPreferenceHelper.saveSelectedLanguage(language.id);

      if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.idle) {
        await context.setLocale(language.toLocale());
      } else {
        final completer = Completer<void>();
        SchedulerBinding.instance.addPostFrameCallback((_) async {
          if (context.mounted) {
            await context.setLocale(language.toLocale());
          }
          completer.complete();
        });
        await completer.future;
      }
    } catch (e) {
      rethrow;
    }
  }

  Language getCurrentLanguage(BuildContext context) {
    return Language.fromLocale(context.locale) ?? Language.englishUS;
  }

  String getCurrentLanguageDisplay(BuildContext context) {
    final currentLanguage = getCurrentLanguage(context);
    switch (currentLanguage) {
      case Language.englishUS:
        return 'English';
      case Language.bahasa:
        return 'Bahasa Indonesia';
    }
  }
}
