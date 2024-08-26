import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  final AudioPlayer _backgroundPlayer = AudioPlayer();
  final AudioPlayer _effectPlayer = AudioPlayer();

  Future<void> playBackgroundMusic(String musicPath) async {
    await _backgroundPlayer
        .setReleaseMode(ReleaseMode.loop); // Ustawienie trybu zapętlenia
    await _backgroundPlayer.play(AssetSource(musicPath));
  }

  Future<void> playEffectSound(String effectPath) async {
    await _effectPlayer.play(AssetSource(effectPath));
  }

  Future<void> stopBackgroundMusic() async {
    await _backgroundPlayer.stop();
  }

  Future<void> stopEffectSound() async {
    await _effectPlayer.stop();
  }
}
