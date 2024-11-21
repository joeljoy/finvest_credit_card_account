import 'package:finvest_credit_card_account/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChartPainter extends CustomPainter {
  final List<double> dataPoints;

  ChartPainter(this.dataPoints);

  @override
  void paint(Canvas canvas, Size size) {
    const Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFB1BFFF),
        Color(0xB3B3C1FF),
      ],
      stops: [0.0958, 1.0],
    );

    // Create a shader for the gradient
    final Rect gradientRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint linePaint = Paint()
      ..shader =
          gradient.createShader(gradientRect) // Apply the gradient shader
      ..strokeWidth = 1.0;

    final Paint splinePaint = Paint()
      ..color = AppColors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // Determine the min and max values for scaling
    final double maxY = dataPoints.reduce((a, b) => a > b ? a : b);
    final double minY = dataPoints.reduce((a, b) => a < b ? a : b);

    // Scaling data points to fit within the canvas
    double xStep = size.width / (dataPoints.length - 1);
    Path splinePath = Path();

    // Create a path for vertical lines to fill between them
    for (int i = 0; i < dataPoints.length - 1; i++) {
      // Current point
      double x1 = i * xStep;
      double y1 =
          size.height - ((dataPoints[i] - minY) / (maxY - minY)) * size.height;

      // Next point
      double x2 = (i + 1) * xStep;
      double y2 = size.height -
          ((dataPoints[i + 1] - minY) / (maxY - minY)) * size.height;

      // Fill with additional vertical lines between x1 and x2
      for (double x = x1 + 1; x < x2; x += 3) {
        // Interpolate y between y1 and y2 for smoothness
        double t = (x - x1) / (x2 - x1); // Linear interpolation factor
        double y = y1 + t * (y2 - y1);

        // Draw the interpolated vertical line
        canvas.drawLine(
          Offset(x, size.height),
          Offset(x, y),
          linePaint,
        );
      }

      // Draw the spline curve
      if (i == 0) {
        splinePath.moveTo(x1, y1);
      }
      double controlX1 = x1 + (x2 - x1) / 2;
      splinePath.cubicTo(controlX1, y1, controlX1, y2, x2, y2);
    }

    canvas.drawPath(splinePath, splinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
