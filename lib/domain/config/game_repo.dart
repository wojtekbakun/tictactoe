class GameRepo {
  final Map<String, Map<String, int>> gameConfigurations = {
    '3x3': {'grid_size': 3, 'win_length': 3},
    '6x6': {'grid_size': 6, 'win_length': 4},
    '9x9': {'grid_size': 9, 'win_length': 5},
    '11x11': {'grid_size': 11, 'win_length': 6},
    '15x15': {'grid_size': 15, 'win_length': 7},
    '18x18': {'grid_size': 18, 'win_length': 8},
    '21x21': {'grid_size': 21, 'win_length': 9}
  };

  int getSuperXBubbleMax(String difficulty, int gridSize) {
    int superBubbleMax = 0;

    if (gridSize == 3) {
      superBubbleMax = difficulty == 'hard' ? 0 : 1;
    }

    if (gridSize == 6 || gridSize == 9) {
      superBubbleMax = difficulty == 'hard' ? 1 : 2;
    }

    if (gridSize == 11) {
      superBubbleMax = difficulty == 'hard' ? 1 : 4;
    }

    if (gridSize == 15) {
      superBubbleMax = difficulty == 'hard' ? 2 : 6;
    }

    if (gridSize == 18) {
      superBubbleMax = difficulty == 'hard' ? 2 : 6;
    }

    if (gridSize == 21) {
      superBubbleMax = difficulty == 'hard' ? 3 : 6;
    }

    return superBubbleMax;
  }

  int getSuperOBubbleMax(String difficulty, int gridSize) {
    int superBubbleMax = 0;

    if (gridSize == 3) {
      superBubbleMax = difficulty == 'hard' ? 1 : 0;
    }

    if (gridSize == 6 || gridSize == 9) {
      superBubbleMax = difficulty == 'hard' ? 4 : 2;
    }

    if (gridSize == 11) {
      superBubbleMax = difficulty == 'hard' ? 6 : 3;
    }

    if (gridSize == 15) {
      superBubbleMax = difficulty == 'hard' ? 6 : 3;
    }

    if (gridSize == 18) {
      superBubbleMax = difficulty == 'hard' ? 6 : 3;
    }

    if (gridSize == 21) {
      superBubbleMax = difficulty == 'hard' ? 7 : 4;
    }

    return superBubbleMax;
  }

  int getCellsToPop(int gridSize) {
    switch (gridSize) {
      case 3:
        return 1;
      case 11:
        return 3;
      case 15:
        return 4;
      default:
        return 2;
    }
  }
}
