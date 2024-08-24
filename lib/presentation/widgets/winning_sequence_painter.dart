import 'package:flutter/material.dart';

class WinningLinePainter extends CustomPainter {
  final List<List<int>> winningSequence;
  final double cellSize;
  final double screenWidth;

  WinningLinePainter(
      {required this.winningSequence,
      required this.cellSize,
      required this.screenWidth});

  @override
  void paint(Canvas canvas, Size size) {
    if (winningSequence.isEmpty) return;

    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = cellSize / 10
      ..strokeCap = StrokeCap.round;

    double centerAdjust() => screenWidth / 2 - 24; // center + padding

    // Pobierz współrzędne pierwszego i ostatniego punktu zwycięskiej sekwencji
    final start = Offset(
      winningSequence.first[1] * cellSize + cellSize / 2 - centerAdjust(),
      winningSequence.first[0] * cellSize + cellSize / 2 - centerAdjust(),
    );
    final end = Offset(
      winningSequence.last[1] * cellSize + cellSize / 2 - centerAdjust(),
      winningSequence.last[0] * cellSize + cellSize / 2 - centerAdjust(),
    );

    // Narysuj linię
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
