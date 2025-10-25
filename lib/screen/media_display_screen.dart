import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syndo/utils/scanner_provider.dart';
import 'package:syndo/widgets/button/navigation_button.dart';
import 'package:video_player/video_player.dart';

class MediaDisplayScreen extends StatelessWidget {
  const MediaDisplayScreen({super.key, required this.isParentmemo});

  final bool isParentmemo;

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
                left: 0,
                top: 0,
                child: NavigationButton(
                  onTap: () {
                    if (isParentmemo) {
                      Navigator.pop(context, '/memo-landing');
                    } else {
                      Navigator.pop(context, '/quiz-flash-card');
                    }
                  },
                ),
              ),
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
                        if (isParentmemo) {
                          Navigator.pop(context, '/memo-landing');
                        } else {
                          Navigator.pop(context, '/quiz-flash-card');
                        }
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
                      (_, __, ___) => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.width * 0.02,),
                          Row(
                            children: [
                              NavigationButton(
                                onTap: () {
                                  if (isParentmemo) {
                                    Navigator.pop(context, '/memo-landing');
                                  } else {
                                    Navigator.pop(
                                      context,
                                      '/quiz-flash-card',
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.width * 0.02,),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.01,
                            ),
                            margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.width * 0.01,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 255, 204, 62),
                                  Color.fromARGB(255, 250, 158, 12),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Text(
                              'Tidak bisa menampilkan gambar.',
                              style: TextStyle(
                                fontFamily: 'Baloo',
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.025,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                ),
              ),
            ),
            _buildButton(
              context,
              label: "Scan Lagi",
              icon: Icons.qr_code_scanner,
              onPressed: () {
                if (isParentmemo) {
                  if (isParentmemo) {
                    Navigator.pop(context, '/memo-landing');
                  } else {
                    Navigator.pop(context, '/quiz-flash-card');
                  }
                }
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
