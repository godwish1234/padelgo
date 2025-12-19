import 'package:easy_localization/easy_localization.dart';
import 'package:padelgo/generated/locale_keys.g.dart';

enum Due {
  first(1),
  second(2),
  third(3),
  fourth(4),
  fifth(5),
  sixth(6),
  seventh(7),
  eighth(8),
  ninth(9),
  tenth(10),
  eleventh(11),
  twelfth(12);

  final int id;

  const Due(this.id);

  static String? getNameDate(int? id) {
    if (id == null) return null;

    final json = {
      first.id: LocaleKeys.first_due,
      second.id: LocaleKeys.second_due,
      third.id: LocaleKeys.third_due,
      fourth.id: LocaleKeys.fourth_due,
      fifth.id: LocaleKeys.fifth_due,
      sixth.id: LocaleKeys.sixth_due,
      seventh.id: LocaleKeys.seventh_due,
      eighth.id: LocaleKeys.eighth_due,
      ninth.id: LocaleKeys.ninth_due,
      tenth.id: LocaleKeys.tenth_due,
      eleventh.id: LocaleKeys.eleventh_due,
      twelfth.id: LocaleKeys.twelfth_due
    };

    return json[id]?.tr();
  }

  static String? getNameAmount(int? id) {
    if (id == null) return null;

    final json = {
      first.id: LocaleKeys.first_due_amount,
      second.id: LocaleKeys.second_due_amount,
      third.id: LocaleKeys.third_due_amount,
      fourth.id: LocaleKeys.fourth_due_amount,
      fifth.id: LocaleKeys.fifth_due_amount,
      sixth.id: LocaleKeys.sixth_due_amount,
      seventh.id: LocaleKeys.seventh_due_amount,
      eighth.id: LocaleKeys.eighth_due_amount,
      ninth.id: LocaleKeys.ninth_due_amount,
      tenth.id: LocaleKeys.tenth_due_amount,
      eleventh.id: LocaleKeys.eleventh_due_amount,
      twelfth.id: LocaleKeys.twelfth_due_amount
    };

    return json[id]?.tr();
  }
}
