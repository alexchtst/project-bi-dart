import 'package:flutter/material.dart';
import 'package:syndo/screen/scan.dart';

class StudyCard extends StatelessWidget {
  const StudyCard({
    super.key,
    required this.imagePath,
    required this.title,
    this.locked = false,
  });

  final String imagePath;
  final String title;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.32,
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(imagePath.toString(), fit: BoxFit.fitWidth),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  padding: EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    title.toString(),
                    style: TextStyle(
                      fontFamily: 'Chewy',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Overlay if locked
          if (locked)
            Positioned(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scan(name: title.toString()),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.32,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(123, 0, 0, 0),
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.02,
                    ),
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          child: Icon(
                            Icons.lock,
                            color: Colors.red.shade200,
                            size: MediaQuery.of(context).size.width * 0.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
