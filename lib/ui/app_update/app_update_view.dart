import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:padelgo/constants/colors.dart';

class AppUpdateView extends StatelessWidget {
  final VoidCallback? onSkip;
  final VoidCallback onUpdate;
  final Upgrader upgrader;
  final bool isForceUpdate;

  const AppUpdateView({
    super.key,
    this.onSkip,
    required this.onUpdate,
    required this.upgrader,
    this.isForceUpdate = false,
  });

  /// - Major version change (x.0.0) → Force update
  /// - Minor version change (8.x.1) → Force update
  /// - Patch version change (8.1.x) → Optional update
  static bool shouldForceUpdate(String? currentVersion, String? storeVersion) {
    if (currentVersion == null || storeVersion == null) return false;

    try {
      final current = _parseVersion(currentVersion);
      final store = _parseVersion(storeVersion);

      if (store.major > current.major) {
        return true;
      }

      if (store.major == current.major && store.minor > current.minor) {
        return true;
      }

      return false;
    } catch (e) {
      return true;
    }
  }

  static _Version _parseVersion(String version) {
    final cleanVersion = version.split('+').first;
    final parts = cleanVersion.split('.');

    return _Version(
      major: int.tryParse(parts[0]) ?? 0,
      minor: parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0,
      patch: parts.length > 2 ? (int.tryParse(parts[2]) ?? 0) : 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !isForceUpdate,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F8FF),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.white,
                        Color(0xFFF5F8FF),
                      ],
                      stops: [0.0, 0.7, 1.0],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    'assets/images/update-background.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Content overlay
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(flex: 5),

                    // Title
                    const Text(
                      'Update Tersedia',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 20),

                    Text(
                      'Versi Terbaru ${upgrader.currentAppStoreVersion ?? ""}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: BaseColors.primaryColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const Text(
                      'telah tersedia',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 32),

                    if (upgrader.releaseNotes != null &&
                        upgrader.releaseNotes!.isNotEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDEEDFF),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          upgrader.releaseNotes!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),

                    const SizedBox(height: 52),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: onUpdate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BaseColors.primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27),
                          ),
                        ),
                        child: const Text(
                          'Update Sekarang',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    if (!isForceUpdate && onSkip != null) ...[
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: onSkip,
                        child: const Text(
                          'Lewati saja',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],

                    const Spacer(flex: 2),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Version {
  final int major;
  final int minor;
  final int patch;

  _Version({required this.major, required this.minor, required this.patch});
}
