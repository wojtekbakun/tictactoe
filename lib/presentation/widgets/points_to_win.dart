import 'package:flutter/material.dart';
import 'package:tictactoe/core/consts/consts.dart';

class PointsToWin extends StatelessWidget {
  final String pointsToWin;
  const PointsToWin({super.key, required this.pointsToWin});

  @override
  Widget build(BuildContext context) {
    String getPointsToWinImageString(String pointsToWin) {
      //!TODO - refactor this
      switch (pointsToWin) {
        case '3':
          return '';
        case '4':
          return MyConsts.sixWinningPath;
        case '5':
          return 'assets/images/number_5.png';
        case '6':
          return 'assets/images/number_6.jpg';
        case '7':
          return 'assets/images/number_7.png';
        case '8':
          return 'assets/images/number_7.png';
        case '9':
          return 'assets/images/number_9.jpg';
        default:
          return '';
      }
    }

    return getPointsToWinImageString(pointsToWin) == ''
        ? const SizedBox()
        : Image.asset(
            getPointsToWinImageString(pointsToWin),
            width: 20,
            height: 20,
          );
  }
}
