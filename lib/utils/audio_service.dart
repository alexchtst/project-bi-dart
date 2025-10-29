import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioService extends ChangeNotifier {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _bgPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer();

  bool _isMusicEnabled = true;
  bool _isPlaying = false;

  bool get isMusicEnabled => _isMusicEnabled;
  bool get isPlaying => _isPlaying;

  Future<void> initAudio() async {
    try {
      await _bgPlayer.setReleaseMode(ReleaseMode.loop);
      await _sfxPlayer.setReleaseMode(ReleaseMode.release);
      if (_isMusicEnabled) {
        await playBackgroundMusic();
      }
    } catch (e) {
      print('Error initializing audio: $e');
    }
  }

  Future<void> playBackgroundMusic() async {
    try {
      await _bgPlayer.setReleaseMode(ReleaseMode.loop);
      if (_isMusicEnabled && !_isPlaying) {
        await _bgPlayer.play(
          AssetSource(
            'audio/BACKSOUND_GAMELAN_INDONESIAN_MUSIC_ETHNIC_CULTURE.mp3',
          ),
        );
        _isPlaying = true;
        notifyListeners();
      }
    } catch (e) {
      print('Error playing background music: $e');
    }
  }

  Future<void> stopBackgroundMusic() async {
    try {
      await _bgPlayer.stop();
      _isPlaying = false;
      notifyListeners();
    } catch (e) {
      print('Error stopping background music: $e');
    }
  }

  Future<void> playWrong() async {
    try {
      if (_isMusicEnabled) {
        await _sfxPlayer.play(AssetSource('audio/wrong-buzzer.mp3'));
      }
    } catch (e) {
      print('Error playing wrong sound: $e');
    }
  }

  Future<void> playTrue() async {
    try {
      if (_isMusicEnabled) {
        await _sfxPlayer.play(AssetSource('audio/sonido-correcto.mp3'));
      }
    } catch (e) {
      print('Error playing true sound: $e');
    }
  }

  Future<void> toggleMusic() async {
    _isMusicEnabled = !_isMusicEnabled;
    if (_isMusicEnabled) {
      await playBackgroundMusic();
    } else {
      await stopBackgroundMusic();
    }
    notifyListeners();
  }

  Future<void> setVolume(double volume) async {
    await _bgPlayer.setVolume(volume);
    await _sfxPlayer.setVolume(volume);
  }

  @override
  void dispose() {
    _bgPlayer.dispose();
    _sfxPlayer.dispose();
    super.dispose();
  }
}
