import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SoundManager extends ChangeNotifier {
  final AudioPlayer _backgroundPlayer = AudioPlayer();
  final AudioPlayer _effectPlayer = AudioPlayer();
  final AudioPlayer _effectPlayer2 = AudioPlayer();

  AudioPlayer get backgroundPlayer => _backgroundPlayer;
  AudioPlayer get effectPlayer => _effectPlayer;

  Future<void> playBackgroundMusic(String musicPath) async {
    await _backgroundPlayer
        .setReleaseMode(ReleaseMode.loop); // Ustawienie trybu zapętlenia
    await _backgroundPlayer.setVolume(1); // Ustawienie głośności
    await _backgroundPlayer.play(AssetSource(musicPath));
    return Future.value();
  }

  Future<void> playEffectSound(String effectPath) async {
    await _effectPlayer.play(AssetSource(effectPath));
    return Future.value();
  }

  Future<void> playEffect2Sound(String effectPath) async {
    await _effectPlayer2.play(AssetSource(effectPath));
    return Future.value();
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
    await _effectPlayer.dispose();
    await _effectPlayer2.dispose();
    return Future.value();
  }

  PlayerState getBackgroundPlayerState() {
    return _backgroundPlayer.state;
  }
}
