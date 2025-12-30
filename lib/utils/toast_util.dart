import 'package:flutter/material.dart';
import 'package:padelgo/config/router_config.dart' as app_router;

enum ToastType { success, error, warning, info }

class ToastUtil {
  static void showError(String message, {BuildContext? context}) {
    _showSnackBar(
      message: message,
      type: ToastType.error,
      context: context,
    );
  }

  static void showSuccess(String message, {BuildContext? context}) {
    _showSnackBar(
      message: message,
      type: ToastType.success,
      context: context,
    );
  }

  static void showInfo(String message, {BuildContext? context}) {
    _showSnackBar(
      message: message,
      type: ToastType.info,
      context: context,
    );
  }

  static void showWarning(String message, {BuildContext? context}) {
    _showSnackBar(
      message: message,
      type: ToastType.warning,
      context: context,
    );
  }

  static void show(
    String message, {
    BuildContext? context,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
  }) {
    _showSnackBar(
      message: message,
      type: ToastType.info,
      context: context,
      customBackground: backgroundColor,
      customTextColor: textColor,
      customIcon: icon,
    );
  }

  static void _showSnackBar({
    required String message,
    required ToastType type,
    BuildContext? context,
    Color? customBackground,
    Color? customTextColor,
    IconData? customIcon,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        BuildContext? toastContext = context;

        if (toastContext == null || !toastContext.mounted) {
          toastContext = app_router
              .RouterConfig.router.routerDelegate.navigatorKey.currentContext;
        }

        if (toastContext == null || !toastContext.mounted) {
          debugPrint('No valid context for toast: $message');
          return;
        }

        // Get toast configuration based on type
        final config = _getToastConfig(
          type,
          customBackground: customBackground,
          customTextColor: customTextColor,
          customIcon: customIcon,
        );

        ScaffoldMessenger.of(toastContext).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(
                  config.icon,
                  color: config.iconColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: config.textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: config.backgroundColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
            duration: type == ToastType.error
                ? const Duration(seconds: 4)
                : const Duration(seconds: 3),
            elevation: 6,
          ),
        );
      } catch (e) {
        debugPrint('Error showing toast: $e');
      }
    });
  }

  static _ToastConfig _getToastConfig(
    ToastType type, {
    Color? customBackground,
    Color? customTextColor,
    IconData? customIcon,
  }) {
    switch (type) {
      case ToastType.error:
        return _ToastConfig(
          backgroundColor: customBackground ?? const Color(0xFFDC2626),
          textColor: customTextColor ?? Colors.white,
          icon: customIcon ?? Icons.error_outline_rounded,
          iconColor: Colors.white,
        );
      case ToastType.success:
        return _ToastConfig(
          backgroundColor: customBackground ?? const Color(0xFF059669),
          textColor: customTextColor ?? Colors.white,
          icon: customIcon ?? Icons.check_circle_outline_rounded,
          iconColor: Colors.white,
        );
      case ToastType.warning:
        return _ToastConfig(
          backgroundColor: customBackground ?? const Color(0xFFEA580C),
          textColor: customTextColor ?? Colors.white,
          icon: customIcon ?? Icons.warning_amber_rounded,
          iconColor: Colors.white,
        );
      case ToastType.info:
        return _ToastConfig(
          backgroundColor: customBackground ?? const Color(0xFF0284C7),
          textColor: customTextColor ?? Colors.white,
          icon: customIcon ?? Icons.info_outline_rounded,
          iconColor: Colors.white,
        );
    }
  }
}

class _ToastConfig {
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final Color iconColor;

  _ToastConfig({
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    required this.iconColor,
  });
}
