import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/presentation/widgets/game.dart';
import 'package:tictactoe/presentation/widgets/score.dart';
import 'package:tictactoe/presentation/widgets/winning_sequence_painter.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final gameModel = context.watch<TicTacToeGameModel>();
    final screenWidth = MediaQuery.of(context).size.width - 48; // 48 is padding
    final gridSize = gameModel.gridSizeInt;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Score(
                    xScore: 0,
                    yScore: 0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('BACK'),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        const Game(),
                        gameModel.isGameFinished
                            ? CustomPaint(
                                size: const Size(
                                  1,
                                  1,
                                ),
                                painter: WinningLinePainter(
                                  winningSequence: gameModel.winSequence,
                                  cellSize: screenWidth / gridSize,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'assets/images/3x3v.png',
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
