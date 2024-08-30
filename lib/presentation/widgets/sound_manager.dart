import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SoundManager extends ChangeNotifier {
  final AudioPlayer _backgroundPlayer = AudioPlayer();
  final AudioPlayer _clickPlayer = AudioPlayer();
  final AudioPlayer _effectPlayer = AudioPlayer();
  final AudioPlayer _effectPlayer2 = AudioPlayer();
  final AudioPlayer _effectPlayer3 = AudioPlayer();
  final AudioPlayer _effectPlayer4 = AudioPlayer();
  final AudioPlayer _effectSuper = AudioPlayer();

  AudioPlayer get backgroundPlayer => _backgroundPlayer;
  AudioPlayer get effectPlayer => _effectPlayer;

  Future<void> playBackgroundMusic(String musicPath) async {
    _backgroundPlayer
        .setReleaseMode(ReleaseMode.loop); // Ustawienie trybu zapętlenia

    _backgroundPlayer.setVolume(1); // Ustawienie głośności
    _backgroundPlayer.play(AssetSource(musicPath));
  }

  Future<void> playClickSound(String effectPath) async {
    await _clickPlayer.play(AssetSource(effectPath));
  }

  Future<void> playEffectSound(String effectPath) async {
    await _effectPlayer.play(AssetSource(effectPath));
  }

  Future<void> playEffectSound2(String effectPath) async {
    await _effectPlayer2.play(AssetSource(effectPath));
  }

  Future<void> playEffectSound3(String effectPath) async {
    await _effectPlayer3.play(AssetSource(effectPath));
  }

  Future<void> playEffectSound4(String effectPath) async {
    await _effectPlayer4.play(AssetSource(effectPath));
  }

  Future<void> playEffectSuper(String effectPath) async {
    await _effectSuper.play(AssetSource(effectPath));
  }

  Future<void> stopBackgroundMusic() async {
    await _backgroundPlayer.stop();
  }

  Future<void> stopEffectSound() async {
    await _effectPlayer.stop();
    await _effectPlayer2.stop();
    await _effectPlayer3.stop();
    await _effectPlayer4.stop();
    await _effectSuper.stop();
  }

  void disposeBackgroundSound() {
    _backgroundPlayer.dispose();
  }

  void disposeEffectPlayers() {
    _effectPlayer.dispose();
    _effectPlayer2.dispose();
    _effectPlayer3.dispose();
    _effectPlayer4.dispose();
  }

  PlayerState getBackgroundPlayerState() {
    debugPrint('Background player state: ${_backgroundPlayer.state}');
    return _backgroundPlayer.state;
  }
}
