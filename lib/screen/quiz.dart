import 'package:flutter/material.dart';
import 'package:syndo/widgets/quiz/quizboard.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key, required this.questbundle});
  final List<Map<String, dynamic>> questbundle;

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int counter = 0;
  int currentQuest = 0;
  bool isAnswered = false; // untuk kontrol status soal

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
  @override
  Widget build(BuildContext context) {
    final bool quizSelesai = currentQuest >= widget.questbundle.length;

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
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.35,
              color: const Color.fromARGB(162, 255, 255, 255),
              alignment: Alignment.center,

              child:
                  !quizSelesai
                      ? Quizboard(
                        options: widget.questbundle[currentQuest]["options"],
                        answerindex:
                            widget.questbundle[currentQuest]["answerindex"],
                        questImageQuestion:
                            widget
                                .questbundle[currentQuest]["questImageQuestion"],
                        questImageAnswer:
                            widget
                                .questbundle[currentQuest]["questImageAnswer"],
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
                              ],
                            ),
                          ],
                        ),
                      ),
            ),

            if (!quizSelesai)
              Positioned(
                top: -MediaQuery.of(context).size.width * 0.02,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.001,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 212, 129, 10),
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  child: const Text(
                    'Pilih Arti Kartu Yang Sesuai',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: 'Baloo',
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
