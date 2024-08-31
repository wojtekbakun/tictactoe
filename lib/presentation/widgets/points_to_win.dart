import 'package:flutter/material.dart';

class PointsToWin extends StatelessWidget {
  final String pointsToWin;
  const PointsToWin({super.key, required this.pointsToWin});

  @override
  Widget build(BuildContext context) {
    int getPointsToWin(String pointsToWin) {
      //!TODO - refactor this
      switch (pointsToWin) {
        case '3':
          return 3;
        case '4':
          return 4;
        case '5':
          return 5;
        case '6':
          return 4;
        case '7':
          return 7;
        case '8':
          return 8;
        case '9':
          return 9;
        default:
          return 3;
      }
    }

    return Text('${getPointsToWin(pointsToWin).toString()}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ));
  }
}
