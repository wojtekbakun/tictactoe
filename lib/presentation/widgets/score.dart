import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  int xScore = 0;
  int oScore = 0;
  Score({super.key, required this.xScore, required this.oScore});

  @override
  Widget build(BuildContext context) {
    return Text(
      'X: $xScore, O: $oScore',
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }
}
