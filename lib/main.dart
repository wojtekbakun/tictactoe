import 'package:flutter/material.dart';
import 'package:tictactoe/data/providers/providers_init.dart';
import 'package:tictactoe/presentation/screens/game_screen.dart';
import 'package:tictactoe/presentation/screens/grid_screen.dart';
import 'package:tictactoe/presentation/screens/level_screen.dart';
import 'package:tictactoe/presentation/screens/mode_screen.dart';

void main() {
  runApp(
    const ProvidersInit(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/mode': (context) => const ModeScreen(),
        '/grid': (context) => const GridScreen(),
        '/level': (context) => const LevelScreen(),
        '/game': (context) => const GameScreen(),
      },
      initialRoute: '/mode',
      home: const Scaffold(
        body: ModeScreen(),
      ),
    );
  }
}
