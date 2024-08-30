import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/presentation/widgets/sound_manager.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const Button({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final SoundManager soundManager = context.watch<SoundManager>();
    return ElevatedButton(
      onPressed: () {
        soundManager.playClickSound('sounds/click_sound_effect.mp3');
        onPressed();
      },
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
