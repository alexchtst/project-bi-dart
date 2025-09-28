import 'package:flutter/material.dart';
import 'package:syndo/widgets/button/navigation_button.dart';
import 'package:syndo/widgets/card/flashcard_level_card.dart';

class FlashCardLevel extends StatefulWidget {
  const FlashCardLevel({super.key, this.word = true});

  final bool word;

  @override
  State<FlashCardLevel> createState() => _FlashCardLevelState();
}

class _FlashCardLevelState extends State<FlashCardLevel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/flashcard-bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 30.0),
                NavigationButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlashcardLevelCard(level: "1", word: widget.word,),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                FlashcardLevelCard(level: "2", word: widget.word,),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                FlashcardLevelCard(level: "3", word: widget.word,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlashcardLevelCard(level: "4", word: widget.word,),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                FlashcardLevelCard(level: "5", word: widget.word,),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                FlashcardLevelCard(level: "6", word: widget.word,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
