// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

class FillBlank extends StatefulWidget {
  final String instruction;
  final List<String> words;
  final List<int> blankPositions; // posisi yang harus diisi (0-based index)
  final String? cardIcon;

  const FillBlank({
    super.key,
    required this.instruction,
    required this.words,
    required this.blankPositions,
    this.cardIcon,
  });

  @override
  State<FillBlank> createState() => _FillBlankState();
}

class _FillBlankState extends State<FillBlank> {
  List<TextEditingController> controllers = [];
  List<String> userAnswers = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers for blank positions
    for (int i = 0; i < widget.blankPositions.length; i++) {
      controllers.add(TextEditingController());
      userAnswers.add('');
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

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
            'FILL IN THE BLANK SPACE',
            style: TextStyle(
              fontFamily: 'Chewy',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 88, 81, 161),
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Row(
              children: [
                // Left side with letter boxes
                Expanded(
                  flex: 3,
                  child: _buildWordGrid(),
                ),
                SizedBox(width: 15.0),
                // Right side with card icon
                _buildCardIcon(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWordGrid() {
    List<Widget> rows = [];
    int currentRow = 0;
    int wordsPerRow = 4;
    int blankControllerIndex = 0;

    // Calculate number of rows needed
    int totalRows = (widget.words.length / wordsPerRow).ceil();
    
    for (int row = 0; row < totalRows; row++) {
      List<Widget> rowChildren = [];
      int startIndex = row * wordsPerRow;
      int endIndex = (startIndex + wordsPerRow < widget.words.length) 
          ? startIndex + wordsPerRow 
          : widget.words.length;

      for (int i = startIndex; i < endIndex; i++) {
        bool isBlank = widget.blankPositions.contains(i);
        
        if (isBlank) {
          rowChildren.add(_buildBlankBox(blankControllerIndex));
          blankControllerIndex++;
        } else {
          rowChildren.add(_buildLetterBox(widget.words[i], Colors.yellow.shade300));
        }
      }
      
      rows.add(Row(children: rowChildren));
      if (row < totalRows - 1) {
        rows.add(SizedBox(height: 8.0));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }

  Widget _buildLetterBox(String content, Color backgroundColor, {bool isIcon = false}) {
    return Container(
      width: 25,
      height: 25,
      margin: EdgeInsets.only(right: 2.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: Colors.orange.shade700,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Center(
        child: Text(
          content,
          style: TextStyle(
            fontSize: isIcon ? 12 : 14,
            fontWeight: FontWeight.bold,
            color: isIcon ? Colors.red : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildBlankBox(int controllerIndex) {
    return Container(
      width: 25,
      height: 25,
      margin: EdgeInsets.only(right: 2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.red,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextField(
        controller: controllers[controllerIndex],
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        maxLength: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) {
          setState(() {
            userAnswers[controllerIndex] = value.toUpperCase();
          });
        },
      ),
    );
  }

  Widget _buildCardIcon() {
    return Container(
      width: 40,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue.shade300,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.blue.shade600, width: 2),
      ),
      child: Center(
        child: widget.cardIcon != null
            ? Text(
                widget.cardIcon!,
                style: TextStyle(fontSize: 20),
              )
            : Icon(
                Icons.star,
                color: Colors.orange,
                size: 20,
              ),
      ),
    );
  }

  // Method to get user answers
  List<String> getUserAnswers() {
    return userAnswers;
  }

  // Method to check if answers are correct
  bool checkAnswers(List<String> correctAnswers) {
    if (correctAnswers.length != userAnswers.length) return false;
    
    for (int i = 0; i < correctAnswers.length; i++) {
      if (userAnswers[i].toUpperCase() != correctAnswers[i].toUpperCase()) {
        return false;
      }
    }
    return true;
  }
}

// Contoh penggunaan lain:
/*
FillBlank(
  instruction: 'Fill the missing letters',
  words: ['C', 'A', 'T', 'S'], 
  blankPositions: [0, 2], // C dan T harus diisi
  cardIcon: '🐱',
)

FillBlank(
  instruction: 'Complete the word',
  words: ['H', 'E', 'L', 'L', 'O'],
  blankPositions: [1, 3], // E dan L harus diisi
)
*/