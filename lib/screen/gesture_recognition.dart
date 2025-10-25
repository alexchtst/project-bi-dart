import 'package:flutter/material.dart';

// gesture recognition
class GestureRecognition extends StatelessWidget {
  const GestureRecognition({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/gesture-detection');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.19,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.001,
                horizontal: MediaQuery.of(context).size.width * 0.005,
              ),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.01,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 204, 62),
                    Color.fromARGB(255, 250, 158, 12),
                  ],
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                'GESTURE RECOGNITION',
                style: TextStyle(
                  fontFamily: 'Chewy',
                  fontSize: MediaQuery.of(context).size.width * 0.025,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 2.0),
            Image.asset(
              'assets/images/gesture-recognition.png',
              fit: BoxFit.fitHeight,
              height: MediaQuery.of(context).size.width * 0.08,
            ),
          ],
        ),
      ),
    );
  }
}
