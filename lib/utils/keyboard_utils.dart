import 'package:flutter/material.dart';

class KeyboardUtils {
  KeyboardUtils._();

  static void dismiss(BuildContext context) {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild!.unfocus();
    }

    if (FocusManager.instance.primaryFocus?.hasFocus == true) {
      FocusManager.instance.primaryFocus!.unfocus();
    }

    FocusScope.of(context).requestFocus(FocusNode());
  }

  static bool dismissAndCheck(BuildContext context) {
    final wasKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    dismiss(context);
    return wasKeyboardVisible;
  }

  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  static void dismissThen(BuildContext context, VoidCallback callback) {
    dismiss(context);
    Future.delayed(const Duration(milliseconds: 100), callback);
  }

  static void dismissAndNavigate(BuildContext context, VoidCallback navigate) {
    if (isKeyboardVisible(context)) {
      dismissThen(context, navigate);
    } else {
      navigate();
    }
  }
}
