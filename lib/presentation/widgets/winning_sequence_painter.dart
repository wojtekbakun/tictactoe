import 'package:flutter/material.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/presentation/widgets/sound_manager.dart';

class WinningLinePainter extends CustomPainter {
  final List<List<int>> winningSequence;
  final double cellSize;
  final double screenWidth;
  final AnimationController animationController;
  final SoundManager soundManager;
  final TicTacToeGameModel gameModel;

  WinningLinePainter({
    required this.winningSequence,
    required this.cellSize,
    required this.screenWidth,
    required this.animationController,
    required this.soundManager,
    required this.gameModel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (winningSequence.isEmpty) return;

    final paint = Paint()
      ..color = const Color.fromARGB(255, 173, 216, 230) //173, 216, 230
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
    final animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));

    if (gameModel.isGameFinished) {
      soundManager.stopBackgroundMusic();
      if (gameModel.winner != 'DRAW') {
        canvas.drawLine(
          start,
          Offset.lerp(start, end, animation.value)!,
          paint,
        );
        animationController.forward();
      } else {}
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
