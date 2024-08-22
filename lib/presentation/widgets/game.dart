import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    final gameModel = context.watch<TicTacToeGameModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // create 3 rows
            for (var i = 0; i < 3; i++)
              Row(
                children: [
                  // create 3 columns for each row
                  for (var j = 0; j < 3; j++)
                    GestureDetector(
                      onTap: () {
                        debugPrint('Cell $i $j tapped');
                        setState(() {
                          gameModel.makeMove(i, j);
                        });
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            gameModel.board[i][j],
                            style: const TextStyle(
                              fontSize: 20,
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
