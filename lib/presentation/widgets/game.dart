import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/core/consts/consts.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/data/providers/gameplay.dart';

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

  @override
  Widget build(BuildContext context) {
    final gameModel = context.watch<TicTacToeGameModel>();
    final gameplay = context.watch<Gameplay>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // create 3 rows
            for (var i = 0; i < MyConsts.gridSize; i++)
              Row(
                children: [
                  // create 3 columns for each row
                  for (var j = 0; j < MyConsts.gridSize; j++)
                    // place X or O in the cell
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          gameModel.makeMove(i, j);
                        });
                      },
                      child: Container(
                        width: MyConsts.cellSize.toDouble(),
                        height: MyConsts.cellSize.toDouble(),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: gameplay.getGridWidth(),
                          ),
                        ),
                        child: Transform.translate(
                          // floating animation when the cell is empty
                          offset: Offset(
                            0,
                            gameModel.board[i][j] == ''
                                ? gameplay.floatStates[i][j]['offset']
                                : 0,
                          ),
                          child: Center(
                            child: gameModel.board[i][j] == ''
                                ? Image.asset(MyConsts.bubblePath)
                                : gameModel.board[i][j] == 'X'
                                    ? Image.asset(MyConsts.xBubblePath)
                                    : Image.asset(MyConsts.oBubblePath),
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
