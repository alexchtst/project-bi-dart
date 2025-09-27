import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({super.key});

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  late VideoPlayerController _videoController;
  late Future<void> _initFuture;
  bool _dialogShowing = false;
  Timer? _autoNavigateTimer;
  bool _handledVideoEnd = false;
  int _playCount = 0; // Counter pemutaran
  final int _maxPlays = 5; // Maksimal 5 kali

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/video/IMG_3096.mp4');
    _initFuture = _videoController.initialize().then((_) {
      _videoController.setLooping(false);
      _videoController.setVolume(0);
      _startFirstPlay();
      _videoController.addListener(_videoListener);
    });
  }

  void _startFirstPlay() {
    _playCount = 1; // Mulai dari pemutaran ke-1
    _videoController.play();
    setState(() {});
  }

  void _videoListener() {
    final value = _videoController.value;
    if (!_handledVideoEnd &&
        value.isInitialized &&
        !value.isPlaying &&
        value.position >= value.duration) {
      _handledVideoEnd = true;
      
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _handleVideoEnd();
        }
      });
    }
  }

  void _handleVideoEnd() {
    if (_playCount < _maxPlays) {
      // Belum mencapai 5 kali, lanjut otomatis
      _playCount++;
      _restartVideo();
    } else {
      // Sudah 5 kali, tampilkan dialog
      _showCompletionDialog();
    }
  }

  void _restartVideo() {
    if (!mounted) return;
    
    _handledVideoEnd = false;
    _videoController.seekTo(Duration.zero).then((_) {
      if (mounted) {
        _videoController.play();
        setState(() {}); // Update UI untuk counter
      }
    });
  }

  void _showCompletionDialog() {
    if (_dialogShowing || !mounted) return;
    _dialogShowing = true;

    // Timer untuk auto navigate ke home setelah 10 detik
    _autoNavigateTimer?.cancel();
    _autoNavigateTimer = Timer(const Duration(seconds: 10), () {
      _handleAutoNavigate();
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tutorial Selesai'),
          content: const Text('Tutorial telah diputar 5 kali. Akan otomatis kembali ke menu utama dalam 10 detik.'),
          actions: [
            TextButton(
              onPressed: () {
                _handleManualContinue();
              },
              child: const Text('Lanjut'),
            ),
            TextButton(
              onPressed: () {
                _handleManualHome();
              },
              child: const Text('Ke Menu Utama'),
            ),
          ],
        );
      },
    ).then((_) {
      _dialogShowing = false;
      _autoNavigateTimer?.cancel();
    });
  }

  void _handleAutoNavigate() {
    if (!mounted || !_dialogShowing) return;
    
    Navigator.of(context, rootNavigator: true).pop();
    
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, "/mode");
      }
    });
  }

  void _handleManualContinue() {
    if (!mounted) return;
    
    _autoNavigateTimer?.cancel();
    Navigator.of(context, rootNavigator: true).pop();
    
    // Reset dan mulai lagi dari awal
    _playCount = 0;
    _handleVideoEnd();
  }

  void _handleManualHome() {
    if (!mounted) return;
    
    _autoNavigateTimer?.cancel();
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.pushReplacementNamed(context, "/");
  }

  @override
  void dispose() {
    _autoNavigateTimer?.cancel();
    _videoController.removeListener(_videoListener);
    _videoController.dispose();
    super.dispose();
  }

  Widget _buildBackground() {
    return FutureBuilder(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            _videoController.value.isInitialized) {
          return SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _videoController.value.size.width,
                height: _videoController.value.size.height,
                child: VideoPlayer(_videoController),
              ),
            ),
          );
        } else {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/quiz-flash-card-background.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Center(child: CircularProgressIndicator()),
            ],
          );
        }
      },
    );
  }

  Widget _buildCounter() {
    return Positioned(
      top: 50,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color.fromARGB(104, 0, 0, 0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '$_playCount/$_maxPlays',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          Container(color: const Color.fromARGB(90, 0, 0, 0)), // overlay tipis
          _buildCounter(), // Tambahkan counter di pojok kanan atas
        ],
      ),
    );
  }
}