import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:padelgo/initialization/services/navigation_service.dart';
import 'package:padelgo/ui/base/loading_state_manager.dart';
import 'package:padelgo/config/router_config.dart';
import 'package:padelgo/ui/app_update/app_update_view.dart';
import 'package:padelgo/config/upgrader_config.dart';
import 'package:upgrader/upgrader.dart';

class SplashViewModel extends LoadingAwareViewModel {
  final NavigationService _navigationService =
      GetIt.instance<NavigationService>();
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

  void _checkAndNavigate() {
    if (_context == null || !_context!.mounted) return;

    if (_upgrader != null && _upgrader?.isUpdateAvailable() == true) {
      final currentVersion = _upgrader?.currentInstalledVersion;
      final storeVersion = _upgrader?.currentAppStoreVersion;

      final isForceUpdate = AppUpdateView.shouldForceUpdate(
        currentVersion,
        storeVersion,
      );

      _navigationService.pushAndRemoveUntil(
        AppUpdateView(
          upgrader: _upgrader!,
          isForceUpdate: isForceUpdate,
          onSkip: isForceUpdate ? null : _navigateToHome,
          onUpdate: () {
            _upgrader?.sendUserToAppStore();
          },
        ),
      );
    } else {
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    if (_context != null && _context!.mounted) {
      _context!.go(AppRoutes.home);
    }
  }
}
