import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChartPainter extends CustomPainter {
  final List<double> dataPoints;
  final double bottomMargin;

  ChartPainter(this.dataPoints, {this.bottomMargin = 68});

  @override
  void paint(Canvas canvas, Size size) {
    const Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFB1BFFF),
        Color(0x00B3C1FF),
      ],
      stops: [0.0958, 1.0],
    );

    // Create a shader for the gradient
    final Rect gradientRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint gradientPaint = Paint()
      ..shader = gradient.createShader(gradientRect);

    final Paint splinePaint = Paint()
      ..color = AppColors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // Determine the min and max values for scaling
    final double maxY = dataPoints.reduce((a, b) => a > b ? a : b);
    final double minY = dataPoints.reduce((a, b) => a < b ? a : b);

    // Adjust scaling to leave space at the bottom
    final double availableHeight = size.height - bottomMargin;

    // Scaling data points to fit within the adjusted height
    double xStep = size.width / (dataPoints.length - 1);
    Path splinePath = Path();
    Path areaPath = Path();

    for (int i = 0; i < dataPoints.length; i++) {
      // Calculate x and y for the current data point
      double x = i * xStep;
      double y = availableHeight -
          ((dataPoints[i] - minY) / (maxY - minY)) * availableHeight;

      // Create the spline path
      if (i == 0) {
        splinePath.moveTo(x, y);
        areaPath.moveTo(x, size.height);
        areaPath.lineTo(x, y);
      } else {
        double prevX = (i - 1) * xStep;
        double prevY = availableHeight -
            ((dataPoints[i - 1] - minY) / (maxY - minY)) * availableHeight;

        double controlX1 = prevX + (x - prevX) / 2;
        double controlY1 = prevY;
        double controlX2 = prevX + (x - prevX) / 2;
        double controlY2 = y;

        splinePath.cubicTo(controlX1, controlY1, controlX2, controlY2, x, y);
        areaPath.cubicTo(controlX1, controlY1, controlX2, controlY2, x, y);
      }
    }
    areaPath.lineTo(size.width, size.height);
    areaPath.close();

    // Draw the gradient-filled area
    canvas.drawPath(areaPath, gradientPaint);

    // Draw the spline curve
    canvas.drawPath(splinePath, splinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
