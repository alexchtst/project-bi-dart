import 'package:flutter/material.dart';
import 'package:syndo/screen/fillintheblank_level.dart';
import 'package:syndo/screen/flash_card_level.dart';

class AlphabetWord extends StatefulWidget {
  const AlphabetWord({super.key, required this.isFillinTheBlank});

  final bool isFillinTheBlank;

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
        child: Column(
          children: [
            Container(
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
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                widget.isFillinTheBlank ? 'LENGKAPI BAGIAN KOSONG' : 'FLASH CARDS',
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (widget.isFillinTheBlank) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => FillintheblankLevel(word: false),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FlashCardLevel(word: false),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    width: MediaQuery.of(context).size.width * 0.28,
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
                          image: AssetImage('assets/images/alphabet-icon.png'),
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
                    if (widget.isFillinTheBlank) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FillintheblankLevel(word: true),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FlashCardLevel(word: true),
                        ),
                      );
                    }
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
          ],
        ),
      ),
    );
  }
}
