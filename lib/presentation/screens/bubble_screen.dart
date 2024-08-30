import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/presentation/widgets/button.dart';
import 'package:tictactoe/presentation/widgets/sound_manager.dart';

class BubbleScreen extends StatefulWidget {
  const BubbleScreen({super.key});

  @override
  State<BubbleScreen> createState() => _BubbleScreenState();
}

class _BubbleScreenState extends State<BubbleScreen> {
  late final SoundManager soundManager;

  @override
  void initState() {
    soundManager = SoundManager();
    super.initState();
  }

  @override
  void dispose() {
    soundManager.disposeBackgroundSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameModel = context.watch<TicTacToeGameModel>();
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('WHICH GAME WOULD YOU LIKE TO PLAY?'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Button(
                text: 'Tic Tac Toe\nWith Super Bubbles',
                onPressed: () {
                  gameModel.setSuperBubblesMode(true);
                  Navigator.pushNamed(context, '/mode');
                },
              ),
            ),
            Button(
              text: 'Tic Tac Toe\nWithout Super Bubbles',
              onPressed: () {
                gameModel.setSuperBubblesMode(false);
                Navigator.pushNamed(context, '/mode');
              },
            ),
          ],
        ),
      ),
    ));
  }
}
