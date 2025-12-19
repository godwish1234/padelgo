import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:padelgo/helpers/preference_helper.dart';
import 'package:padelgo/ui/components/rating_dialog.dart';
import 'package:padelgo/ui/components/feedback_thank_you_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:padelgo/repository/interfaces/home_repository.dart';
import 'package:get_it/get_it.dart';

class RatingService {
  static const String _playStorePackageName = 'com.pilihid.kreditid.padelgo';

  static Future<bool> shouldShowRatingDialog() async {
    final hasShownRating = await PkPreferenceHelper.getHasShownRatingDialog();
    final hasCompletedUpload =
        await PkPreferenceHelper.getHasCompletedUploadInfo();

    return !hasShownRating && hasCompletedUpload;
  }

  /// Show rating dialog
  static Future<void> showRatingDialog(BuildContext context) async {
    if (!await shouldShowRatingDialog()) {
      if (kDebugMode) {
        print('Rating dialog already shown or upload not completed');
      }
      return;
    }

    if (!context.mounted) return;

    try {
      final homeRepository = GetIt.instance<HomeRepository>();
      await homeRepository.updateRating(0);
      if (kDebugMode) {
        print('Rating dialog shown - API called with ratingLevel=0');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error calling updateRating API on dialog show: $e');
      }
    }

    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RatingDialog(
        onRatingSubmitted: (rating) async {
          Navigator.of(context).pop();

          try {
            final homeRepository = GetIt.instance<HomeRepository>();
            await homeRepository.updateRating(rating);
            if (kDebugMode) {
              print('Rating submitted - API called with ratingLevel=$rating');
            }
          } catch (e) {
            if (kDebugMode) {
              print('Error calling updateRating API on submit: $e');
            }
          }

          // Mark as shown immediately
          await PkPreferenceHelper.setHasShownRatingDialog(true);
          await PkPreferenceHelper.setUserRating(rating);

          if (kDebugMode) {
            print('User rated: $rating stars');
          }

          if (rating >= 4) {
            await Future.delayed(const Duration(milliseconds: 300));
            await _openPlayStore();
          } else {
            if (context.mounted) {
              await Future.delayed(const Duration(milliseconds: 300));
              if (context.mounted) {
                await showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) => FeedbackThankYouDialog(
                    rating: rating,
                    onClose: null,
                  ),
                );
              }
            }
          }
        },
      ),
    );
  }

  static Future<void> _openPlayStore() async {
    try {
      final playStoreUri =
          Uri.parse('market://details?id=$_playStorePackageName');

      if (await canLaunchUrl(playStoreUri)) {
        await launchUrl(
          playStoreUri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        final webUri = Uri.parse(
          'https://play.google.com/store/apps/details?id=$_playStorePackageName',
        );
        await launchUrl(
          webUri,
          mode: LaunchMode.externalApplication,
        );
      }

      if (kDebugMode) {
        print('Opened Play Store for rating');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error opening Play Store: $e');
      }
    }
  }

  /// Mark that user has completed upload info
  static Future<void> markUploadInfoCompleted() async {
    await PkPreferenceHelper.setHasCompletedUploadInfo(true);
    if (kDebugMode) {
      print('Upload info marked as completed');
    }
  }

  /// Check if user has completed upload info
  static Future<bool> hasCompletedUploadInfo() async {
    return await PkPreferenceHelper.getHasCompletedUploadInfo();
  }

  /// Reset rating dialog (for testing/debugging)
  static Future<void> resetRatingDialog() async {
    await PkPreferenceHelper.clearRatingData();
    if (kDebugMode) {
      print('Rating dialog data cleared');
    }
  }
}
