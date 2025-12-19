import 'package:flutter/material.dart';
import 'package:padelgo/constants/colors.dart';

class BaseSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final Function(double)? onChanged;
  final double? interval;

  const BaseSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1000000.0,
    this.interval,
  });

  @override
  State<BaseSlider> createState() => _BaseSliderState();
}

class _BaseSliderState extends State<BaseSlider> {
  double get _normalizedValue {
    if (widget.max <= widget.min) return 0.0;
    return ((widget.value - widget.min) / (widget.max - widget.min))
        .clamp(0.0, 1.0);
  }

  double _denormalizeValue(double normalizedValue) {
    final rawValue = widget.min + (normalizedValue * (widget.max - widget.min));

    if (normalizedValue <= 0.0) {
      return widget.min;
    }

    if (normalizedValue >= 1.0) {
      return widget.max;
    }

    if (widget.interval != null && widget.interval! > 0) {
      final roundedValue =
          (rawValue / widget.interval!).round() * widget.interval!;

      if (roundedValue > widget.max) {
        return widget.max;
      }

      if (roundedValue < widget.min) {
        return widget.min;
      }

      return roundedValue;
    }

    return rawValue;
  }

  int? get _divisions {
    if (widget.interval != null && widget.interval! > 0) {
      return ((widget.max - widget.min) / widget.interval!).round();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) => SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackShape: _GradientSliderTrackShape(),
        thumbShape: _SliderThumb(),
        overlayColor: BaseColors.blue220,
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
        trackHeight: 6,
      ),
      child: Slider(
          onChanged: widget.onChanged != null
              ? (normalizedValue) {
                  final actualValue = _denormalizeValue(normalizedValue);
                  widget.onChanged!(actualValue);
                }
              : null,
          divisions: _divisions,
          padding: const EdgeInsets.all(0),
          value: _normalizedValue));
}

class _GradientSliderTrackShape extends SliderTrackShape {
  @override
  Rect getPreferredRect(
      {required RenderBox parentBox,
      Offset offset = Offset.zero,
      required SliderThemeData sliderTheme,
      bool isEnabled = false,
      bool isDiscrete = false}) {
    final double trackHeight = sliderTheme.trackHeight ?? 4;
    final double trackLeft = offset.dx + 8;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 16;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(PaintingContext context, Offset offset,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required Offset thumbCenter,
      Offset? secondaryOffset,
      bool isEnabled = false,
      bool isDiscrete = false,
      required TextDirection textDirection}) {
    final Rect trackRect = getPreferredRect(
        parentBox: parentBox, offset: offset, sliderTheme: sliderTheme);

    final Paint inactivePaint = Paint()..color = BaseColors.grey1500;

    final Paint activePaint = Paint()
      ..shader = const LinearGradient(
              colors: [BaseColors.blue300, BaseColors.blue200])
          .createShader(Rect.fromLTRB(
              trackRect.left, trackRect.top, thumbCenter.dx, trackRect.bottom));

    final Rect leftTrack = Rect.fromLTRB(
        trackRect.left, trackRect.top, thumbCenter.dx, trackRect.bottom);

    final Rect rightTrack = Rect.fromLTRB(
        thumbCenter.dx, trackRect.top, trackRect.right, trackRect.bottom);

    context.canvas.drawRRect(
        RRect.fromRectAndRadius(leftTrack, const Radius.circular(16)),
        activePaint);

    context.canvas.drawRRect(
        RRect.fromRectAndRadius(rightTrack, const Radius.circular(16)),
        inactivePaint);
  }
}

class _SliderThumb extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      const Size.fromRadius(10);

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final canvas = context.canvas;

    final shadowPaint = Paint()
      ..color = BaseColors.grey1651
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    canvas.drawCircle(center, 10, shadowPaint);

    final fillPaint = Paint()..color = BaseColors.blue200;

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(center, 10, fillPaint);
    canvas.drawCircle(center, 10, borderPaint);
  }
}
