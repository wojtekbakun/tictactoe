import 'package:flutter/material.dart';

class WinningLinePainter extends CustomPainter {
  final List<List<int>> winningSequence;
  final double cellSize;

  WinningLinePainter({required this.winningSequence, required this.cellSize});

  @override
  void paint(Canvas canvas, Size size) {
    if (winningSequence.isEmpty) return;

    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    // Pobierz współrzędne pierwszego i ostatniego punktu zwycięskiej sekwencji
    final start = Offset(
      winningSequence.first[1] * cellSize + cellSize / 2,
      winningSequence.first[0] * cellSize + cellSize / 2,
    );
    final end = Offset(
      winningSequence.last[1] * cellSize + cellSize / 2,
      winningSequence.last[0] * cellSize + cellSize / 2,
    );

    // Narysuj linię
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
