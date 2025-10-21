import 'package:flutter/material.dart';
import 'package:syndo/widgets/button/navigation_button.dart';
import 'package:syndo/widgets/fillin/option.dart';

class QuizFillinboard extends StatelessWidget {
  const QuizFillinboard({
    super.key,
    required this.options,
    required this.answerindex,
    required this.questImageQuestion,
    required this.questionText,
    required this.questionStatus,
    required this.onAnswerSelected,
    required this.onNext,
  });

  final List<String> options;
  final int answerindex;
  final String questImageQuestion;
  final String questionText;
  final bool questionStatus;
  final Function(int userAns, int ans) onAnswerSelected;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    print(options);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/fillin-bebek.png",
          height: MediaQuery.of(context).size.width * 0.25,
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 212, 129, 10),
                borderRadius: BorderRadius.circular(10.0),
              ),

              child: Text(
                questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: 'Baloo',
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                QuizFillinOption(
                  optionValue: options[0],
                  answerIndex: answerindex,
                  currentIndex: 0,
                  status: questionStatus,
                  onAnswerSelected: onAnswerSelected,
                ),
                const SizedBox(width: 5),
                QuizFillinOption(
                  optionValue: options[1],
                  answerIndex: answerindex,
                  currentIndex: 1,
                  status: questionStatus,
                  onAnswerSelected: onAnswerSelected,
                ),
                const SizedBox(width: 10),
                QuizFillinOption(
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
        const SizedBox(width: 10),
        if (questionStatus) NavigationButton(onTap: onNext, isNext: true),
      ],
    );
  }
}
