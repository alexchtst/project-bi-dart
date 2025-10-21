import 'package:flutter/material.dart';

class SkinReview extends StatefulWidget {
  const SkinReview({super.key, required this.imgPath});
  final String imgPath;

  @override
  State<SkinReview> createState() => _SkinReviewState();
}

class _SkinReviewState extends State<SkinReview> {
  final List<String> backgrounds = [
    'assets/images/bg-bali-char.png',
    'assets/images/bg-batak-char.png',
    'assets/images/bg-jawa-char.png',
  ];

  String selectedBackground = 'assets/images/bg-bali-char.png';

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/playbackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  backgrounds.map((bg) {
                    bool isSelected = selectedBackground == bg;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedBackground = bg;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                isSelected ? Colors.yellow : Colors.transparent,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(bg, width: screenWidth * 0.18),
                      ),
                    );
                  }).toList(),
            ),

            const SizedBox(width: 20),

            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.yellow,
                  width: 10,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      selectedBackground,
                      fit: BoxFit.contain,
                      width: screenWidth * 0.6,
                    ),

                    Image.asset(
                      widget.imgPath,
                      fit: BoxFit.contain,
                      height: screenWidth * 0.30,
                    ),

                    Icon(
                      Icons.center_focus_weak_sharp,
                      color: Colors.white,
                      size: screenWidth * 0.1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
