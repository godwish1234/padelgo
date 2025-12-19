import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool enabled;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final double? fontSize;
  final Widget? icon;
  final double? gap;
  final double elevation;

  const BaseButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius = 30,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
    this.textStyle,
    this.fontSize,
    this.icon,
    this.gap = 8,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled = enabled && !isLoading && onPressed != null;

    return SizedBox(
      width: width,
      height: (height == -1) ? null : (height ?? 48),
      child: ElevatedButton(
        onPressed: isButtonEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isButtonEnabled
              ? (backgroundColor ?? Colors.blue[600])
              : Colors.grey[300],
          foregroundColor:
              isButtonEnabled ? (textColor ?? Colors.white) : Colors.grey[500],
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: elevation,
          disabledBackgroundColor: Colors.grey[300],
          disabledForegroundColor: Colors.grey[500],
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isButtonEnabled
                        ? (textColor ?? Colors.white)
                        : Colors.grey[500]!,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: textStyle ??
                        TextStyle(
                          fontSize: fontSize ?? 16,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (icon != null) ...[
                    SizedBox(width: gap),
                    icon!,
                  ],
                ],
              ),
      ),
    );
  }
}

// Specialized button variants
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool enabled;
  final double? width;
  final Widget? icon;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      enabled: enabled,
      width: width,
      backgroundColor: Colors.blue[600],
      textColor: Colors.white,
      icon: icon,
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool enabled;
  final double? width;
  final Widget? icon;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      enabled: enabled,
      width: width,
      backgroundColor: Colors.white,
      textColor: Colors.blue[600],
      borderRadius: 8,
      elevation: 1,
      icon: icon,
    );
  }
}

class OutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool enabled;
  final double? width;
  final double? height;
  final Widget? icon;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  const OutlineButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.isLoading = false,
      this.enabled = true,
      this.width,
      this.height,
      this.icon,
      this.borderColor,
      this.padding,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled = enabled && !isLoading && onPressed != null;

    return SizedBox(
      width: width,
      height: (height == -1) ? null : (height ?? 48),
      child: OutlinedButton(
        onPressed: isButtonEnabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          foregroundColor: isButtonEnabled
              ? (borderColor ?? Colors.blue[600])
              : Colors.grey[500],
          side: BorderSide(
            color: isButtonEnabled
                ? (borderColor ?? Colors.blue[600]!)
                : Colors.grey[300]!,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(99),
          ),
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isButtonEnabled
                        ? (borderColor ?? Colors.blue[600]!)
                        : Colors.grey[500]!,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: textStyle ??
                        const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
