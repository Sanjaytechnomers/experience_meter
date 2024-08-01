library experience_meter;

import 'dart:math';
import 'package:flutter/material.dart';

class ExperienceMeter extends CustomPainter {
  final segmentColors = <Color>[
    const Color(0xFFF87070),
    const Color(0xFFF2B7B7),
    const Color(0xFFF8DC1E),
    const Color(0xFFC2FC23),
    const Color(0xFF8AF229),
    const Color(0xFF1CED38),
  ];

  final double value;
  final String centerText;

  ExperienceMeter({
    required this.value,
    required this.centerText,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = -180;
    double sweepAngle = 180 / segmentColors.length;
    final double radius = size.height / 2.5;

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30; // Increased stroke width

    // Draw the segments with rounded ends
    for (Color color in segmentColors) {
      paint.color = color;
      paint.strokeCap = StrokeCap.butt;
      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height), radius: radius),
        radians(startAngle),
        radians(sweepAngle),
        false,
        paint,
      );
      startAngle += sweepAngle;
    }

    // Draw the inner half-circle with white fill and black border
    double innerCircleRadius = radius - paint.strokeWidth / 2;

    Paint innerCirclePaint = Paint()..color = Colors.transparent;
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height),
          radius: innerCircleRadius),
      radians(-180),
      radians(180),
      true,
      innerCirclePaint,
    );

    Paint borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height),
          radius: innerCircleRadius),
      radians(-180),
      radians(180),
      false,
      borderPaint,
    );

    // Draw the needle
    double needleAngle = radians(-180 + (value / 100) * 180);
    double needleLength = innerCircleRadius * 1.22;

    Paint needlePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    double needleInnerX = size.width / 2 + innerCircleRadius * cos(needleAngle);
    double needleInnerY = size.height + innerCircleRadius * sin(needleAngle);
    double needleOuterX = size.width / 2 + needleLength * cos(needleAngle);
    double needleOuterY = size.height + needleLength * sin(needleAngle);

    double needleWidth = 10;
    double needleBaseLeftX =
        needleInnerX - (needleWidth / 2) * sin(needleAngle);
    double needleBaseLeftY =
        needleInnerY + (needleWidth / 2) * cos(needleAngle);
    double needleBaseRightX =
        needleInnerX + (needleWidth / 2) * sin(needleAngle);
    double needleBaseRightY =
        needleInnerY - (needleWidth / 2) * cos(needleAngle);

    Path needlePath = Path()
      ..moveTo(needleBaseLeftX, needleBaseLeftY)
      ..lineTo(needleBaseRightX, needleBaseRightY)
      ..lineTo(needleOuterX, needleOuterY)
      ..close();

    canvas.drawPath(needlePath, needlePaint);

    // Draw the center text
    TextPainter centerTextPainter = TextPainter(
      text: TextSpan(
        text: centerText,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(
        maxWidth: innerCircleRadius * 2,
      );

    Offset centerTextOffset = Offset(
      size.width / 2 - centerTextPainter.width / 2,
      size.height - centerTextPainter.height / 2 - 40,
    );

    centerTextPainter.paint(canvas, centerTextOffset);

    // Draw the years text
    TextPainter yearsTextPainter = TextPainter(
      text: const TextSpan(
        text: "years",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(
        maxWidth: innerCircleRadius * 2,
      );

    Offset yearsTextOffset = Offset(
      size.width / 2 - yearsTextPainter.width / 2,
      size.height - yearsTextPainter.height / 2 - 15,
    );

    yearsTextPainter.paint(canvas, yearsTextOffset);
  }

  double radians(double degrees) => degrees * (pi / 180);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
