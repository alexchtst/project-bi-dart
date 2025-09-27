import 'package:flutter/material.dart';

class AlphabetWord extends StatefulWidget {
  const AlphabetWord({super.key});

  @override
  State<AlphabetWord> createState() => _AlphabetWordState();
}

class _AlphabetWordState extends State<AlphabetWord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.04),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/alphabet-words-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/quiz-flash-card-alphabet');
              },
              child: Container(
                padding: EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width * 0.35,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(172, 255, 255, 255),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      image: AssetImage('assets/images/word-icon.png'),
                      fit: BoxFit.fill,
                    ),
                    Text(
                      'ALPHABET',
                      style: TextStyle(
                        fontFamily: 'Chewy',
                        fontSize: 25,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/quiz-flash-card-word');
              },
              child: Container(
                padding: EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width * 0.35,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(172, 255, 255, 255),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      image: AssetImage('assets/images/word-icon.png'),
                      fit: BoxFit.fill,
                    ),
                    Text(
                      'KATA',
                      style: TextStyle(
                        fontFamily: 'Chewy',
                        fontSize: 25,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
