import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SoundManager extends ChangeNotifier {
  final AudioPlayer _backgroundPlayer = AudioPlayer();
  final AudioPlayer _effectPlayer = AudioPlayer();
  final AudioPlayer _effectPlayer2 = AudioPlayer();

  AudioPlayer get backgroundPlayer => _backgroundPlayer;
  AudioPlayer get effectPlayer => _effectPlayer;

  Future<void> playBackgroundMusic(String musicPath) async {
    _backgroundPlayer
        .setReleaseMode(ReleaseMode.loop); // Ustawienie trybu zapętlenia
    _backgroundPlayer.setVolume(1); // Ustawienie głośności
    _backgroundPlayer.play(AssetSource(musicPath));
  }

  Future<void> playEffectSound(String effectPath) async {
    await _effectPlayer.play(AssetSource(effectPath));
  }

  Future<void> stopBackgroundMusic() async {
    await _backgroundPlayer.stop();
  }

  Future<void> stopEffectSound() async {
    await _effectPlayer.stop();
    await _effectPlayer2.stop();
  }

  Future<void> disposePlayers() async {
    await _backgroundPlayer.dispose();
    // await _effectPlayer.dispose();
    // await _effectPlayer2.dispose();
  }

  PlayerState getBackgroundPlayerState() {
    return _backgroundPlayer.state;
  }
}
