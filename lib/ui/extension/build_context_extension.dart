import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:padelgo/ui/helpers/loading_overlay.dart';

extension BuildContextExtensions on BuildContext {
  void showLoading() {
    if (kDebugMode) {
      print("loading+++++");
    }
    LoadingOverlay.instance.show(this);
  }

  void hideLoading() {
    if (kDebugMode) {
      print("hideLoading+++++");
    }
    LoadingOverlay.instance.hide();
  }

  bool get isLoading => LoadingOverlay.instance.isVisible;
}
