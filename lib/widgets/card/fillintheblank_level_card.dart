import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syndo/screen/fillintheblank_alphabet.dart';
import 'package:syndo/screen/fillintheblank_word.dart';
import 'package:syndo/utils/data.dart';
import 'package:syndo/utils/game_data.dart';

class FillintheblankLevelCard extends StatelessWidget {
  const FillintheblankLevelCard({
    super.key,
    required this.level,
    required this.word,
  });

  final int level;
  final bool word;

  @override
  Widget build(BuildContext context) {
    final gameData = Provider.of<GameData>(context);
    final int currentLevel = level;
    final int playerLevel =
        word
            ? gameData.fillintheblankWordLevel
            : gameData.fillintheblankAlphabetLevel;

    final bool unlocked = currentLevel <= playerLevel;

    final int start = (level - 1) * 4;

    int safeEnd(int start, int length) {
      if (start >= length) return length;
      return (start + 4 <= length) ? start + 4 : length;
    }

    final int endForQuestionData = safeEnd(start, questionFillinData.length);
    final int endForQuestionWordData = safeEnd(start, questionFillinWordData.length);

    // Ambil sublist secara aman
    final List<Map<String, dynamic>> questions =
        (start < questionData.length)
            ? questionFillinData
            : [];

    final List<Map<String, dynamic>> questionwords =
        (start < questionWordData.length)
            ? questionFillinWordData
            : [];

    return InkWell(
      onTap:
          unlocked
              ? () {
                if (word) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => FillintheblankWord(questbundle: questionwords),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FillintheblankAlphabet(questbundle: questions),
                    ),
                  );
                }
              }
              : null, // disable tap kalau belum terbuka
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Opacity(
            opacity: unlocked ? 1.0 : 0.4,
            child: Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.06,
              ),
              width: MediaQuery.of(context).size.width * 0.18,
              height: MediaQuery.of(context).size.width * 0.12,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    unlocked
                        ? const Color.fromARGB(255, 255, 212, 65)
                        : Colors.grey,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                '$level',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 56,
                  color: Colors.white,
                  fontFamily: 'Baloo',
                ),
              ),
            ),
          ),

          // Label Level
          Positioned(
            top: MediaQuery.of(context).size.width * 0.042,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.15,
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.009,
              ),
              decoration: BoxDecoration(
                color:
                    unlocked
                        ? const Color.fromARGB(255, 212, 129, 10)
                        : Colors.grey.shade700,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                unlocked ? 'Level' : 'Terkunci',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'Baloo',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
