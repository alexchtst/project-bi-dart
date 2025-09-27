import 'package:flutter/material.dart';
import 'package:syndo/widgets/card/mode_card.dart';

class ModeScreen extends StatefulWidget {
  const ModeScreen({super.key});

  @override
  State<ModeScreen> createState() => _ModeScreenState();
}

class _ModeScreenState extends State<ModeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/optionbackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              ModeCard(
                mode: 'STUDY',
                onTap: () {
                  Navigator.pushNamed(context, '/memo-evaluation');
                },
              ),
              ModeCard(
                mode: 'STORY',
                onTap: () {
                  Navigator.pushNamed(context, '/scan');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
