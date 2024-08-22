import 'package:flutter/material.dart';
import 'package:tictactoe/presentation/widgets/button.dart';

List<String> levels = [
  'EASY',
  'MEDIUM',
  'HARD',
];

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (var level in levels)
                      Button(
                        text: level,
                        onPressed: () {
                          Navigator.pushNamed(context, '/game');
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
