// ignore_for_file: avoid_print

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioService extends ChangeNotifier {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isMusicEnabled = true;
  bool _isPlaying = false;

  bool get isMusicEnabled => _isMusicEnabled;
  bool get isPlaying => _isPlaying;

  Future<void> initAudio() async {
    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);

      if (_isMusicEnabled) {
        await playBackgroundMusic();
      }
    } catch (e) {
      print('Error initializing audio: $e');
    }
  }

  Future<void> playBackgroundMusic() async {
    try {
      if (_isMusicEnabled && !_isPlaying) {
        await _audioPlayer.play(
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

  Future<void> pauseBackgroundMusic() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
        _isPlaying = false;
        notifyListeners();
      }
    } catch (e) {
      print('Error pausing background music: $e');
    }
  }

  Future<void> resumeBackgroundMusic() async {
    try {
      if (_isMusicEnabled && !_isPlaying) {
        await _audioPlayer.resume();
        _isPlaying = true;
        notifyListeners();
      }
    } catch (e) {
      print('Error resuming background music: $e');
    }
  }

  Future<void> stopBackgroundMusic() async {
    try {
      await _audioPlayer.stop();
      _isPlaying = false;
      notifyListeners();
    } catch (e) {
      print('Error stopping background music: $e');
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
    await _audioPlayer.setVolume(volume);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
