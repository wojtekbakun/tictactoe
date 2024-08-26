import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/data/providers/ad_settings.dart';
import 'package:tictactoe/domain/config/game_repo.dart';
import 'package:tictactoe/presentation/widgets/game.dart';
import 'package:tictactoe/presentation/widgets/points_to_win.dart';
import 'package:tictactoe/presentation/widgets/results_panel.dart';
import 'package:tictactoe/presentation/widgets/score.dart';
import 'package:tictactoe/presentation/widgets/sound_manager.dart';
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
    final adModel = context.watch<AdSettings>();
    final screenWidth = MediaQuery.of(context).size.width;
    final gridSize = gameModel.gridSizeInt;
    int winLength =
        GameRepo().gameConfigurations[gameModel.gridSize]?['win_length'] ?? 3;

    final soundManager = SoundManager();

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/sky.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Score(
                            xScore: gameModel.scoreX,
                            oScore: gameModel.scoreO,
                          ),
                          PointsToWin(pointsToWin: winLength.toString()),
                          ElevatedButton(
                            onPressed: () {
                              soundManager.playEffectSound(
                                  'sounds/click_sound_effect.mp3');
                              Navigator.pop(context);
                              gameModel.resetGame();
                            },
                            child: const Text('BACK'),
                          ),
                        ],
                      ),
                      gameModel.isGameFinished
                          ? ResultsPanel(
                              screenWidth: screenWidth,
                              gameModel: gameModel,
                            )
                          : const SizedBox(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
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
                                        cellSize: (screenWidth - 48) / gridSize,
                                        screenWidth: screenWidth,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          adModel.adPath,
                          height: gridSize == 3 ? 20 : 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
