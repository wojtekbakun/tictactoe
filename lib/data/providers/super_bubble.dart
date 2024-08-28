import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe/data/models/ttt_game_model.dart';
import 'package:tictactoe/domain/config/game_repo.dart';

class SuperBubble extends ChangeNotifier {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _levelDifficulty;
  late int _gridSizeInt;

  SuperBubble(TicTacToeGameModel gameModel) {
    _board = gameModel.board;
    _currentPlayer = gameModel.currentPlayer;
    _levelDifficulty = gameModel.levelDifficulty;
    _gridSizeInt = gameModel.gridSizeInt;
  }

  int _maxSuperSymbols = 0;
  int _superXCount = 0;
  int _superOCount = 0;
  bool _placedSuperSymbol = false;

  bool get placedSuperSymbol => _placedSuperSymbol;
  int get maxSuperSymbols => _maxSuperSymbols;
  int get superXCount => _superXCount;
  int get superOCount => _superOCount;

  void setSuperSymbolPlaced(bool isPlaced) {
    _placedSuperSymbol = isPlaced;
    notifyListeners();
  }

  void setSuperXCount(int count) {
    _superXCount = count;
    debugPrint('Super X count set to $count');
    notifyListeners();
  }

  void setSuperOCount(int count) {
    _superOCount = count;
    notifyListeners();
  }

  void setMaxSuperSymbols(int max) {
    _maxSuperSymbols = max;
    notifyListeners();
  }

  void initSuperGame() {
    _maxSuperSymbols =
        GameRepo().getSuperXBubbleMax(_levelDifficulty, _gridSizeInt);
    _superXCount = _maxSuperSymbols;
    _superOCount = _maxSuperSymbols;
    debugPrint(
        'Super game initialized, max super symbols: $_maxSuperSymbols, chance: ${getChance()}');
    notifyListeners();
  }

  int getChance() {
    return getEmptyCells().length;
  }

  List<int> getRandomEmptyCell() {
    List<List<int>> emptyCells = getEmptyCells();
    return emptyCells[Random().nextInt(emptyCells.length)];
  }

// get row and col of all empty cells
  List<List<int>> getEmptyCells() {
    List<List<int>> emptyCells = [];
    for (int row = 0; row < _gridSizeInt; row++) {
      for (int col = 0; col < _gridSizeInt; col++) {
        if (_board[row][col] == '') {
          emptyCells.add([row, col]);
        }
      }
    }
    return emptyCells;
  }

  bool shouldMakeSuperMove() {
    debugPrint(
        'Super symbol chance: ${getChance()}: ${(_superXCount < _maxSuperSymbols && _superXCount > 0 && Random().nextInt(getChance()) <= 5)}}');
    return _superXCount < _maxSuperSymbols &&
        _superXCount > 0 &&
        Random().nextInt(getChance()) <= 30;
  }

  void changeToSuperSymbol() {
    if (_currentPlayer == 'X') {
      _currentPlayer = 'Super X';
    } else {
      _currentPlayer = 'Super O';
    }
    _placedSuperSymbol = true;
    debugPrint('Super symbol placed: $_currentPlayer');
  }

  bool makeSuperMove(int i, int j) {
    List<List<int>> emptyCells = getEmptyCells();
    emptyCells.shuffle();
    //cells to pop should be a list 3 random cells from the empty cells
    List<List<int>> cellsToPop = emptyCells.take(1).toList();
    setSuperXCount(_superXCount - 1);
    if (_board[i][j] == '') {
      changeToSuperSymbol();
      applySuperXRandomEffect(i, j, cellsToPop, _levelDifficulty);
      return true;
    }
    return false;
  }

  void applySuperXRandomEffect(
      int i, int j, List<List<int>> cellsToPop, String difficulty) {
    for (var pos in cellsToPop) {
      Future.delayed(const Duration(milliseconds: 200), () {
        makeSuperMove(
          pos[0],
          pos[1],
        );
        // Update display and play sound (replace with actual implementation)
        // bubblePopSound.play();
      });
    }
  }

  void applySuperOEffect(int row, int col, int cellsToPop, String difficulty) {
    List<List<int>> chosenPositions;
    debugPrint('Applying super O effect');
    if (difficulty == "hard") {
      List<List<int>> strategicPositions = findStrategicOPositions();

      // Sort strategic positions by a scoring function (to be defined)
      strategicPositions.sort((a, b) =>
          scorePosition(_board, b).compareTo(scorePosition(_board, a)));

      // Select the top cellsToPop positions
      chosenPositions = strategicPositions.take(cellsToPop).toList();
    } else {
      // For easy and medium, use random valid positions
      List<List<int>> emptyPositions = [];
      for (int r = 0; r < _gridSizeInt; r++) {
        for (int c = 0; c < _gridSizeInt; c++) {
          if (_board[r][c] == '') {
            emptyPositions.add([r, c]);
          }
        }
      }
      chosenPositions = emptyPositions..shuffle();
      chosenPositions =
          chosenPositions.take(min(emptyPositions.length, cellsToPop)).toList();
      debugPrint('Chosen positions: $chosenPositions');
    }

    for (var pos in chosenPositions) {
      Future.delayed(const Duration(milliseconds: 200), () {
        // _board[pos[0]][pos[1]] = 'O';
        _currentPlayer = 'O';
        makeSuperMove(pos[0], pos[1]);
        // Update display and play sound (replace with actual implementation)
        // bubblePopSound.play();
      });
    }
  }

  int scorePosition(List<List<String?>> board, List<int> position) {
    int score = 0;
    // Example scoring logic, needs customization
    // Add your scoring logic here
    return score;
  }

  List<List<int>> findStrategicOPositions() {
    List<List<int>> strategicPositions = [];
    List<List<int>> directions = [
      [0, 1],
      [1, 0],
      [1, 1],
      [-1, 1],
      [0, -1],
      [-1, 0],
      [-1, -1],
      [1, -1]
    ]; // All 8 possible directions

    for (int r = 0; r < _gridSizeInt; r++) {
      for (int c = 0; c < _gridSizeInt; c++) {
        if (_board[r][c] == '') {
          for (var dir in directions) {
            int nr = r + dir[0];
            int nc = c + dir[1];
            if (nr >= 0 &&
                nr < _gridSizeInt &&
                nc >= 0 &&
                nc < _gridSizeInt &&
                _board[nr][nc] == 'O') {
              strategicPositions.add([r, c]);
              break; // Stop searching other directions once a match is found
            }
          }
        }
      }
    }
    return strategicPositions;
  }
}
