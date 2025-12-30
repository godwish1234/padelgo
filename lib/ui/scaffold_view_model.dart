import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:padelgo/enums/language.dart';
import 'package:padelgo/config/router_config.dart';
import 'package:padelgo/models/user_model.dart';

class ScaffoldViewModel extends BaseViewModel {
  UserModel? user;

  // View Model States
  var _currentNavIndex = 0;
  int get currentNavIndex => _currentNavIndex;

  Locale _locale = Language.englishUS.toLocale();
  Locale get locale => _locale;

  List<Language> get availableLanguages => Language.values;

  void initialize() async {
    notifyListeners();
  }

  Future<void> update() async {
    // var languageIdd = _userSettingsService.getLanguageId();

    // final splitted = languageIdd.replaceAll('-', '_').split('_');
    // _locale = Locale(splitted[0], splitted[1]);

    notifyListeners();
  }

  void updateCurrentIndex(String location) {
    if (location == AppRoutes.home) {
      _currentNavIndex = 0;
    } else if (location == AppRoutes.activity) {
      _currentNavIndex = 1;
    } else if (location == AppRoutes.community) {
      _currentNavIndex = 2;
    } else if (location == AppRoutes.profile) {
      _currentNavIndex = 3;
    }
    notifyListeners();
  }

  void onNavigationItemClicked(BuildContext context, int index) async {
    _currentNavIndex = index;
    notifyListeners();

    switch (index) {
      case 0: // Home
        context.go(AppRoutes.home);
        break;
      case 1: // Activity
        context.go(AppRoutes.activity);
        break;
      case 2: // Community
        context.go(AppRoutes.community);
        break;
      case 3: // Profile
        context.go(AppRoutes.profile);
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setLanguage(Locale locale) async {
    // await _userSettingsService.setLanguageId(locale.toString());
    update();
  }
}
