import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/presentation/widgets/button.dart';

class ModeScreen extends StatefulWidget {
  const ModeScreen({super.key});

  @override
  State<ModeScreen> createState() => _ModeScreenState();
}

class _ModeScreenState extends State<ModeScreen> {
  late final TicTacToeGameModel gameModel;

  @override
  void initState() {
    super.initState();
    gameModel = context.read<TicTacToeGameModel>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Button(
                      text: 'BACK',
                      onPressed: () {
                        Navigator.pushNamed(context, '/bubbles');
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button(
                          text: 'Player vs AI',
                          onPressed: () async {
                            gameModel.setPlayerVsAI(true);
                            if (!context.mounted) return;
                            Navigator.pushNamed(context, '/grid');
                          },
                        ),
                        Button(
                          text: 'Player vs Player',
                          onPressed: () async {
                            gameModel.setPlayerVsAI(false);
                            if (!context.mounted) return;
                            Navigator.pushNamed(context, '/grid');
                          },
                        ),
                      ]),
                ),
              ]),
        ),
      ),
    );
  }
}
