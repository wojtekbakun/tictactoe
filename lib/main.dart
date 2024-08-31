import 'package:flutter/material.dart';
import 'package:tictactoe/core/providers/providers_init.dart';
import 'package:tictactoe/presentation/screens/bubble_screen.dart';
import 'package:tictactoe/presentation/screens/game_screen.dart';
import 'package:tictactoe/presentation/screens/grid_screen.dart';
import 'package:tictactoe/presentation/screens/level_screen.dart';
import 'package:tictactoe/presentation/screens/loading_screen.dart';
import 'package:tictactoe/presentation/screens/mode_screen.dart';
import 'package:desktop_window/desktop_window.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setWindowSize(const Size(400, 800));
  await DesktopWindow.setMinWindowSize(const Size(400, 800));
  await DesktopWindow.setMaxWindowSize(const Size(400, 800));
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
        // '/splash': (context) => const SplashScreen(),
        '/bubbles': (context) => const BubbleScreen(),
        '/loading': (context) => const LoadingScreen(),
      },
      initialRoute: '/loading',
    );
  }
}
