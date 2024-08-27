import 'package:flutter/material.dart';
import 'package:tictactoe/presentation/widgets/button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'For hard mode there is only 1 super bubble by default!'
                        .toUpperCase(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Button(
                          text:
                              'Buy The Paid Vesion For Unlimited Super Bubbles!',
                          onPressed: () {
                            Navigator.pushNamed(context, '/game');
                          }),
                    ),
                    Button(
                        text:
                            'Do You Want To Watch An Ad For More Super Bubbles?',
                        onPressed: () {
                          Navigator.pushNamed(context, '/game');
                        }),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Button(
                          text: 'Continue With Just One Super Bubble?',
                          onPressed: () {
                            Navigator.pushNamed(context, '/game');
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
