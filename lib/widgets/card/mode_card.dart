import 'package:flutter/material.dart';

class ModeCard extends StatefulWidget {
  const ModeCard({super.key, this.mode = 'study', required this.onTap});

  final String mode;
  final VoidCallback onTap;

  @override
  State<ModeCard> createState() => _ModeCardState();
}

class _ModeCardState extends State<ModeCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // background
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            width: MediaQuery.of(context).size.width * 0.32,
            height: MediaQuery.of(context).size.width * 0.32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: const Color.fromARGB(179, 255, 255, 255),
            ),
            child: Image(
              image:
                  widget.mode.toString().toUpperCase() == 'STUDY'
                      ? AssetImage('assets/images/studymodepict.png')
                      : AssetImage('assets/images/storymodepict.png'),
            ),
          ),
        ),
        Positioned(
          bottom: -20,
          left: MediaQuery.of(context).size.width * 0.06,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.20,
            height: MediaQuery.of(context).size.width * 0.05,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.yellow[700],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${widget.mode.toString().toUpperCase()} MODE',
              style: TextStyle(
                fontFamily: 'Chewy',
                fontSize: 15.0,
                letterSpacing: 1.2,
                color: Color.fromARGB(255, 115, 69, 23),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
