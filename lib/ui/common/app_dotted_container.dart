import 'dart:ui';

import 'package:flutter/material.dart';

class DottedBorderContainer extends StatelessWidget {
  final Widget? child;
  final double width;
  final double height;
  final Color borderColor;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final BorderRadius? borderRadius;

  const DottedBorderContainer({
    Key? key,
    this.child,
    this.width = 200,
    this.height = 150,
    this.borderColor = Colors.grey,
    this.strokeWidth = 2.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedBorderPainter(
        borderColor: borderColor,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      child: Container(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final Color borderColor;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final BorderRadius borderRadius;

  DottedBorderPainter({
    required this.borderColor,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = borderColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    final RRect rrect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, size.width, size.height),
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );
    path.addRRect(rrect);

    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final double nextDistance = distance + dashWidth;
        final Path extractPath = pathMetric.extractPath(
          distance,
          nextDistance > pathMetric.length ? pathMetric.length : nextDistance,
        );
        canvas.drawPath(extractPath, paint);
        distance = nextDistance + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
