import 'package:flutter/material.dart';

class AppSliderThumb extends RangeSliderThumbShape {
  final double thumbRadius;

  AppSliderThumb({required this.thumbRadius});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    TextDirection? textDirection,
    required SliderThemeData sliderTheme,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final canvas = context.canvas;
    final double outerRadius = thumbRadius / 2;
    final double innerRadius = thumbRadius / 4;

    final Paint outerPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final Paint innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      center,
      outerRadius,
      outerPaint,
    );

    canvas.drawCircle(
      center,
      innerRadius,
      innerPaint,
    );
  }
}
