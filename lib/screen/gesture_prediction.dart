// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class GesturePrediction extends StatefulWidget {
  const GesturePrediction({super.key});

  @override
  State<GesturePrediction> createState() => _GesturePredictionState();
}

class _GesturePredictionState extends State<GesturePrediction> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  Timer? _timer;

  String? _prediction;

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    // Minta izin kamera
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Camera permission denied")));
      return;
    }

    // Ambil daftar kamera
    final cameras = await availableCameras();

    // Pilih kamera depan (fallback ke kamera pertama jika tidak ada)
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller!.initialize();

    // Capture tiap 3 detik
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _captureAndSend();
    });

    setState(() {});
  }

  Future<void> _captureAndSend() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final image = await _controller!.takePicture();

      final request = http.MultipartRequest(
        "POST",
        Uri.parse(
          "https://assasasaasasasa.grayhill-39d1a131.southeastasia.azurecontainerapps.io/predict",
        ),
      );
      request.files.add(await http.MultipartFile.fromPath("file", image.path));

      final response = await request.send();
      final respStr = await response.stream.bytesToString();

      final decoded = jsonDecode(respStr);
      debugPrint("API Response: $decoded");

      setState(() {
        _prediction = decoded["prediction"]?.toString();
      });
    } catch (e) {
      debugPrint("Error saat mengirim gambar: $e");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_initializeControllerFuture == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              _controller != null) {
            return Stack(
              children: [
                // Fullscreen camera preview dengan aspect ratio yang pas
                Center(
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: CameraPreview(_controller!),
                  ),
                ),

                // Overlay prediksi
                Positioned(
                  bottom: 40,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _prediction != null
                          ? "Prediction: $_prediction"
                          : "Waiting for prediction...",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
