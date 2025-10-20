import 'package:flutter/material.dart';
import 'package:syndo/utils/helper.dart';
import 'package:video_player/video_player.dart';

class ScannerProvider extends ChangeNotifier {
  String _detectedCode = "";
  bool _isLoading = false;
  bool _hasError = false;
  VideoPlayerController? _videoController;

  String get detectedCode => _detectedCode;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  VideoPlayerController? get videoController => _videoController;

  void setDetectedCode(String code) {
    _detectedCode = processInputQr(code);
    print(_detectedCode);
    notifyListeners();
  }

  Future<void> fetchMedia() async {
    if (_detectedCode.isEmpty) return;

    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      if (_detectedCode.endsWith('.mov')) {
        _videoController = VideoPlayerController.network(_detectedCode);
        await _videoController!.initialize();
        await _videoController!.play();
      }

      _isLoading = false;
      notifyListeners();
    } catch (_) {
      _isLoading = false;
      _hasError = true;
      notifyListeners();
    }
  }

  void reset() {
    _detectedCode = "";
    _hasError = false;
    _isLoading = false;
    _videoController?.dispose();
    _videoController = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }
}
