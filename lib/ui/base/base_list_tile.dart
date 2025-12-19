import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:padelgo/constants/colors.dart';
import 'package:padelgo/constants/icon.dart';
import 'package:padelgo/generated/locale_keys.g.dart';

class BaseListTile extends StatelessWidget {
  final Function(String)? onPressed;
  final Function(String)? onSuffix;
  final String text;
  final String suffixText;
  final String? icon;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final TextStyle? suffixTextStyle;
  final Widget? suffixIcon;
  final double? suffixIconGap;
  final Decoration? decoration;

  const BaseListTile(this.text,
      {super.key,
      this.onPressed,
      this.suffixText = '',
      this.icon,
      this.padding,
      this.textStyle,
      this.suffixTextStyle,
      this.suffixIcon,
      this.onSuffix,
      this.suffixIconGap,
      this.decoration});

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => onPressed?.call(suffixText),
      behavior: HitTestBehavior.opaque,
      child: Container(
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: decoration,
          child: Row(children: <Widget>[
            if (icon != null)
              Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: Image.asset(icon!, width: 30, height: 30)),
            Expanded(
                child: Text(text,
                    style: textStyle ??
                        const TextStyle(
                            color: BaseColors.grey100, fontSize: 14))),
            const SizedBox(width: 8),
            GestureDetector(
                onTap: () {
                  onPressed?.call(suffixText);
                  onSuffix?.call(suffixText);
                },
                behavior: HitTestBehavior.opaque,
                child: Row(children: [
                  if (suffixText.isNotEmpty)
                    Text(suffixText,
                        style: suffixTextStyle ??
                            const TextStyle(
                                color: BaseColors.grey200, fontSize: 11)),
                  if (onPressed != null || onSuffix != null)
                    Container(
                        padding: EdgeInsets.only(left: suffixIconGap ?? 2),
                        child: suffixIcon ??
                            Image.asset(IconConstants.arrowNext,
                                width: 20, height: 20))
                ]))
          ])));
}

class InformationListTile extends StatelessWidget {
  final String text;
  final String suffixText;
  final Color? color;
  final Color? suffixColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  final Widget? suffixIcon;
  final Function(String)? onSuffix;

  const InformationListTile(this.text,
      {super.key,
      required this.suffixText,
      this.color,
      this.suffixColor,
      this.fontSize,
      this.fontWeight,
      this.padding,
      this.decoration,
      this.suffixIcon,
      this.onSuffix});

  @override
  Widget build(BuildContext context) => BaseListTile(
        text,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 0),
        decoration: decoration,
        onSuffix: onSuffix,
        textStyle: TextStyle(
            color: color ?? const Color(0xFF7B7B7B),
            fontSize: fontSize ?? 12,
            fontWeight: fontWeight),
        suffixText: suffixText,
        suffixIcon: suffixIcon,
        suffixTextStyle: TextStyle(
            color: suffixColor ?? BaseColors.black100,
            fontSize: fontSize ?? 12,
            fontWeight: FontWeight.bold),
      );
}

class DetailsListTile extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;

  const DetailsListTile(this.text,
      {super.key, this.onPressed, this.padding, this.decoration});

  @override
  Widget build(BuildContext context) => BaseListTile(
        text,
        onSuffix: (_) => onPressed?.call(),
        padding: padding ?? const EdgeInsets.symmetric(vertical: 6),
        decoration: decoration,
        textStyle: const TextStyle(color: BaseColors.grey100, fontSize: 12),
        suffixText: LocaleKeys.check.tr(),
        suffixTextStyle: const TextStyle(
          color: BaseColors.primaryColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          decorationColor: BaseColors.primaryColor,
          decorationThickness: 1,
          decorationStyle: TextDecorationStyle.solid,
        ),
        suffixIconGap: 11,
        suffixIcon: SvgPicture.asset(IconConstants.arrowDetails),
      );
}
