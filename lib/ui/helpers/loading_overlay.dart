import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:padelgo/constants/colors.dart';

enum LoadingAnimationType {
  threeArchedCircle,
  waveDots,
  inkDrop,
  threeRotatingDots,
  bouncingBall,
}

class LoadingOverlay {
  LoadingOverlay._();
  static final LoadingOverlay instance = LoadingOverlay._();

  OverlayEntry? _overlayEntry;
  bool _isVisible = false;

  bool get isVisible => _isVisible;

  Widget _getLoadingAnimation(
      LoadingAnimationType type, Color color, double size) {
    switch (type) {
      case LoadingAnimationType.threeArchedCircle:
        return LoadingAnimationWidget.threeArchedCircle(
            color: color, size: size);
      case LoadingAnimationType.waveDots:
        return LoadingAnimationWidget.waveDots(color: color, size: size);
      case LoadingAnimationType.inkDrop:
        return LoadingAnimationWidget.inkDrop(color: color, size: size);
      case LoadingAnimationType.threeRotatingDots:
        return LoadingAnimationWidget.threeRotatingDots(
            color: color, size: size);
      case LoadingAnimationType.bouncingBall:
        return LoadingAnimationWidget.bouncingBall(color: color, size: size);
    }
  }

  void show(
    BuildContext context, {
    LoadingAnimationType animationType = LoadingAnimationType.threeArchedCircle,
  }) {
    if (_isVisible) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              // Blur effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutBack,
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(24.0),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 40,
                        spreadRadius: 0,
                        offset: const Offset(0, 10),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: _getLoadingAnimation(
                      animationType,
                      BaseColors.primaryColor,
                      48,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    try {
      HapticFeedback.mediumImpact();
      final overlay = Overlay.of(context);
      if (overlay.mounted) {
        overlay.insert(_overlayEntry!);
        _isVisible = true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error showing loading overlay: $e');
      }
    }
  }

  void hide() {
    if (!_isVisible) return;
    try {
      _actualHide();
    } catch (e) {
      if (kDebugMode) {
        print('Error hiding loading overlay: $e');
      }
      _actualHide();
    }
  }

  void _actualHide() {
    try {
      _overlayEntry?.remove();
    } catch (e) {
      if (kDebugMode) {
        print('Error removing overlay entry: $e');
      }
    } finally {
      _overlayEntry = null;
      _isVisible = false;
    }
  }

  // Convenience methods for different animation types
  void showWaveDots(BuildContext context) {
    show(context, animationType: LoadingAnimationType.waveDots);
  }

  void showInkDrop(BuildContext context) {
    show(context, animationType: LoadingAnimationType.inkDrop);
  }

  void showThreeRotatingDots(BuildContext context) {
    show(context, animationType: LoadingAnimationType.threeRotatingDots);
  }

  void showBouncingBall(BuildContext context) {
    show(context, animationType: LoadingAnimationType.bouncingBall);
  }
}
