import 'package:flutter/material.dart';

class AdSettings extends ChangeNotifier {
  String _adPath = 'assets/images/3x3v.png';
  String get adPath => _adPath;

  String getImagePath(String gridSize) {
    switch (gridSize) {
      case '3x3':
        return 'assets/images/3x3v.png';
      case '6x6':
        return 'assets/images/6x6_9x9v.png';
      case '9x9':
        return 'assets/images/6x6_9x9v.png';
      case '11x11':
        return 'assets/images/6x6_9x9v.png';
      case '15x15':
        return 'assets/images/15x15_21x21v.png';
      case '18x18':
        return 'assets/images/15x15_21x21v.png';
      case '21x21':
        return 'assets/images/15x15_21x21v.png';
      default:
        return 'assets/images/3x3v.png';
    }
  }

  void setImagePath(String gridSize) {
    _adPath = getImagePath(gridSize);
    notifyListeners();
  }
}
