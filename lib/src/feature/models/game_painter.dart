import 'package:flutter/material.dart';

class GamePainter extends CustomPainter {
  final double ballSize;
  final double ballX;
  final double ballY;
  final double racketBottomOffset;
  final double rackedX;
  final double rackedHeight;
  final double rackedWidth;

  GamePainter({
    required this.ballY,
    required this.rackedHeight,
    required this.rackedWidth,
    required this.rackedX,
    required this.ballSize,
    required this.ballX,
    required this.racketBottomOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rackedPaint = Paint()..color = Colors.blue;
    final ballPaint = Paint()..color = Colors.red.shade500;


    canvas.drawOval(
      Rect.fromLTWH(
        ballX,
        ballY,
        ballSize,
        ballSize,
      ),
      ballPaint,
    );

    Rect rect = Rect.fromLTWH(
      rackedX,
      size.height - rackedHeight - racketBottomOffset,
      rackedWidth,
      rackedHeight,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect,
        const Radius.circular(50),
      ),
      rackedPaint,
    );
  }

  @override
  bool shouldRepaint(covariant GamePainter oldDelegate) {
    return ballY != oldDelegate.ballX ||
        ballY != oldDelegate.ballY ||
        rackedX != oldDelegate.rackedX;
  }
}
