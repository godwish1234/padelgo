import 'package:flutter/material.dart';
import 'package:padelgo/ui/components/route_transition.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PageStackEntry {
  final Type pageType;
  final int pageId;

  PageStackEntry(this.pageType, this.pageId);
}

class NavigationService {
  List<PageStackEntry> get pageStack => List.unmodifiable(_pageStack);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool _isSystemBack = true;
  bool _isHandlingPop = false;
  bool _isLoggingEvent = false;

  bool get isAppBarNavigation => !_isSystemBack;
  bool get isHandlingPop => _isHandlingPop;
  bool get isLoggingEvent => _isLoggingEvent;

  final List<PageStackEntry> _pageStack = [];

  Future<dynamic> push(Widget page, {String? orderNo, int? status}) async {
    final result = navigatorKey.currentState!.push(
      createRoute(page),
    );

    return result;
  }

  Future<dynamic> pushReplacement(Widget page) async {
    final result = navigatorKey.currentState!.pushReplacement(
      createRoute(page),
    );

    return result;
  }

  Future<dynamic> pushAndRemoveUntil(Widget page) async {
    final result = navigatorKey.currentState!.pushAndRemoveUntil(
      createRoute(page),
      (route) => false,
    );

    return result;
  }

  Future<void> pop<T>([T? result]) async {
    _isHandlingPop = true;

    try {
      if (_pageStack.isNotEmpty) {
        _pageStack.removeLast();
      }

      navigatorKey.currentState!.pop<T>(result);
    } finally {
      _isSystemBack = true;
      _isHandlingPop = false;
    }
  }

  Future<void> popDialog<T>([T? result]) async {
    _isSystemBack = false;
    _isHandlingPop = true;

    try {
      navigatorKey.currentState!.pop<T>(result);
    } finally {
      _isSystemBack = true;
      _isHandlingPop = false;
    }
  }

  Future<void> popFromAppBar<T>([T? result, Type? returnToPageType]) async {
    _isSystemBack = false;
    _isHandlingPop = true;
    _isLoggingEvent = true;

    try {
      if (_pageStack.isNotEmpty) {
        _pageStack.removeLast();
      }

      if (_pageStack.isNotEmpty) {
        final previousEntry = _pageStack.last;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('current_page_id', previousEntry.pageId);
      }

      navigatorKey.currentState!.pop<T>(result);
    } finally {
      _isSystemBack = true;
      _isHandlingPop = false;
      _isLoggingEvent = false;
    }
  }
}
