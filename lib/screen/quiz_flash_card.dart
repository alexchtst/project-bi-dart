import 'package:flutter/material.dart';
import 'package:syndo/screen/flash_card.dart';
import 'package:syndo/screen/gesture_recognition.dart';
import 'package:syndo/screen/fillintheblank_level.dart';
import 'package:syndo/widgets/button/navigation_button.dart';
import 'package:syndo/widgets/card/scanner_card.dart';

class FillBlank extends StatelessWidget {
  const FillBlank({super.key, required this.word});
  final bool word;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FillintheblankLevel(word: word),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.19,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.001,
                horizontal: MediaQuery.of(context).size.width * 0.005,
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
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                'FILL IN THE BLANK SPACE',
                style: TextStyle(
                  fontFamily: 'Chewy',
                  fontSize: MediaQuery.of(context).size.width * 0.025,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
      ),
    );
  }
}

class QuizFlashCard extends StatefulWidget {
  const QuizFlashCard({
    super.key,
    this.nogesture = false,
    this.word = false,
    required this.isStudyMode,
  });

  final bool nogesture;
  final bool word;
  final bool isStudyMode;

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
            if (widget.isStudyMode)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (widget.isStudyMode) FlashCardComp(word: widget.word),
                  if (widget.isStudyMode) FillBlank(word: widget.word),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (widget.isStudyMode) GestureRecognition(),
                ScannerCard(isParentmemo: !widget.isStudyMode),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
