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
}
