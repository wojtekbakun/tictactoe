import 'package:flutter/material.dart';
import 'package:tictactoe/core/providers/providers_init.dart';
import 'package:tictactoe/presentation/screens/bubble_screen.dart';
import 'package:tictactoe/presentation/screens/game_screen.dart';
import 'package:tictactoe/presentation/screens/grid_screen.dart';
import 'package:tictactoe/presentation/screens/level_screen.dart';
import 'package:tictactoe/presentation/screens/loading_screen.dart';
import 'package:tictactoe/presentation/screens/mode_screen.dart';
//import 'package:desktop_window/desktop_window.dart';
//import 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
  //   await DesktopWindow.setWindowSize(const Size(400, 800));
  //   await DesktopWindow.setMinWindowSize(const Size(400, 800));
  //   await DesktopWindow.setMaxWindowSize(const Size(400, 800));
  // }

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
      title: 'Bubble Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      routes: {
        '/mode': (context) => const ModeScreen(),
        '/grid': (context) => const GridScreen(),
        '/level': (context) => const LevelScreen(),
        '/game': (context) => const GameScreen(),
        '/bubbles': (context) => const BubbleScreen(),
        '/loading': (context) => const LoadingScreen(),
      },
      initialRoute: '/loading',
    );
  }
}
