import 'package:flutter/material.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/presentation/widgets/sound_manager.dart';

class ResultsPanel extends StatelessWidget {
  final double screenWidth;
  final TicTacToeGameModel gameModel;
  final SoundManager soundManager;
  const ResultsPanel(
      {super.key,
      required this.screenWidth,
      required this.gameModel,
      required this.soundManager});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenWidth / 2,
      width: screenWidth,
      color: const Color.fromARGB(255, 173, 216, 230), //173, 216, 230
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            gameModel.winner != 'DRAW'
                ? '${gameModel.winner == 'Super X' ? 'X' : gameModel.winner == 'Super O' ? 'O' : gameModel.winner} wins!'
                : '${gameModel.winner}!',
          ),
          const Text('Click "yes" to play again or "no" to quit'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  soundManager
                      .playBackgroundMusic('sounds/background_music.wav');
                  gameModel.resetGame();
                  gameModel.isPlayerVsAI
                      ? {
                          gameModel.aiFirstMove(),
                          gameModel.initSuperGame(),
                        }
                      : null;
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  gameModel.resetGame();
                  gameModel.resetScore();
                  Navigator.pushReplacementNamed(context, '/mode');
                },
                child: const Text('No'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
