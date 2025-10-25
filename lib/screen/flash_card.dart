import 'package:flutter/material.dart';
import 'package:syndo/screen/alphabet_word.dart';
import 'package:syndo/screen/flash_card_level.dart';

// flash card
class FlashCardComp extends StatelessWidget {
  const FlashCardComp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.19,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlphabetWord(isFillinTheBlank: false),
            ),
          );
        },
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
                'FLASHCARD',
                style: TextStyle(
                  fontFamily: 'Chewy',
                  fontSize: MediaQuery.of(context).size.width * 0.025,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.005),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/flashcard1.png',
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                Image.asset(
                  'assets/images/flashcard2.png',
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                Image.asset(
                  'assets/images/flashcard3.png',
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                Image.asset(
                  'assets/images/flashcard4.png',
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
