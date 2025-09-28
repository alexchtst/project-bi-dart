import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syndo/screen/alphabet_word.dart';
import 'package:syndo/screen/chat_bot.dart';
import 'package:syndo/screen/coin_screen.dart';
import 'package:syndo/screen/home_screen.dart';
import 'package:syndo/screen/memo_evaluation.dart';
import 'package:syndo/screen/mode_screen.dart';
import 'package:syndo/screen/play_screen.dart';
import 'package:syndo/screen/quiz_flash_card.dart';
import 'package:syndo/screen/scan.dart';
import 'package:syndo/screen/scan_screen.dart';
import 'package:syndo/screen/study_screen.dart';
import 'package:syndo/utils/audio_service.dart';
import 'package:syndo/utils/data_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // landscape
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // audio
  await AudioService().initAudio();
  await AudioService().setVolume(2);

  // fullscreen
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider()..init(),
      child: MaterialApp(
        title: 'Lingo Hands',
        debugShowCheckedModeBanner: false,
        showSemanticsDebugger: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/scan-only': (context) =>  Scan(name: 'test'),
          '/play': (context) => PlayScreen(),
          '/mode': (context) => ModeScreen(),
          '/scan': (context) => ScanScreen(),
          '/coins': (context) => CoinScreen(),
          '/study': (context) => StudyScreen(),
          '/memo-evaluation': (context) => MemoEvaluation(),
          '/quiz-flash-card-alphabet': (context) => QuizFlashCard(),
          '/quiz-flash-card-word': (context) => QuizFlashCard(nogesture: false, word: true,),
          '/alpahbet-word': (context) => AlphabetWord(),
          '/chat-bot' : (context) => ChatBot(),
        },
      ),
    );
  }
}
