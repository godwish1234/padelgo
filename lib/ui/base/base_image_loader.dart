import 'package:flutter/material.dart';
import 'package:padelgo/constants/colors.dart';

class BaseImageLoader extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double borderRadius;
  final double? strokeWidth;

  const BaseImageLoader(this.imageUrl,
      {super.key,
      this.width = 30,
      this.height = 30,
      this.borderRadius = 10,
      this.strokeWidth = 2});

  @override
  Widget build(BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(imageUrl,
          width: width,
          height: height,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Container(
              width: width,
              height: height,
              color: BaseColors.primaryColor,
              child: const Center(
                  child: Text('P',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)))),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
                child: SizedBox(
                    width: width,
                    height: height,
                    child: CircularProgressIndicator(
                        padding: const EdgeInsets.all(4),
                        color: BaseColors.primaryColor,
                        strokeWidth: strokeWidth,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null)));
          }));
}
