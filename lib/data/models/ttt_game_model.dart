import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/domain/config/game_repo.dart';

class TicTacToeGameModel extends ChangeNotifier {
  //Scores

  String winningMessage = '';

  bool _isPlayerTurn = true;
  bool get isPlayerTurn => _isPlayerTurn;

  List<List<String>> _board = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];
  String _currentPlayer = 'X';
  String _winner = 'X';
  bool _isPlayerVsAI = false;
  String _levelDifficulty = 'easy';
  String _gridSize = '3x3';
  int _gridSizeInt = 3;
  List<List<int>> _winSequence = [];
  bool _isGameFinished = false;
  bool _clickedInNewCell = false;

  bool get clickedInNewCell => _clickedInNewCell;
  bool get isGameFinished => _isGameFinished;
  List<List<int>> get winSequence => _winSequence;
  List<List<String>> get board => _board;
  String get currentPlayer => _currentPlayer;
  String get winner => _winner;
  bool get isPlayerVsAI => _isPlayerVsAI;
  String get levelDifficulty => _levelDifficulty;
  String get gridSize => _gridSize;
  int get gridSizeInt => _gridSizeInt;

  int _scoreX = 0;
  int _scoreY = 0;
  int get scoreX => _scoreX;
  int get scoreO => _scoreY;

  void setBoardSize(int size, String? gridSize) {
    _board = List.generate(size, (_) => List.filled(size, ''));
    _gridSize = gridSize ?? '3x3';
    _gridSizeInt = size;
    debugPrint('Board size set to $size');
    notifyListeners();
  }

  void setLevelDifficulty(String difficulty) {
    _levelDifficulty = difficulty;
    debugPrint('Level difficulty set to $difficulty');
    notifyListeners();
  }

  void setPlayerVsAI(bool isPlayerVsAI) {
    _isPlayerVsAI = isPlayerVsAI;
    debugPrint('Player vs AI set to $isPlayerVsAI');
    notifyListeners();
  }

  void finishGame() {
    debugPrint('Game finished ----------------, winner: $_winner');
    _isGameFinished = true;
    if (_winner == 'X') {
      _scoreX++;
      debugPrint('incrementing score X');
    } else if (_winner == 'O') {
      _scoreY++;
      debugPrint('incrementing score Y');
    }
    notifyListeners();
  }

  void setPlayerTurn(bool isPlayerTurn) {
    _isPlayerTurn = isPlayerTurn;
    notifyListeners();
  }

  bool makeMove(int i, int j) {
    if (_board[i][j] == '') {
      _board[i][j] = _currentPlayer;
      if (checkWinner()) {
        _winner = _currentPlayer;
        finishGame();
        debugPrint('Winner: $_winner');
      } else if (isBoardFull()) {
        _winner = 'DRAW';
        debugPrint('Winner: $_winner');
      }
      _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      _clickedInNewCell = true;
      return true;
    }
    _clickedInNewCell = false;
    return false;
  }

  bool checkWinner() {
    int winLength =
        GameRepo().gameConfigurations[_gridSize]!['win_length'] ?? 3;
    String playerSuper = "Super $_currentPlayer";

    bool isPlayerSymbol(String symbol) {
      return symbol == _currentPlayer || symbol == playerSuper;
    }

    // check rows
    for (int row = 0; row < _gridSizeInt; row++) {
      for (int col = 0; col <= _gridSizeInt - winLength; col++) {
        bool hasWinningSequence = true;

        for (int c = col; c < col + winLength; c++) {
          if (!isPlayerSymbol(board[row][c])) {
            hasWinningSequence = false;
            break;
          }
        }

        if (hasWinningSequence) {
          _winSequence =
              List.generate(winLength, (index) => [row, col + index]);
          debugPrint(
              'Winning sequence found in row $row, sequence: $_winSequence');
          return true;
        }
      }
    }

    // check columns
    for (int col = 0; col < _gridSizeInt; col++) {
      for (int row = 0; row <= _gridSizeInt - winLength; row++) {
        bool hasWinningSequence = true;

        for (int r = row; r < row + winLength; r++) {
          if (!isPlayerSymbol(board[r][col])) {
            hasWinningSequence = false;
            break;
          }
        }

        if (hasWinningSequence) {
          _winSequence =
              List.generate(winLength, (index) => [row + index, col]);
          debugPrint(
              'Winning sequence found in column $col, sequence: $_winSequence');
          return true;
        }
      }
    }

    // check diagonal (top-left to bottom-right) for win
    for (int row = 0; row <= _gridSizeInt - winLength; row++) {
      for (int col = 0; col <= _gridSizeInt - winLength; col++) {
        bool hasWinningSequence = true;

        for (int i = 0; i < winLength; i++) {
          if (!isPlayerSymbol(board[row + i][col + i])) {
            hasWinningSequence = false;
            break;
          }
        }

        if (hasWinningSequence) {
          _winSequence =
              List.generate(winLength, (index) => [row + index, col + index]);
          debugPrint(
              'Winning sequence found in diagonal sequence: $_winSequence');
          return true;
        }
      }
    }

    //Check diagonal (bottom-left to top-right) for win
    for (int row = winLength - 1; row < _gridSizeInt; row++) {
      for (int col = 0; col <= _gridSizeInt - winLength; col++) {
        bool hasWinningSequence = true;

        for (int i = 0; i < winLength; i++) {
          if (!isPlayerSymbol(board[row - i][col + i])) {
            hasWinningSequence = false;
            break;
          }
        }

        if (hasWinningSequence) {
          _winSequence =
              List.generate(winLength, (index) => [row - index, col + index]);
          debugPrint(
              'Winning sequence found in diagonal, sequence: $_winSequence');
          return true;
        }
      }
    }

    return false;
  }

  void aiEasyMove() {
    List emptyCells = [];

    for (int i = 0; i < _board.length; i++) {
      for (int j = 0; j < _board[i].length; j++) {
        if (_board[i][j] == '') {
          emptyCells.add([i, j]);
        }
      }
    }

    if (emptyCells.isNotEmpty) {
      final random = Random();
      final randomIndex = random.nextInt(emptyCells.length);
      final randomCell = emptyCells[randomIndex];
      makeMove(randomCell[0], randomCell[1]);
    }
  }

  void aiHardMove({String player = 'O', String opponent = 'X'}) {
    int winLength =
        GameRepo().gameConfigurations[_gridSize]?['win_length'] ?? 3;

    // Check for any immediate winning moves first
    for (int row = 0; row < _gridSizeInt; row++) {
      for (int col = 0; col < gridSizeInt; col++) {
        if (board[row][col] == '') {
          // Attempt to place the player's symbol and check for a win
          board[row][col] = player;
          if (checkWinner()) {
            board[row][col] = ''; // Reset the board after checking
            makeMove(col, row); // Execute the winning move
            debugPrint('winning move');
          }
          board[row][col] = ''; // Reset if not a winning move
        }
      }
    }

    // If no winning move is found, check for necessary blocks
    for (int row = 0; row < gridSizeInt; row++) {
      for (int col = 0; col < gridSizeInt; col++) {
        if (board[row][col] == '') {
          // Attempt to place the opponent's symbol and check for a win
          board[row][col] = opponent;
          if (checkWinner()) {
            board[row][col] = ''; // Reset the board after checking
            makeMove(col, row); // Block the opponent
            debugPrint('blocking move');
          }
          board[row][col] = ''; // Reset if not a blocking move
        }
      }
    }

    // Consider less immediate strategic moves if no immediate threats or opportunities
    List<List<int>>? strategicPositions =
        checkNearWin(_board, player, opponent, winLength, _gridSizeInt);
    if (strategicPositions.isNotEmpty) {
      List<int> move =
          strategicPositions[Random().nextInt(strategicPositions.length)];
      debugPrint('strategic move');
      makeMove(move[0], move[1]); // Execute the strategic move
      return;
    }

    // As a fallback, make a random move
    List<List<int>> emptyPositions = [];
    for (int r = 0; r < _gridSizeInt; r++) {
      for (int c = 0; c < _gridSizeInt; c++) {
        if (_board[r][c] == '') {
          emptyPositions.add([r, c]);
        }
      }
    }

    if (emptyPositions.isNotEmpty) {
      List<int> randomMove =
          emptyPositions[Random().nextInt(emptyPositions.length)];
      debugPrint('random move');
      makeMove(randomMove[0], randomMove[1]); // Execute the random move
    }
  }

  List<List<int>> checkNearWin(
    List<List<String?>> board,
    String player,
    String opponent,
    int winLength,
    int gridSize,
  ) {
    List<List<int>> criticalThreats =
        []; // Immediate blocking needed (3 in a row with an open end)
    List<List<int>> potentialThreats =
        []; // Potential threats (2 in a row with open ends)
    List<List<int>> directions = [
      [0, 1], // Right
      [1, 0], // Down
      [1, 1], // Diagonal down-right
      [-1, 1], // Diagonal up-right
    ];

    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        if (board[row][col] == '') {
          // Check from empty spots
          for (List<int> d in directions) {
            int sequenceLength = 0;
            int openEnds = 0;

            // Check backward
            int backR = row - d[0];
            int backC = col - d[1];
            while (backR >= 0 &&
                backR < gridSize &&
                backC >= 0 &&
                backC < gridSize &&
                board[backR][backC] == opponent) {
              sequenceLength++;
              backR -= d[0];
              backC -= d[1];
            }

            // Check forward
            int forwardR = row + d[0];
            int forwardC = col + d[1];
            while (forwardR >= 0 &&
                forwardR < gridSize &&
                forwardC >= 0 &&
                forwardC < gridSize &&
                board[forwardR][forwardC] == opponent) {
              sequenceLength++;
              forwardR += d[0];
              forwardC += d[1];
            }

            // Count open ends
            if (backR >= 0 &&
                backR < gridSize &&
                backC >= 0 &&
                backC < gridSize &&
                board[backR][backC] == '') {
              openEnds++;
            }
            if (forwardR >= 0 &&
                forwardR < gridSize &&
                forwardC >= 0 &&
                forwardC < gridSize &&
                board[forwardR][forwardC] == '') {
              openEnds++;
            }

            if (sequenceLength == 2 && openEnds > 0) {
              potentialThreats.add([row, col]); // Collect potential threats
            } else if (sequenceLength == 3 && openEnds > 0) {
              criticalThreats.add([row, col]); // Collect critical threats
            }
          }
        }
      }
      debugPrint(
          'criticalThreats: $criticalThreats, potentialThreats: $potentialThreats');
    }

    // Return threats, prioritizing critical threats first
    return criticalThreats.isNotEmpty ? criticalThreats : potentialThreats;
  }

  void aiMove() async {
    List<List<int>> emptyCells = [];

    for (int row = 0; row < _gridSizeInt; row++) {
      for (int col = 0; col < _gridSizeInt; col++) {
        if (board[row][col] == '') {
          emptyCells.add([row, col]);
        }
      }
    }

    if (_levelDifficulty == 'easy') {
      await Future.delayed(Durations.medium1, () {
        aiEasyMove();
      });
    } else if (_levelDifficulty == 'medium') {
      await Future.delayed(Durations.medium1, () {
        aiEasyMove();
      });
    } else if (_levelDifficulty == 'hard') {
      await Future.delayed(Durations.medium1, () {
        aiHardMove();
      });
    }
    setPlayerTurn(true);
  }

  bool isBoardFull() {
    for (var row in board) {
      if (row.contains('')) return false;
    }
    debugPrint('Board is full');
    return true;
  }

  void resetScore() {
    _scoreX = 0;
    _scoreY = 0;
    notifyListeners();
  }

  void resetGame() {
    _board = List.generate(_gridSizeInt, (_) => List.filled(_gridSizeInt, ''));
    _currentPlayer = 'X';
    _winner = 'X';
    _isGameFinished = false;
    notifyListeners();
  }
}
