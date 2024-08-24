import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/data/providers/ad_settings.dart';
import 'package:tictactoe/data/providers/gameplay.dart';

class ProvidersInit extends StatelessWidget {
  final Widget child;
  const ProvidersInit({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AdSettings()),
        ChangeNotifierProvider(create: (context) => TicTacToeGameModel()),
        ChangeNotifierProvider(create: (context) => Gameplay()),
      ],
      child: child,
    );
  }
}
