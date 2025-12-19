import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:padelgo/generated/locale_keys.g.dart';
import 'package:package_info_plus/package_info_plus.dart';

class RatingDialog extends StatefulWidget {
  final Function(int rating) onRatingSubmitted;

  const RatingDialog({
    super.key,
    required this.onRatingSubmitted,
  });

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _selectedRating = 0;
  String _appName = 'padelgo';

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appName = packageInfo.appName;
    });
  }

  void _onStarTapped(int rating) {
    setState(() {
      _selectedRating = rating;
    });
  }

  void _onSubmit() {
    if (_selectedRating > 0) {
      widget.onRatingSubmitted(_selectedRating);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBottomSheet(context);
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              // Google Play icon
              Image.asset(
                'assets/icons/png/google_play.png',
                width: 24,
                height: 24,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.store,
                    color: Color(0xFF01875F),
                    size: 24,
                  );
                },
              ),
              const SizedBox(width: 8),
              const Text(
                'Google Play',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF202124),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // App icon and name
          Row(
            children: [
              // App Icon
              Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4285F4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset('assets/icons/png/logo.png')),
              const SizedBox(width: 12),
              // App Name
              Expanded(
                child: Text(
                  _appName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF202124),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Description text
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Your review is public and includes your Google profile name and photo',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF5F6368),
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Star Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (index) {
              final starNumber = index + 1;
              final isSelected = starNumber <= _selectedRating;

              return GestureDetector(
                onTap: () => _onStarTapped(starNumber),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    isSelected ? Icons.star : Icons.star_border,
                    size: 40,
                    color: isSelected
                        ? const Color(0xFFFBBC04)
                        : const Color(0xFFDADCE0),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Not now button
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
                child: Text(
                  LocaleKeys.maybe_later.tr(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A73E8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Submit button
              TextButton(
                onPressed: _selectedRating > 0 ? _onSubmit : null,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  backgroundColor: _selectedRating > 0
                      ? const Color(0xFF1A73E8)
                      : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  LocaleKeys.submit_rating.tr(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _selectedRating > 0
                        ? Colors.white
                        : const Color(0xFFDADCE0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
