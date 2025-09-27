import 'package:flutter/material.dart';
import 'package:syndo/utils/audio_service.dart';
import 'package:syndo/widgets/button/menu_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioService _audioService = AudioService();

  @override
  void initState() {
    super.initState();
    // Tambahkan listener untuk update UI ketika state audio berubah
    _audioService.addListener(_onAudioStateChanged);
  }

  @override
  void dispose() {
    // Hapus listener untuk mencegah memory leak
    _audioService.removeListener(_onAudioStateChanged);
    super.dispose();
  }

  void _onAudioStateChanged() {
    // Update UI ketika state audio berubah
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MenuButton(
                  icon:
                      _audioService.isMusicEnabled
                          ? Icons.music_note
                          : Icons.music_off,
                  primary: false,
                  onPressed: () async {
                    await _audioService.toggleMusic();
                  },
                ),
                SizedBox(width: 20.0),
                MenuButton(
                  icon: Icons.play_arrow,
                  primary: true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/mode');
                  },
                ),
                SizedBox(width: 20.0),
                MenuButton(icon: Icons.info_outline),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MenuButton(
                  icon: Icons.chat,
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat-bot');
                  },
                ),
                SizedBox(width: 10.0),
                MenuButton(
                  icon: Icons.store,
                  onPressed: () {
                    Navigator.pushNamed(context, '/coins');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
