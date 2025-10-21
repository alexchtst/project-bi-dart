import 'package:flutter/material.dart';
import 'package:syndo/widgets/button/navigation_button.dart';
import 'package:syndo/widgets/quiz/optionword.dart';

class QuizFillinwordboard extends StatelessWidget {
  const QuizFillinwordboard({
    super.key,
    required this.options,
    required this.answerindex,
    required this.questions,
    required this.questImageAnswer,
    required this.questionStatus,
    required this.onAnswerSelected,
    required this.onNext,
  });

  final List<String> options;
  final int answerindex;
  final List<Map<String, dynamic>> questions;
  final String questImageAnswer;
  final bool questionStatus;
  final Function(int userAns, int ans) onAnswerSelected;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final panutan = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: panutan * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: panutan * 0.7,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: panutan * 0.005,
                  spacing: panutan * 0.02,
                  children:
                      questions.map((comp) {
                        final bool isAnswer = comp['isanswer'] ?? false;
                        final String content = comp['content'] ?? '';
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: panutan * 0.02,
                            vertical: panutan * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isAnswer
                                    ? Colors.green
                                    : const Color.fromARGB(255, 245, 157, 41),
                            borderRadius: BorderRadius.circular(panutan * 0.02),
                          ),
                          child: Text(
                            content,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: panutan * 0.025,
                              fontFamily: 'Baloo'
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  QuizOptionWord(
                    optionValue: options[0],
                    answerIndex: answerindex,
                    currentIndex: 0,
                    status: questionStatus,
                    onAnswerSelected: onAnswerSelected,
                  ),
                  SizedBox(width: panutan * 0.025),
                  QuizOptionWord(
                    optionValue: options[1],
                    answerIndex: answerindex,
                    currentIndex: 1,
                    status: questionStatus,
                    onAnswerSelected: onAnswerSelected,
                  ),
                  SizedBox(width: panutan * 0.025),
                  QuizOptionWord(
                    optionValue: options[2],
                    answerIndex: answerindex,
                    currentIndex: 2,
                    status: questionStatus,
                    onAnswerSelected: onAnswerSelected,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        if (questionStatus) NavigationButton(onTap: onNext, isNext: true),
      ],
    );
  }
}
