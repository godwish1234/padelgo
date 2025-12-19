import 'dart:ui';

import 'package:padelgo/constants/constant.dart';

enum Alert {
  error(1),
  warning(2);

  final int id;

  const Alert(this.id);

  static Color? getBackgroundColor(int? id) {
    if (id == null) return null;

    final json = {
      error.id: BaseColors.red200,
      warning.id: BaseColors.yellow200
    };

    return json[id];
  }

  static Color? getColor(int? id) {
    if (id == null) return null;

    final json = {
      error.id: BaseColors.red100,
      warning.id: BaseColors.yellow100
    };

    return json[id];
  }
}
