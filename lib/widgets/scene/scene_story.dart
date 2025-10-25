import 'package:flutter/material.dart';

class DialogField extends StatelessWidget {
  final String actor;
  final String dialog;
  final String target;
  final VoidCallback onNext;

  const DialogField({
    super.key,
    required this.actor,
    required this.dialog,
    required this.target,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final panutan = MediaQuery.of(context).size.width;
    return Positioned(
      bottom: 0,
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
              height: panutan * 0.035,
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
            child: InkWell(
              onTap: onNext,
              child: SizedBox(
                width: panutan * 0.52,
                height: panutan * 0.09,
                child: Column(
                  children: [
                    Text(
                      dialog,
                      style: TextStyle(
                        fontSize: panutan * 0.02,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    if (target.isNotEmpty)
                      Text(
                        'tebak: $target',
                        style: TextStyle(
                          fontSize: panutan * 0.02,
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.start,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActorHeader extends StatelessWidget {
  final String arinImgPath;
  final String gielImgPath;
  final String showImageArin;
  final String showImageGiel;
  final bool isAnswered;

  const ActorHeader({
    super.key,
    this.arinImgPath = "",
    this.gielImgPath = "",
    this.showImageArin = "",
    this.showImageGiel = "",
    required this.isAnswered,
  });

  Widget buildImage(String imagePath, double width) {
    if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
      return Image.network(
        imagePath,
        fit: BoxFit.contain,
        width: width,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, color: Colors.red);
        },
      );
    } else {
      return Image.asset(
        imagePath,
        fit: BoxFit.contain,
        width: width,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, color: Colors.red);
        },
      );
    }
  }

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
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Positioned(
                  child: Image.asset(
                    arinImgPath,
                    width: screenWidth * 0.40,
                    fit: BoxFit.contain,
                  ),
                ),
                if (showImageArin.isNotEmpty && isAnswered)
                  Positioned(
                    left: screenWidth * 0.18,
                    top: screenWidth * 0.012,
                    child: buildImage(showImageArin, screenWidth * 0.15),
                  )
                else
                  const SizedBox(width: 0),
              ],
            )
          else
            const SizedBox(width: 0),

          if (gielImgPath.isNotEmpty)
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Positioned(
                  child: Image.asset(
                    gielImgPath,
                    width: screenWidth * 0.40,
                    fit: BoxFit.contain,
                  ),
                ),
                if (showImageGiel.isNotEmpty && isAnswered)
                  Positioned(
                    left: screenWidth * 0.21,
                    top: screenWidth * 0.02,
                    child: buildImage(showImageGiel, screenWidth * 0.15),
                  )
                else
                  const SizedBox(width: 0),
              ],
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
    required this.changeAnswer,
  });

  final String imgPath;
  final bool isAnswer;
  final VoidCallback changeAnswer;

  @override
  State<OptionFromAnswer> createState() => _OptionFromAnswerState();
}

class _OptionFromAnswerState extends State<OptionFromAnswer> {
  bool? checked;
  bool? result;

  void checkResult() {
    setState(() {
      checked = true;
      result = widget.isAnswer;
    });

    Future.delayed(const Duration(seconds: 2), () {
      widget.changeAnswer();
    });
  }

  Widget buildImage(String imagePath) {
    if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
      return Image.network(
        imagePath,
        fit: BoxFit.fill,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, color: Colors.red);
        },
      );
    } else {
      return Image.asset(
        imagePath,
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, color: Colors.red);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final panutan = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: checked == null ? checkResult : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg-pilihan-ganda.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: buildImage(widget.imgPath),
          ),

          if (checked == true)
            Positioned(
              top: 0,
              right: 0,
              child: Icon(
                result == true ? Icons.check_circle : Icons.cancel,
                color: result == true ? Colors.greenAccent : Colors.redAccent,
                size: panutan * 0.05,
              ),
            ),
        ],
      ),
    );
  }
}

class QuestionAnswer extends StatefulWidget {
  const QuestionAnswer({
    super.key,
    required this.quiz,
    required this.changeAnswer,
    required this.isAnswered,
  });
  final List<Map<String, dynamic>> quiz;
  final VoidCallback changeAnswer;
  final bool isAnswered;

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
                  changeAnswer: widget.changeAnswer,
                );
              }).toList(),
        ),
      ),
    );
  }
}

class SceneStory extends StatefulWidget {
  const SceneStory({super.key, required this.scenes});

  final List<Map<String, dynamic>> scenes;

  @override
  State<SceneStory> createState() => _SceneStoryState();
}

class _SceneStoryState extends State<SceneStory> {
  int currentScene = 0;
  bool isAnswered = false;

  void nextScene() {
    if (currentScene < widget.scenes.length - 1) {
      setState(() {
        currentScene++;
        isAnswered = false;
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Cerita selesai 🎉")));
    }
  }

  void handleChangeIsAnswered() {
    setState(() {
      isAnswered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ActorHeader(
          arinImgPath: widget.scenes[currentScene]['arinImg'],
          gielImgPath: widget.scenes[currentScene]['gielImg'],
          showImageArin: widget.scenes[currentScene]['showImageArin'],
          showImageGiel: widget.scenes[currentScene]['showImageGiel'],
          isAnswered: isAnswered,
        ),
        if (!isAnswered &&
            (widget.scenes[currentScene]["quiz"] as List).isNotEmpty)
          QuestionAnswer(
            changeAnswer: handleChangeIsAnswered,
            isAnswered: isAnswered,
            quiz:
                (widget.scenes[currentScene]["quiz"] as List)
                    .cast<Map<String, dynamic>>(),
          ),
        DialogField(
          actor: widget.scenes[currentScene]['actor'],
          dialog: widget.scenes[currentScene]['dialog'],
          target: widget.scenes[currentScene]['target'],
          onNext: nextScene,
        ),
      ],
    );
  }
}
