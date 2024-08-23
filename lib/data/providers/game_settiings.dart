import 'package:flutter/material.dart';
import 'package:tictactoe/domain/config/game_repo.dart';

class GameSettiings extends ChangeNotifier {
  bool _isPlayerVsAI = false;
  bool get isPlayerVsAI => _isPlayerVsAI;

  String _gridSize = '3x3';
  String get gridSize => _gridSize;

  String _level = 'EASY';
  String get level => _level;

  final currentConfig = GameRepo().gameConfigurations['3x3'];

  void setLevel(String value) {
    _level = value;
    debugPrint('Changed level to $value');
    notifyListeners();
  }

  void setGridSize(String value) {
    _gridSize = value;
    debugPrint('Changed gridSize to $value');
    notifyListeners();
  }

  void setPlayerVsAI(bool value) {
    _isPlayerVsAI = value;
    debugPrint('Changed isPlayerVsAI to $value');
    notifyListeners();
  }
}
