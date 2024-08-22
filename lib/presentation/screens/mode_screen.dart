import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/providers/game_settiings.dart';
import 'package:tictactoe/presentation/widgets/button.dart';

class ModeScreen extends StatelessWidget {
  const ModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<GameSettiings>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Button(
              text: 'Player vs AI',
              onPressed: () {
                Navigator.pushNamed(context, '/grid');
                settings.setPlayerVsAI(true);
              },
            ),
            Button(
              text: 'Player vs Player',
              onPressed: () {
                Navigator.pushNamed(context, '/grid');
                settings.setPlayerVsAI(false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
