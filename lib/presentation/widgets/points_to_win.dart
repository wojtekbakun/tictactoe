import 'package:flutter/material.dart';

class PointsToWin extends StatelessWidget {
  final String pointsToWin;
  const PointsToWin({super.key, required this.pointsToWin});

  @override
  Widget build(BuildContext context) {
    String getPointsToWinImageString(String pointsToWin) {
      switch (pointsToWin) {
        case '3':
          return '';
        case '4':
          return 'assets/images/number_4.png';
        case '5':
          return 'assets/images/number_5.png';
        case '6':
          return 'assets/images/number_6.jpg';
        case '7':
          return 'assets/images/number_7.png';
        case '8':
          return 'assets/images/number_7.jpg';
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
