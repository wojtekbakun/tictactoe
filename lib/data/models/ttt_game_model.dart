import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tictactoe/domain/config/game_repo.dart';

class TicTacToeGameModel extends ChangeNotifier {
  // SETTINGS
  List<List<String>> _board = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];
  bool _isPlayerVsAI = false;
  String _levelDifficulty = 'easy';
  String _gridSize = '3x3';
  int _gridSizeInt = 3;
  bool _isMusicPlaying = true;

  // GAMEPLAY
  bool _isPlayerTurn = true;
  String _currentPlayer = 'X';
  String _winner = 'X';
  bool _isGameFinished = false;
  List<List<int>> _winSequence = [];
  bool _clickedInNewCell = false;
  int _scoreX = 0;
  int _scoreY = 0;

  // GETTERS
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
  int get scoreX => _scoreX;
  int get scoreO => _scoreY;
  bool get isMusicPlaying => _isMusicPlaying;
  bool get isPlayerTurn => _isPlayerTurn;

  /*

  HELPERS

  */

  void setMusicPlaying(bool isPlaying) {
    _isMusicPlaying = isPlaying;
    debugPrint('music playing set to $isPlaying');
    notifyListeners();
  }

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

  void setPlayerTurn(bool isPlayerTurn) {
    _isPlayerTurn = isPlayerTurn;
    notifyListeners();
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

  /*

  END OF SETTINGS

  */

  /*

  ==================================== GAMEPLAY

  */

  bool makeMove(int i, int j) {
    if (_board[i][j] == '') {
      debugPrint('Move made at $i, $j: $_currentPlayer');
      shouldMakeSuperMove()
          ? {makeSuperMove(i, j), debugPrint('making super move')}
          : {
              simpleMove(i, j),
              _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X',
              debugPrint('making simple move')
            };
      // simpleMove(i, j);
      // shouldMakeSuperMove()
      //     ? {makeSuperMove(i, j), debugPrint('making super move')}
      //     : debugPrint('not making super move');
      _clickedInNewCell = true;

      return true;
    }
    _clickedInNewCell = false;
    return false;
  }

  bool simpleMove(int i, int j) {
    _board[i][j] = _currentPlayer;
    debugPrint('making simple move');
    if (checkWinner(_currentPlayer)) {
      _winner = _currentPlayer;
      finishGame();
      debugPrint('Winner: $_winner');
      return true;
    } else if (isBoardFull()) {
      _winner = 'DRAW';
      debugPrint('Winner: $_winner');
      finishGame();
      return true;
    }

    debugPrint('Simple move made, current player: $_currentPlayer');
    notifyListeners();

    return true;
  }

  bool superMove(int i, int j) {
    _board[i][j] = _currentPlayer;
    if (checkWinner(_currentPlayer)) {
      _winner = _currentPlayer;
      finishGame();
      debugPrint('Winner: $_winner');
      return true;
    } else if (isBoardFull()) {
      _winner = 'DRAW';
      debugPrint('Winner: $_winner');
      finishGame();
      return true;
    }

    _clickedInNewCell = true;
    notifyListeners();
    return true;
  }

  bool checkWinner(String player) {
    int winLength =
        GameRepo().gameConfigurations[_gridSize]!['win_length'] ?? 3;
    String playerSuper = "Super $player";

    bool isPlayerSymbol(String symbol) {
      return symbol == player || symbol == playerSuper;
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
  //  ==============================================
  //  ============================================== AI
  //  ==============================================

  void aiFirstMove() {
    int center = _gridSizeInt ~/ 2;
    if (_isPlayerVsAI) {
      if (_board[center][center] == '' && _levelDifficulty == 'hard') {
        _currentPlayer = 'O';
        debugPrint('AI first move: $_currentPlayer');
        makeMove(center, center);
      } else {
        bool randomBool = Random().nextBool();
        if (randomBool) {
          _currentPlayer = 'Super O';
          makeMove(center, center);
        } else {
          _currentPlayer = 'O';
          makeMove(center, center);
        }
      }
    }
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
      _currentPlayer = 'O';
      makeMove(randomCell[0], randomCell[1]);
    }
  }

  void aiHardMove({String player = 'O', String opponent = 'X'}) {
    int winLength =
        GameRepo().gameConfigurations[_gridSize]?['win_length'] ?? 3;

    debugPrint('AI is thinking...');

    // Check for any immediate winning moves first
    for (int row = 0; row < _gridSizeInt; row++) {
      for (int col = 0; col < gridSizeInt; col++) {
        if (_board[row][col] == '') {
          // Attempt to place the player's symbol and check for a win
          _board[row][col] = player;
          _currentPlayer = player;
          debugPrint(
              'checking for winning move for player $player: ${checkWinner(player)}');
          if (checkWinner(player)) {
            _board[row][col] = ''; // Reset the board after checking
            _currentPlayer = player;
            makeMove(row, col); // Execute the winning move
            debugPrint('winning move');
            return;
          }
          _board[row][col] = ''; // Reset if not a winning move
        }
      }
    }

    // If no winning move is found, check for necessary blocks
    for (int row = 0; row < gridSizeInt; row++) {
      for (int col = 0; col < gridSizeInt; col++) {
        if (_board[row][col] == '') {
          // Attempt to place the opponent's symbol and check for a win
          _board[row][col] = opponent;
          debugPrint(
              'checking for blocking winning move for player $opponent: ${checkWinner(opponent)}');
          if (checkWinner(opponent)) {
            _board[row][col] = ''; // Reset the board after checking
            _currentPlayer = player;
            makeMove(row, col); // Block the opponent
            debugPrint('blocking move : $row, $col');
            return;
          }
          _board[row][col] = ''; // Reset if not a blocking move
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
      _currentPlayer = player;
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
    debugPrint('---------------------------------');
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
          '----- checked: criticalThreats: $criticalThreats, potentialThreats: $potentialThreats');
    }

    // Return threats, prioritizing critical threats first
    return criticalThreats.isNotEmpty ? criticalThreats : potentialThreats;
  }

  Future aiMove() async {
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
    return null;
  }

  // ==============================================
  // ==============================================  SUPER BUBBLE
  // ==============================================

  int _maxSuperSymbols = 0;
  int _superXCount = 0;
  //int _superOCount = 0;
  bool _placedSuperSymbol = false;

  int get superXCount => _superXCount;
  //int get superOCount => _superOCount;
  int get maxSuperSymbols => _maxSuperSymbols;
  bool get placedSuperSymbol => _placedSuperSymbol;

  void setSuperSymbolPlaced(bool isPlaced) {
    _placedSuperSymbol = isPlaced;
    notifyListeners();
  }

  void setSuperXCount(int count) {
    _superXCount = count;
    debugPrint('Super X count set to $count');
    notifyListeners();
  }

  void setMaxSuperSymbols(int max) {
    _maxSuperSymbols = max;
    notifyListeners();
  }

  void initSuperGame() {
    _maxSuperSymbols =
        GameRepo().getSuperBubbleMax(_levelDifficulty, _gridSizeInt);
    _superXCount = _maxSuperSymbols;
    //_superOCount = _maxSuperSymbols;
    debugPrint(
        'Super game initialized, max super symbols: $_maxSuperSymbols, superXCount: $_superXCount chance: ${getChance()}');
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
    int randomInt = Random().nextInt(getChance());
    debugPrint(
        'Super symbol chance: ${getChance()}: randomInt: $randomInt, condition: ${(_superXCount < _maxSuperSymbols && _superXCount > 0 && randomInt <= 100)}');

    return _superXCount <= _maxSuperSymbols &&
        _superXCount > 0 &&
        randomInt <= 5;
  }

  void changeToSuperSymbol(String whatPlayer) {
    if (whatPlayer == 'O') {
      _currentPlayer = 'Super O';
    } else {
      _currentPlayer = 'Super X';
    }
    _placedSuperSymbol = true;
    debugPrint('Super symbol changed: $_currentPlayer');
  }

  Future<void> makeSuperMove(int i, int j) {
    List<List<int>> emptyCells = getEmptyCells();
    emptyCells.shuffle();
    //cells to pop should be a list 3 random cells from the empty cells
    List<List<int>> cellsToPop = emptyCells.take(_superXCount).toList();
    changeToSuperSymbol(_currentPlayer);
    applySuperXRandomEffect(i, j, cellsToPop, _levelDifficulty);
    return Future.delayed(const Duration(milliseconds: 100));
  }

  Future<void> applySuperXRandomEffect(
      int i, int j, List<List<int>> cellsToPop, String difficulty) async {
    simpleMove(i, j);
    for (var pos in cellsToPop) {
      await Future.delayed(const Duration(milliseconds: 200), () {
        superMove(
          pos[0],
          pos[1],
        );
        debugPrint('Super X effect applied to cell: $pos');
        setSuperXCount(_superXCount - 1);
      });
    }
    _currentPlayer = _currentPlayer == 'Super X' ? 'O' : 'X';
    debugPrint('-----> SUPER move made, current player: $_currentPlayer');
    notifyListeners();
  }
}
