import 'package:flutter/material.dart';
import 'package:syndo/widgets/button/navigation_button.dart';
import 'package:syndo/widgets/card/fillintheblank_level_card.dart';

class FillintheblankLevel extends StatefulWidget {
  const FillintheblankLevel({super.key, required this.word});
  final bool word;

  @override
  State<FillintheblankLevel> createState() =>
      _FillintheblankLevelState();
}

class _FillintheblankLevelState extends State<FillintheblankLevel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fillin.png'),
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
                FillintheblankLevelCard(level: 1, word: widget.word),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                FillintheblankLevelCard(level: 2, word: widget.word),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                FillintheblankLevelCard(level: 3, word: widget.word),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FillintheblankLevelCard(level: 4, word: widget.word),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                FillintheblankLevelCard(level: 5, word: widget.word),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                FillintheblankLevelCard(level: 6, word: widget.word),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
