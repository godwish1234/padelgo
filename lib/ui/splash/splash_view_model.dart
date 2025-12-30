import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:padelgo/ui/base/loading_state_manager.dart';
import 'package:padelgo/config/router_config.dart';
import 'package:padelgo/ui/app_update/app_update_view.dart';
import 'package:padelgo/config/upgrader_config.dart';
import 'package:padelgo/services/interfaces/authentication_service.dart';
import 'package:upgrader/upgrader.dart';

class SplashViewModel extends LoadingAwareViewModel {
  final AuthenticationService _authService =
      GetIt.instance<AuthenticationService>();
  Upgrader? _upgrader;
  BuildContext? _context;

  @override
  void initialize() async {
    super.initialize();

    _upgrader = UpgraderConfig.getUpgrader();
    if (_upgrader != null) {
      await _upgrader?.initialize();
    }

    Future.delayed(const Duration(seconds: 2), () {
      _checkAndNavigate();
    });
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  void _checkAndNavigate() async {
    if (_context == null || !_context!.mounted) return;

    // Check for app update first
    if (_upgrader != null && _upgrader?.isUpdateAvailable() == true) {
      final currentVersion = _upgrader?.currentInstalledVersion;
      final storeVersion = _upgrader?.currentAppStoreVersion;

      final isForceUpdate = AppUpdateView.shouldForceUpdate(
        currentVersion,
        storeVersion,
      );

      Navigator.of(_context!).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => AppUpdateView(
            upgrader: _upgrader!,
            isForceUpdate: isForceUpdate,
            onSkip: isForceUpdate ? null : _navigateBasedOnAuth,
            onUpdate: () {
              _upgrader?.sendUserToAppStore();
            },
          ),
        ),
        (route) => false,
      );
    } else {
      _navigateBasedOnAuth();
    }
  }

  void _navigateBasedOnAuth() async {
    if (_context != null && _context!.mounted) {
      // Check if user is already logged in
      final isLoggedIn = await _authService.isLoggedIn();

      if (isLoggedIn) {
        // User is logged in, navigate to home
        _context!.go(AppRoutes.home);
      } else {
        // User is not logged in, navigate to login
        _context!.go(AppRoutes.login);
      }
    }
  }
}
