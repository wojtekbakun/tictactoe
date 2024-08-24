import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/data/providers/gameplay.dart';
import 'package:tictactoe/presentation/widgets/get_symbol_image.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    Provider.of<Gameplay>(context, listen: false).initializeFloatSettings();
    Provider.of<Gameplay>(context, listen: false).initializeFloatStates();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(
        Provider.of<Gameplay>(context, listen: false).updateBubblePositions);

    _animationController
        .repeat(); // Powoduje powtarzanie animacji w nieskończoność
  }

  @override
  void dispose() {
    _animationController.dispose();
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
          color: Colors.black,
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
          color: Colors.black,
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

  BoxDecoration rightNoneBorder(double width) {
    return BoxDecoration(
      border: Border(
        right: BorderSide(
          color: Colors.transparent,
          width: width,
        ),
        left: BorderSide(
          color: Colors.black,
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
    final gameplay = context.watch<Gameplay>();
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
                  for (var cols = 0; cols < gridSize; cols++)
                    // place X or O in the cell
                    GestureDetector(
                      onTap: () {
                        gameModel.isGameFinished
                            ? null
                            : {
                                setState(() {
                                  gameModel.makeMove(rows, cols);
                                  gameModel.setPlayerTurn(false);
                                }),
                                gameModel.isPlayerVsAI
                                    ? gameModel.clickedInNewCell
                                        ? gameModel.aiMove()
                                        : null
                                    : null
                              };
                        // ai moves only when button is clicked
                        // ai moves on every click even if player clicked on the same cell
                      },
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
                        child: Transform.translate(
                          // floating animation when the cell is empty
                          offset: Offset(
                            0,
                            gameModel.board[rows][cols] == ''
                                ? gameplay.floatStates[rows][cols]['offset']
                                : 0,
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(48 / gridSize),
                              child: SymbolImage(
                                currentPlayer: gameModel.board[rows][cols],
                              ),
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
