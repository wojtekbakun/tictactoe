import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  int xScore = 0;
  int yScore = 0;
  Score({super.key, required this.xScore, required this.yScore});

  @override
  Widget build(BuildContext context) {
    return Text('X: $xScore, Y: $yScore');
  }
}
