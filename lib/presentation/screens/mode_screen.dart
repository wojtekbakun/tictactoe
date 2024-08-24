import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/presentation/widgets/button.dart';

class ModeScreen extends StatelessWidget {
  const ModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameModel = context.watch<TicTacToeGameModel>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Button(
              text: 'Player vs AI',
              onPressed: () {
                Navigator.pushNamed(context, '/grid');
                gameModel.setPlayerVsAI(true);
                gameModel.resetScore();
                gameModel.resetGame();
              },
            ),
            Button(
              text: 'Player vs Player',
              onPressed: () {
                Navigator.pushNamed(context, '/grid');
                gameModel.setPlayerVsAI(false);
                gameModel.resetScore();
                gameModel.resetGame();
              },
            ),
          ],
        ),
      ),
    );
  }
}
