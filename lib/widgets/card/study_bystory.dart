import 'package:flutter/material.dart';
import 'package:syndo/utils/data.dart';
import 'package:syndo/utils/helper.dart';
import 'package:syndo/widgets/scene/scene_story.dart';

class StudyBystory extends StatefulWidget {
  const StudyBystory({super.key, required this.name});

  final String name;

  @override
  State<StudyBystory> createState() => _StudyBystoryState();
}

class _StudyBystoryState extends State<StudyBystory> {
  @override
  Widget build(BuildContext context) {
    final imageBgPath = helperGetImageStudyPath(widget.name);

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageBgPath),
            fit: BoxFit.cover,
          ),
        ),
        child: SceneStory(storyScenes: storyPasarScenes,),
      )
    );
  }
}