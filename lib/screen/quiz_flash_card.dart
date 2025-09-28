import 'package:flutter/material.dart';
import 'package:syndo/screen/flash_card.dart';
import 'package:syndo/screen/gesture_recognition.dart';
import 'package:syndo/widgets/card/scanner_card.dart';

class FillBlank extends StatelessWidget {
  const FillBlank({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.19,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FILL IN THE BLANK SPACE',
            style: TextStyle(
              fontFamily: 'Chewy',
              fontSize: MediaQuery.of(context).size.width * 0.025,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 88, 81, 161),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.005),
          Image.asset(
            'assets/images/fillin-blanks.png',
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width * 0.25,
          ),
        ],
      ),
    );
  }
}

class QuizFlashCard extends StatefulWidget {
  const QuizFlashCard({super.key, this.nogesture = false, this.word = false});

  final bool nogesture;
  final bool word;

  @override
  State<QuizFlashCard> createState() => _QuizFlashCardState();
}

class _QuizFlashCardState extends State<QuizFlashCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.04),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/quiz-flash-card-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [FlashCardComp(word: widget.word,), FillBlank()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (!widget.nogesture) const GestureRecognition(),
                ScannerCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
