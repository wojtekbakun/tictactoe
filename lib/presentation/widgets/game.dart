import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/presentation/widgets/get_symbol_image.dart';
import 'package:tictactoe/presentation/widgets/sound_manager.dart';

class Game extends StatefulWidget {
  final SoundManager soundManager;
  const Game({super.key, required this.soundManager});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  @override
  void initState() {
    super.initState();

    // Tworzymy AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Tworzymy animację offsetu przy użyciu Tween i CurvedAnimation
    _animation = Tween<Offset>(
      begin: const Offset(0, -0.05), // Początkowa pozycja
      end: const Offset(0, 0.05), // Końcowa pozycja
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Krzywa animacji
    ));

    _controller.repeat(reverse: true); // Uruchamiamy animację

    // Uruchamiamy animację
    //_controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TicTacToeGameModel>().initSuperGame();
      context.read<TicTacToeGameModel>().aiFirstMove();
    });
  }

  @override
  void dispose() {
    // soundManager.stopBackgroundMusic();
    // soundManager.stopEffectSound();
    //soundManager.disposePlayers();
    _controller.dispose();
    debugPrint('Game disposed');
    super.dispose();
  }

  BoxDecoration topNoneBorder(double width) {
    return BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Colors.transparent,
          width: width,
        ),
        left: BorderSide(
          color: Colors.black,
          width: width,
        ),
        right: BorderSide(
          color: Colors.black,
          width: width,
        ),
        bottom: BorderSide(
          color: Colors.transparent,
          width: width,
        ),
      ),
    );
  }

  BoxDecoration bottomNoneBorder(double width) {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.transparent,
          width: width,
        ),
        left: BorderSide(
          color: Colors.black,
          width: width,
        ),
        right: BorderSide(
          color: Colors.black,
          width: width,
        ),
        top: BorderSide(
          color: Colors.transparent,
          width: width,
        ),
      ),
    );
  }

  BoxDecoration leftNoneBorder(double width) {
    return BoxDecoration(
      border: Border(
        left: BorderSide(
          color: Colors.transparent,
          width: width,
        ),
        top: BorderSide(
          color: Colors.black,
          width: width,
        ),
        right: BorderSide(
          color: Colors.transparent,
          width: width,
        ),
        bottom: BorderSide(
          color: Colors.black,
          width: width,
        ),
      ),
    );
  }

  BoxDecoration rightNoneBorder(double width) {
    return BoxDecoration(
      border: Border(
        right: BorderSide(
          color: Colors.transparent,
          width: width,
        ),
        left: BorderSide(
          color: Colors.transparent,
          width: width,
        ),
        top: BorderSide(
          color: Colors.black,
          width: width,
        ),
        bottom: BorderSide(
          color: Colors.black,
          width: width,
        ),
      ),
    );
  }

  BoxDecoration fullBorder(double width) {
    return BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Colors.black,
          width: width,
        ),
        left: BorderSide(
          color: Colors.black,
          width: width,
        ),
        right: BorderSide(
          color: Colors.black,
          width: width,
        ),
        bottom: BorderSide(
          color: Colors.black,
          width: width,
        ),
      ),
    );
  }

  BoxDecoration noneBorder(double width) {
    return BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Colors.transparent,
          width: width,
        ),
        left: BorderSide(
          color: Colors.transparent,
          width: width,
        ),
        right: BorderSide(
          color: Colors.transparent,
          width: width,
        ),
        bottom: BorderSide(
          color: Colors.transparent,
          width: width,
        ),
      ),
    );
  }

  BoxDecoration getBorder(String whereEmpty) {
    double width = 0;
    switch (whereEmpty) {
      case 'top':
        return topNoneBorder(width);
      case 'bottom':
        return bottomNoneBorder(width);
      case 'left':
        return leftNoneBorder(width);
      case 'right':
        return rightNoneBorder(width);
      case 'full':
        return fullBorder(width);
      default:
        return noneBorder(width);
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameModel = context.watch<TicTacToeGameModel>();
    final gridSize = gameModel.gridSizeInt;
    final screenWidth = MediaQuery.of(context).size.width - 48; // 48 is padding
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // create 3 rows
            for (var rows = 0; rows < gridSize; rows++)
              Row(
                children: [
                  // create 3 columns for each row
                  // create 3 columns for each row
                  for (var cols = 0; cols < gridSize; cols++)
                    // place X or O in the cell
                    GestureDetector(
                      onTap: () async {
                        if (!gameModel.isGameFinished) {
                          if (gameModel.canClick) {
                            await gameModel.makeMove(rows, cols);
                            if (gameModel.isGameFinished) {
                              debugPrint('Stopped background music');
                            }
                            if (gameModel.isPlayerVsAI &&
                                gameModel.clickedInNewCell) {
                              if (!gameModel.isGameFinished) {
                                await gameModel.aiMove();
                              }
                            }
                            if (gameModel.isGameFinished) {
                              debugPrint('Stopped background music');
                            }
                          }
                        }
                      },

                      // ai moves only when button is clicked
                      // ai moves on every click even if player clicked on the same cell

                      child: Container(
                        width: screenWidth / gridSize,
                        height: screenWidth / gridSize,
                        decoration: rows == 0 && cols > 0 && cols < gridSize - 1
                            ? getBorder('top')
                            : rows > 0 && rows < gridSize - 1 && cols == 0
                                ? getBorder('left')
                                : rows > 0 &&
                                        rows < gridSize - 1 &&
                                        cols == gridSize - 1
                                    ? getBorder('right')
                                    : rows == gridSize - 1 &&
                                            cols > 0 &&
                                            cols < gridSize - 1
                                        ? getBorder('bottom')
                                        : cols > 0 &&
                                                cols < gridSize - 1 &&
                                                rows > 0 &&
                                                rows < gridSize - 1
                                            ? getBorder('full')
                                            : getBorder('none'),
                        child: gameModel.board[rows][cols] == ''
                            ? AnimatedBuilder(
                                // floating animation when the cell is empty
                                animation: _animation,
                                builder: (context, child) {
                                  return FractionalTranslation(
                                    translation: _animation
                                        .value, // Zastosowanie animowanego offsetu
                                    child: child,
                                  );
                                },
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(48 / gridSize),
                                    child: SymbolImage(
                                      currentPlayer: gameModel.board[rows]
                                          [cols],
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: Padding(
                                  padding: EdgeInsets.all(48 / gridSize),
                                  child: SymbolImage(
                                    currentPlayer: gameModel.board[rows][cols],
                                  ),
                                ),
                              ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
