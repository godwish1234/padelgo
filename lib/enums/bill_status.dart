import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:padelgo/constants/colors.dart';
import 'package:padelgo/generated/locale_keys.g.dart';

enum BillStatus {
  pending(1),
  fail(5),
  successful(2),
  overdue(4),
  comingDue(6),
  paid(3);

  final int id;

  const BillStatus(this.id);

  static String? getName(int? id) {
    if (id == null) return null;

    final json = {
      pending.id: LocaleKeys.bill_status_pending,
      fail.id: LocaleKeys.bill_status_fail,
      successful.id: LocaleKeys.bill_status_successful,
      overdue.id: LocaleKeys.bill_status_overdue,
      comingDue.id: LocaleKeys.bill_status_coming_due,
      paid.id: LocaleKeys.bill_status_paid
    };

    return json[id]?.tr();
  }

  static Color? getColor(int? id) {
    if (id == null) return null;

    final json = {
      pending.id: BaseColors.green100,
      fail.id: BaseColors.orange100,
      successful.id: BaseColors.primaryColor,
      overdue.id: BaseColors.red100,
      comingDue.id: BaseColors.blue100,
      paid.id: BaseColors.black100
    };

    return json[id];
  }
}
