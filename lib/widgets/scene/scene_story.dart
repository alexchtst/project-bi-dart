import 'package:flutter/material.dart';
import 'package:syndo/utils/data.dart';

class DialogField extends StatelessWidget {
  final String actor;
  final String dialog;
  final VoidCallback onNext;

  const DialogField({
    super.key,
    required this.actor,
    required this.dialog,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final panutan = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onNext,
      child: Positioned(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/story-mode-dialog.png',
              width: panutan,
              fit: BoxFit.contain,
            ),
            Positioned(
              bottom: panutan * 0.132,
              left: panutan * 0.26,
              child: SizedBox(
                width: panutan * 0.135,
                height: panutan * 0.028,
                child: Text(
                  actor,
                  style: TextStyle(
                    fontSize: panutan * 0.02,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Positioned(
              bottom: panutan * 0.03,
              child: SizedBox(
                width: panutan * 0.52,
                height: panutan * 0.09,
                child: Text(
                  dialog,
                  style: TextStyle(
                    fontSize: panutan * 0.02,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActorHeader extends StatelessWidget {
  final String arinImgPath;
  final String gielImgPath;

  const ActorHeader({super.key, this.arinImgPath = "", this.gielImgPath = ""});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.transparent,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (arinImgPath.isNotEmpty)
            Image.asset(
              arinImgPath,
              width: screenWidth * 0.40,
              fit: BoxFit.contain,
            )
          else
            const SizedBox(width: 0),

          if (gielImgPath.isNotEmpty)
            Image.asset(
              gielImgPath,
              width: screenWidth * 0.35,
              fit: BoxFit.contain,
            )
          else
            const SizedBox(width: 0),
        ],
      ),
    );
  }
}

class OptionFromAnswer extends StatefulWidget {
  const OptionFromAnswer({
    super.key,
    required this.imgPath,
    required this.isAnswer,
  });

  final String imgPath;
  final bool isAnswer;

  @override
  State<OptionFromAnswer> createState() => _OptionFromAnswerState();
}

class _OptionFromAnswerState extends State<OptionFromAnswer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg-pilihan-ganda.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Image.asset(
        widget.imgPath,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

class QuestionAnswer extends StatefulWidget {
  const QuestionAnswer({super.key, required this.quiz});
  final List<Map<String, dynamic>> quiz;

  @override
  State<QuestionAnswer> createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer> {
  @override
  Widget build(BuildContext context) {
    final panutan = MediaQuery.of(context).size.width;

    return Positioned(
      top: panutan * 0.05,
      left: panutan * 0.1,
      right: panutan * 0.1,
      child: Container(
        padding: const EdgeInsets.all(12),
        height: panutan * 0.2,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              widget.quiz.map((item) {
                return OptionFromAnswer(
                  imgPath: item["image"],
                  isAnswer: item["ans"],
                );
              }).toList(),
        ),
      ),
    );
  }
}

class SceneStory extends StatefulWidget {
  const SceneStory({super.key, required this.storyScenes});

  final List<Map<String, dynamic>> storyScenes;

  @override
  State<SceneStory> createState() => _SceneStoryState();
}

class _SceneStoryState extends State<SceneStory> {
  int currentScene = 0;
  final scenes = storyPasarScenes;
  void nextScene() {
    if (currentScene < scenes.length - 1) {
      setState(() {
        currentScene++;
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Cerita selesai 🎉")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ActorHeader(
          arinImgPath: scenes[currentScene]['arinImg'],
          gielImgPath: scenes[currentScene]['gielImg'],
        ),
        QuestionAnswer(
          quiz:
              (scenes[currentScene]["quiz"] as List)
                  .cast<Map<String, dynamic>>(),
        ),
        DialogField(
          actor: scenes[currentScene]['actor'],
          dialog: scenes[currentScene]['dialog'],
          onNext: nextScene,
        ),
      ],
    );
  }
}
