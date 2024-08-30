import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/data/providers/ad_settings.dart';
import 'package:tictactoe/domain/config/game_repo.dart';
import 'package:tictactoe/presentation/widgets/button.dart';
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

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late final SoundManager soundManager;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    soundManager = context.read<SoundManager>();
    // Sprawdzenie stanu odtwarzacza i odpowiednia reakcja
    if (soundManager.getBackgroundPlayerState() != PlayerState.playing) {
      soundManager.playBackgroundMusic('sounds/background_music.wav');
    }
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    //soundManager.disposeEffectPlayers();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameModel = context.watch<TicTacToeGameModel>();
    final adModel = context.watch<AdSettings>();
    final screenWidth = MediaQuery.of(context).size.width;
    final gridSize = gameModel.gridSizeInt;
    int winLength =
        GameRepo().gameConfigurations[gameModel.gridSize]?['win_length'] ?? 3;

    gameModel.isGameFinished ? _controller.reset() : null;
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
                          SizedBox(
                            height: screenWidth / 12,
                            width: screenWidth / 12,
                            child: Image.asset(
                              gameModel.isGameFinished
                                  ? gameModel.winner == 'X'
                                      ? 'assets/images/bubble_x.jpeg'
                                      : 'assets/images/bubble_o.jpg'
                                  : gameModel.currentPlayer == 'X'
                                      ? 'assets/images/bubble_x.jpeg'
                                      : 'assets/images/bubble_o.jpg',
                            ),
                          ),
                          Button(
                            onPressed: () {
                              soundManager.stopBackgroundMusic();
                              gameModel.resetScore();
                              Navigator.pushReplacementNamed(context, '/mode');
                              gameModel.resetGame();
                              _controller.reset();
                            },
                            text: 'BACK',
                          ),
                        ],
                      ),
                      gameModel.isGameFinished
                          ? ResultsPanel(
                              screenWidth: screenWidth,
                              gameModel: gameModel,
                              soundManager: soundManager,
                            )
                          : const SizedBox(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Game(soundManager: soundManager),
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
                                        animationController: _controller,
                                        soundManager: soundManager,
                                        gameModel: gameModel,
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
