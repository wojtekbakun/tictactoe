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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          soundManager.playClickSound('sounds/click_sound_effect.mp3');
          onPressed();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromARGB(255, 173, 230, 176),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
