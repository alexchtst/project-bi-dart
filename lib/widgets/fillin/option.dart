import 'package:flutter/material.dart';

class QuizFillinOption extends StatefulWidget {
  const QuizFillinOption({
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
  State<QuizFillinOption> createState() => _QuizFillinOptionState();
}

class _QuizFillinOptionState extends State<QuizFillinOption> {
  
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
            width: MediaQuery.of(context).size.width * 0.15,
            alignment: Alignment.center,
            child: Image.asset(
              widget.optionValue,
              fit: BoxFit.fill,
            ),
          ),
        ),
        if (widget.status && widget.currentIndex == widget.answerIndex)
          Positioned(
            top: -MediaQuery.of(context).size.width * 0.01,
            left: -MediaQuery.of(context).size.width * 0.005,
            child: Icon(
              Icons.check_circle,
              color: Colors.green,
              size: MediaQuery.of(context).size.width * 0.05,
            ),
          ),
        if (widget.status && widget.currentIndex != widget.answerIndex)
          Positioned(
            top: -MediaQuery.of(context).size.width * 0.01,
            left: -MediaQuery.of(context).size.width * 0.005,
            child: Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
              size: MediaQuery.of(context).size.width * 0.05,
            ),
          ),
      ],
    );
  }
}
