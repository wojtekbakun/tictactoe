import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/data/providers/ad_settings.dart';
import 'package:tictactoe/data/providers/gameplay.dart';
import 'package:tictactoe/presentation/widgets/sound_manager.dart';

class ProvidersInit extends StatelessWidget {
  final Widget child;
  const ProvidersInit({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AdSettings()),
        ChangeNotifierProvider(create: (context) => Gameplay()),
        ChangeNotifierProvider(create: (context) => SoundManager()),
        ChangeNotifierProxyProvider<SoundManager, TicTacToeGameModel>(
          create: (_) => TicTacToeGameModel(
            Provider.of<SoundManager>(_, listen: false),
          ),
          update: (_, soundManagerProvider, gameModel) =>
              TicTacToeGameModel(soundManagerProvider),
        )
      ],
      child: child,
    );
  }
}
