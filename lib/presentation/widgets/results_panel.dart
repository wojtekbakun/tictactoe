import 'package:flutter/material.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';

class ResultsPanel extends StatelessWidget {
  final double screenWidth;
  final TicTacToeGameModel gameModel;
  const ResultsPanel(
      {super.key, required this.screenWidth, required this.gameModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenWidth / 2,
      width: screenWidth,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            gameModel.winner != 'DRAW'
                ? '${gameModel.winner} wins!'
                : '${gameModel.winner}!',
          ),
          const Text('Click "yes" to play again or "no" to quit'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  gameModel.resetGame();
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/mode'),
                child: const Text('No'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
