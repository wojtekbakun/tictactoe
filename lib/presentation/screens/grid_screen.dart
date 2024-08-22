import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/providers/game_settiings.dart';
import 'package:tictactoe/presentation/widgets/button.dart';

List<String> gridSizes = [
  '3x3 Grid',
  '6x6 Grid',
  '9x9 Grid',
  '11x11 Grid',
  '15x15 Grid',
  '18x18 Grid',
];

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final game = context.watch<Game>();
    final settings = context.watch<GameSettiings>();
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
                          settings.isPlayerVsAI
                              ? Navigator.pushNamed(context, '/level')
                              : Navigator.pushNamed(context, '/game');
                          // set the grid size to the selected grid size
                          settings.setGridSize(
                              gridSizes[gridSizes.indexOf(gridSize)]);
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
