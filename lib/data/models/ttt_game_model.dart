import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TicTacToeGameModel extends ChangeNotifier {
  //Scores
  int xScore = 0;
  int yScore = 0;

  String winningMessage = '';

  bool isPlayerTurn = true;

  List<List<String>> _board = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];
  String _currentPlayer = 'X';
  String _winner = '';
  final bool _isPlayerVsAI = false;
  final String _level = 'EASY';
  final String _gridSize = '3x3 Grid';

  List<List<String>> get board => _board;
  String get currentPlayer => _currentPlayer;
  String get winner => _winner;
  bool get isPlayerVsAI => _isPlayerVsAI;
  String get level => _level;
  String get gridSize => _gridSize;

  bool makeMove(int i, int j) {
    if (_board[i][j] == '') {
      _board[i][j] = _currentPlayer;
      if (checkWinner()) {
        _winner = _currentPlayer;
        debugPrint('Winner: $_winner');
      } else if (isBoardFull()) {
        _winner = 'DRAW';
        debugPrint('Winner: $_winner');
      }
      _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      debugPrint('Current player: $_currentPlayer');
      return true;
    }
    return false;
  }

  bool checkWinner() {
    // check rows
    for (var i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] &&
          board[i][1] == board[i][2] &&
          board[i][0] != '') {
        return true;
      }
    }

    // check columns
    for (var i = 0; i < 3; i++) {
      if (board[0][i] == board[1][i] &&
          board[1][i] == board[2][i] &&
          board[0][i] != '') {
        return true;
      }
    }

    // check diagonals
    if (board[0][0] == board[1][1] &&
        board[1][1] == board[2][2] &&
        board[0][0] != '') {
      return true;
    }

    if (board[0][2] == board[1][1] &&
        board[1][1] == board[2][0] &&
        board[0][2] != '') {
      return true;
    }

    return false;
  }

  bool isBoardFull() {
    for (var row in board) {
      if (row.contains('')) return false;
    }
    debugPrint('Board is full');
    return true;
  }

  void resetGame() {
    _board = List.generate(3, (_) => List.filled(3, ''));
    _currentPlayer = 'X';
    _winner = '';
  }
}
