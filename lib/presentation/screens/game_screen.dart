import 'package:flutter/material.dart';
import 'package:tictactoe/presentation/widgets/game.dart';
import 'package:tictactoe/presentation/widgets/score.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Score(
                    xScore: 0,
                    yScore: 0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('BACK'),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Game(),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'assets/images/3x3v.png',
                        height: 20,
                      ),
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
