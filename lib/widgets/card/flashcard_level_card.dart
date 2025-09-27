import 'package:flutter/material.dart';
import 'package:syndo/screen/quiz.dart';
import 'package:syndo/utils/data.dart';

class FlashcardLevelCard extends StatelessWidget {
  const FlashcardLevelCard({super.key, required this.level});

  final String level;

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> questions = questionData.sublist(1, 3);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Quiz(questbundle: questions)),
        );
      },

      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.06,
            ),
            width: MediaQuery.of(context).size.width * 0.18,
            height: MediaQuery.of(context).size.width * 0.12,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 212, 65),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              level,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 56,
                color: Colors.white,
                fontFamily: 'Baloo',
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).size.width * 0.042,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.15,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.009),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 212, 129, 10),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Text(
                'Level',
                textAlign: TextAlign.center,
                style: TextStyle(
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
