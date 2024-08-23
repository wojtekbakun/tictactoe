class MyConsts {
  static const int cellSize = 300;
  static const int gridSize = 3;
  static const int width = cellSize * gridSize;
  static const int height = cellSize * gridSize;
  static const int topOffset = height ~/ 6;
  static const int bottomOffset = height ~/ 20;
  static const int lineWidth = 5;
  static const List<List<String>> board = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];
  static const String player = 'X';
  static const bool gameOver = false;
  static const int screenHeight = height + topOffset + bottomOffset;

  static const String backgroundImagePath = 'assets/images/sky.jpg';
  static const String loadingImagePath = 'assets/images/beach.jpg';

  static const String xBubblePath = 'assets/images/bubble_x.jpeg';
  static const String oBubblePath = 'assets/images/bubble_o.jpg';
  static const String superOBubblePath = 'assets/images/super_o.png';
  static const String superXBubblePath = 'assets/images/super_x.jpg';
  static const String bubblePath = 'assets/images/bubble.jpeg';

  static const String sixWinningPath = 'assets/images/number_4.png';
  static const String nineWinningPath = 'assets/images/number_5.png';
  static const String elevenWinningPath = 'assets/images/number_6.jpg';
  static const String fifteenWinningPath = 'assets/images/number_7.png';
  static const String eighteenWinningPath = 'assets/images/number_8.jpg';
  static const String twentyoneWinningPath = 'assets/images/number_9.jpg';

  static const String threeCornerAd = 'assets/images/3x3v.png';
  static const String sixNineSuperCornerAd = 'assets/images/6x6_9x9v_super.png';
  static const String sixNineCornerAd = 'assets/images/6x6_9x9v.png';
  static const String elevenCornerAd = 'assets/images/11x11v.png';
  static const String fifteenCornerAd = 'assets/images/15x15_21x21v.png';

  static const String bubblePopSoundPath = 'assets/sounds/background_music.wav';
  static const String winSoundPath = 'assets/sounds/new_swoosh.mp3';
  static const String buttonClickSoundPath =
      'assets/sounds/click_sound_effect.mp3';
  static const String backgroundSoundPath =
      'assets/sounds/background_music.wav';
  static const String superBubbleSoundPath =
      'assets/sounds/jackpot_sound_edit.mp3';
}
