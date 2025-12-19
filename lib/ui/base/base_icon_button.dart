import 'package:flutter/material.dart';

class BaseIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;

  const BaseIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) => IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          overlayColor: Colors.transparent,
          hoverColor: Colors.transparent),
      icon: icon);
}
