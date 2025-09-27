import 'package:flutter/material.dart';

class QuizOption extends StatefulWidget {
  const QuizOption({
    super.key,
    required this.optionValue,
    required this.currentIndex,
    required this.answerIndex,
    required this.status,
    required this.onAnswerSelected,
  });

  final String optionValue;
  final int currentIndex;
  final int answerIndex;
  final bool status;
  final Function(int userAns, int ans) onAnswerSelected;

  @override
  State<QuizOption> createState() => _QuizOptionState();
}

class _QuizOptionState extends State<QuizOption> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            widget.onAnswerSelected(widget.currentIndex, widget.answerIndex);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.12,
            height: MediaQuery.of(context).size.width * 0.12,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 212, 65),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              widget.optionValue,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.white,
                fontFamily: 'Baloo',
              ),
            ),
          ),
        ),
        if (widget.status && widget.currentIndex == widget.answerIndex)
          Positioned(
            top: -MediaQuery.of(context).size.width * 0.01,
            left: -MediaQuery.of(context).size.width * 0.015,
            child: Icon(
              Icons.check_circle,
              color: Colors.green,
              size: MediaQuery.of(context).size.width * 0.05,
            ),
          ),
        if (widget.status && widget.currentIndex == widget.answerIndex)
          Positioned(
            top: -MediaQuery.of(context).size.width * 0.01,
            left: -MediaQuery.of(context).size.width * 0.015,
            child: Icon(
              Icons.check_circle,
              color: Colors.green,
              size: MediaQuery.of(context).size.width * 0.05,
            ),
          ),
      ],
    );
  }
}
