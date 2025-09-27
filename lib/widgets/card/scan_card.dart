// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:syndo/screen/scan.dart';

class ScanCard extends StatefulWidget {
  const ScanCard({
    super.key,
    required this.locked,
    required this.imgPath,
    required this.name,
  });

  final bool locked;
  final String imgPath;
  final String name;

  @override
  State<ScanCard> createState() => _ScanCardState();
}

class _ScanCardState extends State<ScanCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.28,
      height: MediaQuery.of(context).size.width * 0.3,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/study');
            },
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(150, 255, 255, 255),
                borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.02,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(
                    image: AssetImage(widget.imgPath),
                    fit: BoxFit.scaleDown,
                    height: MediaQuery.of(context).size.width * 0.18,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    width: MediaQuery.of(context).size.width * 0.28,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 252, 205, 77),
                          Color.fromARGB(255, 255, 177, 51),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Baloo',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 115, 69, 23),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Overlay if locked
          if (widget.locked)
            Positioned(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scan(name: widget.name.toString()),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.28,
                  height: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(123, 0, 0, 0),
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.02,
                    ),
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.08,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 10.0,
                          ),
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.09,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFC107), Color(0xFFFF9800)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(122, 255, 153, 0),
                                offset: Offset(2, 4),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: const Text(
                            'SCAN TO\nUNLOCK',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              height: 1.2,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // 🔲 Icon Scan Bulat di Atas
                        Positioned(
                          top: MediaQuery.of(context).size.width * 0.02,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.075,
                            height: MediaQuery.of(context).size.width * 0.075,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Image.asset(
                              'assets/images/scan_icon.png',
                              fit: BoxFit.contain,
                            ),
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
