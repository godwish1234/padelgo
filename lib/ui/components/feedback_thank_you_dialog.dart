import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:padelgo/generated/locale_keys.g.dart';

class FeedbackThankYouDialog extends StatefulWidget {
  final int rating;
  final VoidCallback? onClose;

  const FeedbackThankYouDialog({
    super.key,
    required this.rating,
    this.onClose,
  });

  @override
  State<FeedbackThankYouDialog> createState() => _FeedbackThankYouDialogState();
}

class _FeedbackThankYouDialogState extends State<FeedbackThankYouDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated Star Icon
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFFFBBC04),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.star,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              LocaleKeys.thank_you.tr(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color(0xFF202124),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Message
            Text(
              widget.rating >= 4
                  ? LocaleKeys.thank_you_high_rating.tr()
                  : LocaleKeys.thank_you_feedback.tr(),
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF5F6368),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Close/Undo Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onClose?.call();
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: Text(
                widget.rating >= 4 ? LocaleKeys.close.tr() : 'OK',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A73E8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
