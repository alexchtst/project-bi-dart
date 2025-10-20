import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syndo/utils/scanner_provider.dart';
import 'package:video_player/video_player.dart';

class MediaDisplayScreen extends StatelessWidget {
  const MediaDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scanner = context.watch<ScannerProvider>();

    if (scanner.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (scanner.hasError) {
      return const Scaffold(body: Center(child: Text('Gagal memuat media.')));
    }

    if (scanner.detectedCode.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Tidak ada media ditemukan.')),
      );
    }

    if (scanner.detectedCode.endsWith('.mov') &&
        scanner.videoController != null) {
      final controller = scanner.videoController!;
      final size = MediaQuery.of(context).size;

      return Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: size.height * 0.1,
                right: size.height * 0.1,
                child: AspectRatio(
                  aspectRatio:
                      controller.value.isInitialized
                          ? controller.value.aspectRatio
                          : 16 / 9,
                  child: VideoPlayer(controller),
                ),
              ),

              Positioned(
                bottom: size.height * 0.08,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton(
                      context,
                      label:
                          controller.value.isPlaying ? "Pause" : "Play Again",
                      icon:
                          controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                      onPressed: () {
                        controller.value.isPlaying
                            ? controller.pause()
                            : controller.play();
                      },
                    ),
                    const SizedBox(width: 16),
                    _buildButton(
                      context,
                      label: "Scan Lagi",
                      icon: Icons.qr_code_scanner,
                      onPressed: () {
                        Navigator.pushNamed(context, '/quiz-flash-card-alphabet');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Image.network(
                  scanner.detectedCode,
                  fit: BoxFit.fill,
                  errorBuilder:
                      (_, __, ___) =>
                          const Text('Tidak bisa menampilkan gambar.'),
                ),
              ),
            ),
            _buildButton(
              context,
              label: "Scan Lagi",
              icon: Icons.qr_code_scanner,
              onPressed: () {
                Navigator.pushNamed(context, '/quiz-flash-card-alphabet');
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber[700],
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Icon(icon, color: Colors.black),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
