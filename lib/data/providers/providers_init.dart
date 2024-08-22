import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/data/providers/game_settiings.dart';

class ProvidersInit extends StatelessWidget {
  final Widget child;
  const ProvidersInit({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameSettiings()),
      ],
      child: child,
    );
  }
}
