import 'package:flutter/material.dart';
import 'package:padelgo/utils/toast_util.dart';

class ImageErrorHandler {
  /// Shows appropriate error message for image processing failures
  static void handleImageError(String error, {BuildContext? context}) {
    String userMessage;

    if (error.contains('Invalid image size') ||
        error.contains('max image size should be less than 2m')) {
      userMessage = 'Image is too large. Please try taking a clearer photo.';
    } else if (error.contains('image dimension should be between')) {
      userMessage =
          'Image quality is not suitable. Please try taking a clearer photo.';
    } else if (error.contains('Failed to compress image')) {
      userMessage = 'Unable to process image. Please try again.';
    } else if (error.contains('OCR requirements')) {
      userMessage =
          'Image quality needs improvement. Please ensure good lighting and clear focus.';
    } else {
      userMessage = 'Something went wrong. Please try again.';
    }

    ToastUtil.showError(userMessage);
  }

  /// Shows tips for better image capture
  static void showImageCaptureTips({BuildContext? context}) {
    const tips = 'Tips for better image capture:\n'
        '• Ensure good lighting\n'
        '• Keep the ID card flat and aligned\n'
        '• Avoid shadows and reflections\n'
        '• Make sure text is clearly readable';

    if (context != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Image Capture Tips'),
          content: const Text(tips),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Got it'),
            ),
          ],
        ),
      );
    } else {
      ToastUtil.showInfo(
          'Please ensure good lighting and clear focus for best results');
    }
  }
}
