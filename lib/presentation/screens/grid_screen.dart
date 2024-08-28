import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/data/providers/ad_settings.dart';
import 'package:tictactoe/data/providers/gameplay.dart';
import 'package:tictactoe/domain/config/game_repo.dart';
import 'package:tictactoe/presentation/widgets/button.dart';
import 'package:tictactoe/presentation/widgets/sound_manager.dart';

List<String> gridSizes = [
  '3x3',
  '6x6',
  '9x9',
  '11x11',
  '15x15',
  '18x18',
  '21x21',
];

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final game = context.watch<Game>();
    final gameModel = context.watch<TicTacToeGameModel>();
    final gameplay = context.watch<Gameplay>();
    final adModel = context.watch<AdSettings>();
    final soundManager = SoundManager();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Button(
                    text: 'BACK',
                    onPressed: () {
                      soundManager
                          .playEffectSound('sounds/click_sound_effect.mp3');
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var gridSize in gridSizes)
                      Button(
                        text: gridSize,
                        onPressed: () {
                          soundManager
                              .playEffectSound('sounds/click_sound_effect.mp3');
                          gameModel.isPlayerVsAI
                              ? Navigator.pushNamed(context, '/level')
                              : Navigator.pushNamed(context, '/game');
                          // set the grid size to the selected grid size
                          gameModel.setBoardSize(
                            GameRepo().gameConfigurations[gridSize]
                                    ?['grid_size'] ??
                                3,
                            gridSize,
                          );
                          gameplay.setGridSize(
                            GameRepo().gameConfigurations[gridSize]
                                    ?['grid_size'] ??
                                3,
                          );

                          adModel.setImagePath(gridSize);
                          debugPrint('Grid size: $gridSize');
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
