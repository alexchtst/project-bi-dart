import 'package:flutter/material.dart';

class MemoEvaluation extends StatefulWidget {
  const MemoEvaluation({super.key});

  @override
  State<MemoEvaluation> createState() => _MemoEvaluationState();
}

class _MemoEvaluationState extends State<MemoEvaluation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.04),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/memo-evaluation-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/alpahbet-word');
              },
              child: Image.asset('assets/images/evaluation-icon.png'),
            ),
            GestureDetector(
               onTap: () {
                Navigator.pushNamed(context, '/alpahbet-word');
              },
              child: Image.asset('assets/images/memorization-icon.png')
            ),
          ],
        ),
      )
    );
  }
}