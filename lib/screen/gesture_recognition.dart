import 'package:flutter/material.dart';

// gesture recognition
class GestureRecognition extends StatelessWidget {
  const GestureRecognition({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.19,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GESTURE RECOGNITION',
            style: TextStyle(
              fontFamily: 'Chewy',
              fontSize: MediaQuery.of(context).size.width * 0.025,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 88, 81, 161),
            ),
          ),
          SizedBox(height: 2.0),
          Image.asset(
            'assets/images/gesture-detection.png',
            fit: BoxFit.fitHeight,
            height: MediaQuery.of(context).size.width * 0.08,
          ),
        ],
      ),
    );
  }
}
