import 'package:flutter/material.dart';
import 'package:syndo/screen/flash_card_level.dart';

// flash card
class FlashCardComp extends StatelessWidget {
  const FlashCardComp({super.key});

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
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FlashCardLevel()),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FLASHCARD',
              style: TextStyle(
                fontFamily: 'Chewy',
                fontSize: MediaQuery.of(context).size.width * 0.025,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 88, 81, 161),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.005),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/images/flashcard1.png',
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Image.asset(
                  'assets/images/flashcard2.png',
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Image.asset(
                  'assets/images/flashcard3.png',
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Image.asset(
                  'assets/images/flashcard4.png',
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
