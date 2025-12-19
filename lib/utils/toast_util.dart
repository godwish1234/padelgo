import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFFE53E3E),
      textColor: const Color(0xFFFFFFFF),
      fontSize: 16.0,
    );
  }

  static void showSuccess(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFF38A169),
      textColor: const Color(0xFFFFFFFF),
      fontSize: 16.0,
    );
  }

  static void showInfo(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFF3182CE), 
      textColor: const Color(0xFFFFFFFF),
      fontSize: 16.0,
    );
  }

  static void showWarning(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFFD69E2E),
      textColor: const Color(0xFFFFFFFF),
      fontSize: 16.0,
    );
  }

  static void show(
    String message, {
    Color? backgroundColor,
    Color? textColor,
    Toast? toastLength,
    ToastGravity? gravity,
    double? fontSize,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength ?? Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: backgroundColor ?? const Color(0xFF323232),
      textColor: textColor ?? const Color(0xFFFFFFFF),
      fontSize: fontSize ?? 16.0,
    );
  }
}
