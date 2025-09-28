import 'package:flutter/material.dart';
import 'package:syndo/widgets/button/navigation_button.dart';
import 'package:syndo/widgets/quiz/optionword.dart';

class Quizwordboard extends StatelessWidget {
  const Quizwordboard({
    super.key,
    required this.options,
    required this.answerindex,
    required this.questImageQuestion,
    required this.questImageAnswer,
    required this.questionStatus,
    required this.onAnswerSelected,
    required this.onNext,
  });

  final List<String> options;
  final int answerindex;
  final String questImageQuestion;
  final String questImageAnswer;
  final bool questionStatus;
  final Function(int userAns, int ans) onAnswerSelected;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          questionStatus ? questImageAnswer : questImageQuestion,
          height: MediaQuery.of(context).size.width * 0.25,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
        Column(
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
            SizedBox(height: MediaQuery.of(context).size.width * 0.012),
            QuizOptionWord(
              optionValue: options[1],
              answerIndex: answerindex,
              currentIndex: 1,
              status: questionStatus,
              onAnswerSelected: onAnswerSelected,
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.012),
            QuizOptionWord(
              optionValue: options[2],
              answerIndex: answerindex,
              currentIndex: 2,
              status: questionStatus,
              onAnswerSelected: onAnswerSelected,
            ),
          ],
        ),
        const SizedBox(width: 50),
        if (questionStatus) NavigationButton(onTap: onNext, isNext: true),
      ],
    );
  }
}
