import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:padelgo/generated/locale_keys.g.dart';

class PermissionHelper {
  static Future<Map<Permission, PermissionStatus>>
      requestPermissionsSequentially({
    required BuildContext context,
    List<Permission> permissions = const [
      Permission.camera,
      Permission.location,
    ],
    VoidCallback? onAllGranted,
    VoidCallback? onSomeGranted,
    VoidCallback? onAllDenied,
  }) async {
    final Map<Permission, PermissionStatus> results = {};

    for (final permission in permissions) {
      try {
        if (kDebugMode) {
          print('Checking permission: $permission');
        }

        final currentStatus = await permission.status;
        if (kDebugMode) {
          print('Current status for $permission: $currentStatus');
        }

        if (currentStatus == PermissionStatus.granted) {
          results[permission] = currentStatus;
          continue;
        }

        if (Theme.of(context).platform == TargetPlatform.iOS) {
          await Future.delayed(const Duration(milliseconds: 500));
        }

        if (kDebugMode) {
          print('Requesting permission: $permission');
        }

        final status = await permission.request();
        if (kDebugMode) {
          print('Permission result for $permission: $status');
        }

        results[permission] = status;

        if (status == PermissionStatus.permanentlyDenied) {
          await _showPermissionDeniedDialog(context, permission);
        }

        await Future.delayed(const Duration(milliseconds: 300));
      } catch (e) {
        if (kDebugMode) {
          print('Error requesting permission $permission: $e');
        }
        results[permission] = PermissionStatus.denied;
      }
    }

    // Handle completion callbacks
    final grantedCount = results.values
        .where((status) => status == PermissionStatus.granted)
        .length;

    if (grantedCount == permissions.length) {
      onAllGranted?.call();
    } else if (grantedCount > 0) {
      onSomeGranted?.call();
    } else {
      onAllDenied?.call();
    }

    return results;
  }

  static Future<PermissionStatus> requestSinglePermission({
    required BuildContext context,
    required Permission permission,
    bool showExplanation = false,
  }) async {
    try {
      // Add debug logging for iOS
      if (kDebugMode) {
        print('Requesting permission: $permission');
        print('Platform: ${Theme.of(context).platform}');
      }

      final currentStatus = await permission.status;
      if (kDebugMode) {
        print('Current permission status: $currentStatus');
      }

      if (currentStatus == PermissionStatus.granted) {
        return currentStatus;
      }

      // Add a small delay on iOS to ensure UI is ready
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        await Future.delayed(const Duration(milliseconds: 500));
      }

      final status = await permission.request();
      if (kDebugMode) {
        print('Permission request result: $status');
      }

      if (status == PermissionStatus.permanentlyDenied) {
        await _showPermissionDeniedDialog(context, permission);
      }

      return status;
    } catch (e) {
      if (kDebugMode) {
        print('Error requesting permission $permission: $e');
      }
      return PermissionStatus.denied;
    }
  }

  static Future<bool> areAllPermissionsGranted(
      List<Permission> permissions) async {
    for (final permission in permissions) {
      final status = await permission.status;
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  static Future<Map<Permission, PermissionStatus>> getPermissionStatuses(
    List<Permission> permissions,
  ) async {
    final Map<Permission, PermissionStatus> statuses = {};
    for (final permission in permissions) {
      statuses[permission] = await permission.status;
    }
    return statuses;
  }

  static Future<void> debugPermissionStatus() async {
    if (kDebugMode) {
      print('=== Permission Debug Info ===');
      final permissions = [Permission.camera, Permission.location];
      for (final permission in permissions) {
        try {
          final status = await permission.status;
          print('$permission: $status');
        } catch (e) {
          print('Error checking $permission: $e');
        }
      }
      print('=============================');
    }
  }

  static Future<void> _showPermissionDeniedDialog(
    BuildContext context,
    Permission permission,
  ) async {
    final permissionInfo = _getPermissionInfo(permission);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange[600],
                size: 24,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Permission Denied',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            'You have permanently denied ${permissionInfo.title.toLowerCase()}. '
            'To enable this feature, please go to Settings > Apps > ${LocaleKeys.app_name.tr()} > Permissions and enable ${permissionInfo.title.toLowerCase()}.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                LocaleKeys.cancel.tr(),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[600],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(LocaleKeys.open_settings.tr()),
            ),
          ],
        );
      },
    );
  }

  static _PermissionInfo _getPermissionInfo(Permission permission) {
    switch (permission) {
      case Permission.camera:
        return const _PermissionInfo(
          title: 'Camera Access',
          description:
              'We need camera access to help you take photos of your ID documents for verification.',
          benefits:
              'This allows you to easily verify your identity and complete loan applications.',
          icon: Icons.camera_alt,
        );
      case Permission.location:
      case Permission.locationWhenInUse:
      case Permission.locationAlways:
        return const _PermissionInfo(
          title: 'Location Access',
          description:
              'We need location access to provide location-based services and verify your address.',
          benefits:
              'This helps us provide better loan recommendations and ensure security.',
          icon: Icons.location_on,
        );
      default:
        return const _PermissionInfo(
          title: 'Permission Required',
          description:
              'This permission is needed for the app to function properly.',
          benefits:
              'Granting this permission will improve your app experience.',
          icon: Icons.security,
        );
    }
  }
}

/// Data class for permission information
class _PermissionInfo {
  final String title;
  final String description;
  final String benefits;
  final IconData icon;

  const _PermissionInfo({
    required this.title,
    required this.description,
    required this.benefits,
    required this.icon,
  });
}
