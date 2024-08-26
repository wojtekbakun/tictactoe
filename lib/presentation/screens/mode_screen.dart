import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/presentation/widgets/button.dart';
import 'package:tictactoe/presentation/widgets/sound_manager.dart';

class ModeScreen extends StatefulWidget {
  const ModeScreen({super.key});

  @override
  State<ModeScreen> createState() => _ModeScreenState();
}

class _ModeScreenState extends State<ModeScreen> {
  @override
  void initState() {
    SoundManager().playBackgroundMusic('sounds/background_music.wav');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gameModel = context.watch<TicTacToeGameModel>();
    final soundManager = SoundManager();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Button(
              text: 'Player vs AI',
              onPressed: () {
                soundManager.playEffectSound('sounds/click_sound_effect.mp3');
                Navigator.pushNamed(context, '/grid');
                gameModel.setPlayerVsAI(true);
                gameModel.resetScore();
                gameModel.resetGame();
              },
            ),
            Button(
              text: 'Player vs Player',
              onPressed: () {
                soundManager.playEffectSound('sounds/click_sound_effect.mp3');
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
