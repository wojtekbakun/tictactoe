import 'package:flutter/material.dart';

class Gameplay extends ChangeNotifier {
  List<List<Map<String, dynamic>>> _floatStates = [];
  double _floatRange = 0;
  double _floatSpeed = 0;
  int _gridSize = 3;

  int get gridSize => _gridSize;
  double get floatRange => _floatRange;
  double get floatSpeed => _floatSpeed;
  List<List<Map<String, dynamic>>> get floatStates => _floatStates;

  void setGridSize(int size) {
    _gridSize = size;
    initializeFloatStates();
    notifyListeners();
  }

  double getGridWidth() {
    double width;
    switch (_gridSize) {
      case 15:
        width = .3;
        break;
      case 18:
        width = .2;
        break;
      case 21:
        width = .1;
        break;
      default:
        width = 1;
    }
    return width;
  }

  void initializeFloatStates() {
    // generate a list of lists of maps, each map representing a bubble
    _floatStates = List.generate(
      _gridSize,
      (_) => List.generate(
        _gridSize,
        (_) => {'floating': true, 'offset': 0.0, 'direction': 1},
      ),
    );
    notifyListeners();
  }

  void initializeFloatSettings() {
    double baseFloatRange = 10;
    double baseFloatSpeed = 0.5;

    _floatRange = baseFloatRange * (3 / _gridSize);
    _floatSpeed = baseFloatSpeed * (3 / _gridSize);
  }

  void updateBubblePositions() {
    for (int row = 0; row < _gridSize; row++) {
      for (int col = 0; col < _gridSize; col++) {
        var cell = _floatStates[row][col];
        cell['offset'] += cell['direction'] * _floatSpeed;

        // Odwracanie kierunku, gdy bąbelek osiągnie maksymalny zakres
        if (cell['offset'].abs() >= _floatRange) {
          cell['direction'] *= -1;
        }
      }
    }
    notifyListeners();
  }
}
