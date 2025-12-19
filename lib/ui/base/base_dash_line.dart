import 'package:flutter/material.dart';

class HorizontalDashedLine extends StatelessWidget {
  final double height;
  final Color color;

  const HorizontalDashedLine({
    this.height = 1,
    this.color = Colors.grey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HorizontalDashedPainter(color, height),
      size: Size(double.infinity, height),
    );
  }
}

class _HorizontalDashedPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _HorizontalDashedPainter(this.color, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 6.0;
    const dashSpace = 4.0;
    double startX = 0;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
