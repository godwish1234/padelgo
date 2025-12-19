import 'package:flutter/material.dart';
import 'package:padelgo/utils/keyboard_utils.dart';

class KeyboardDismissibleWrapper extends StatelessWidget {
  final Widget child;
  final bool dismissOnTap;

  const KeyboardDismissibleWrapper({
    super.key,
    required this.child,
    this.dismissOnTap = true,
  });

  static void dismissKeyboard(BuildContext context) {
    KeyboardUtils.dismiss(context);
  }

  @override
  Widget build(BuildContext context) {
    if (!dismissOnTap) {
      return child;
    }

    return GestureDetector(
      onTap: () {
        KeyboardUtils.dismiss(context);
      },
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}

extension KeyboardDismissal on BuildContext {
  void dismissKeyboard() {
    KeyboardUtils.dismiss(this);
  }

  bool dismissKeyboardAndCheck() {
    return KeyboardUtils.dismissAndCheck(this);
  }

  bool get isKeyboardVisible {
    return KeyboardUtils.isKeyboardVisible(this);
  }

  void dismissKeyboardThen(VoidCallback callback) {
    KeyboardUtils.dismissThen(this, callback);
  }

  void dismissKeyboardAndNavigate(VoidCallback navigate) {
    KeyboardUtils.dismissAndNavigate(this, navigate);
  }
}
