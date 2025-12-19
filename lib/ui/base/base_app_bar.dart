import 'package:flutter/material.dart';
import 'package:padelgo/constants/colors.dart';
import 'package:padelgo/ui/base/base_icon_button.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Color? backgroundColor;
  final Color? color;

  const BaseAppBar(this.text, {super.key, this.backgroundColor, this.color});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => PreferredSize(
        preferredSize: preferredSize,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: backgroundColor ?? Colors.transparent,
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            titleSpacing: 0,
            centerTitle: false,
            leading: BaseIconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 24,
                color: color ?? BaseColors.black100,
              ),
            ),
            title: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: color ?? BaseColors.black100,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
}
