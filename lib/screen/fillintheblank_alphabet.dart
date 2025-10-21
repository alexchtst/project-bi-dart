import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syndo/utils/data.dart';
import 'package:syndo/utils/game_data.dart';
import 'package:syndo/widgets/fillin/quizboard.dart';

class FillintheblankAlphabet extends StatefulWidget {
  const FillintheblankAlphabet({super.key, required this.questbundle});
  final List<Map<String, dynamic>> questbundle;

  @override
  State<FillintheblankAlphabet> createState() => _FillintheblankAlphabetState();
}

class _FillintheblankAlphabetState extends State<FillintheblankAlphabet> {
  int counter = 0;
  int currentQuest = 0;
  bool isAnswered = false;
  void updateCounter(int userAns, int ans) {
    if (!isAnswered) {
      if (userAns == ans) {
        counter += 1;
      }
      setState(() {
        isAnswered = true;
      });
    }
  }

  void nextQuestion() {
    if (currentQuest < widget.questbundle.length - 1) {
      setState(() {
        currentQuest += 1;
        isAnswered = false;
      });
    } else {
      setState(() {
        currentQuest += 1;
        isAnswered = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(questionData);
    final bool quizSelesai = currentQuest >= widget.questbundle.length;
    final gameData = Provider.of<GameData>(context);

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.04),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg-fillin.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.35,
              alignment: Alignment.center,

              child:
                  !quizSelesai
                      ? QuizFillinboard(
                        options: widget.questbundle[currentQuest]["options"],
                        answerindex:
                            widget.questbundle[currentQuest]["answerindex"],
                        questImageQuestion:
                            widget
                                .questbundle[currentQuest]["questImageQuestion"],
                        questionText:
                            widget
                                .questbundle[currentQuest]["questionText"],
                        questionStatus: isAnswered,
                        onAnswerSelected: updateCounter,
                        onNext: nextQuestion,
                      )
                      : Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/skor-board.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Skor kamu: ${counter * 10}",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Baloo',
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      counter = 0;
                                      currentQuest = 0;
                                      isAnswered = false;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.002,
                                      ),
                                    ),
                                    child: Text(
                                      "Ulangi Quiz",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Baloo',
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                            0.018,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    gameData.levelUpAlphabetFillin();
                                    gameData.addCoins(counter * 10);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.002,
                                      ),
                                    ),
                                    child: Text(
                                      "Selesai",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Baloo',
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                            0.018,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
