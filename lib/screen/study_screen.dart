import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syndo/widgets/card/study_card.dart';
import 'package:syndo/utils/data_service.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/study-background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.antiAlias,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children:
                    dataProvider
                        .getCardsByType('studyoption')
                        .map(
                          (item) => StudyCard(
                            locked: item.isLocked,
                            imagePath: item.imgPath,
                            title: item.name,
                          ),
                        )
                        .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
