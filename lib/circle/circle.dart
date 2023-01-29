import 'package:flutter/material.dart';

class Circle extends CustomPainter {
  final Color color;
  final double pointSize;
  final double xCoordination;
  final double yCoordination;
  final double blinkRadius;

  Circle({
    required this.color,
    required this.pointSize,
    required this.xCoordination,
    required this.yCoordination,
    required this.blinkRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the mid point
    Paint line = Paint();
    line.strokeCap = StrokeCap.round;
    line.color = color;
    line.strokeWidth = pointSize / 2;
    Offset center = Offset(
      xCoordination,
      yCoordination / 2,
    );
    double pointRadius = pointSize / 2;

    line.style = PaintingStyle.fill;
    canvas.drawCircle(center, pointRadius, line);

    line.style = PaintingStyle.stroke;
    canvas.drawCircle(
      center,
      blinkRadius,
      line,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
