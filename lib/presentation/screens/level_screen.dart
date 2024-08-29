import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/presentation/widgets/button.dart';
import 'package:tictactoe/presentation/widgets/sound_manager.dart';

List<String> levels = [
  'easy',
  'medium',
  'hard',
];

class LevelScreen extends StatefulWidget {
  const LevelScreen({super.key});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  late final SoundManager soundManager;

  @override
  void initState() {
    super.initState();
    soundManager = context.read<SoundManager>();
  }

  @override
  Widget build(BuildContext context) {
    final gameModel = context.watch<TicTacToeGameModel>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Button(
                    text: 'BACK',
                    onPressed: () {
                      soundManager
                          .playEffectSound('sounds/click_sound_effect.mp3');
                      Navigator.pushNamed(context, '/grid');
                    },
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (var level in levels)
                      Button(
                        text: level,
                        onPressed: () {
                          soundManager
                              .playEffectSound('sounds/click_sound_effect.mp3');
                          Navigator.pushNamed(context, '/game');
                          gameModel.setLevelDifficulty(level);
                        },
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
