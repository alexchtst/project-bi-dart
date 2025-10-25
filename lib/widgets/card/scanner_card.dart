// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:syndo/screen/scan_flash_card.dart';

class ScannerCard extends StatelessWidget {
  const ScannerCard({super.key, required this.isParentmemo});

  final bool isParentmemo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          // ganti bagian ini menjadi
          MaterialPageRoute(
            builder: (context) => ScanFlashCard(name: 'SCAN-CARD-TEST', isParentmemo: isParentmemo,),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.19,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.001,
                horizontal: MediaQuery.of(context).size.width * 0.005,
              ),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.01,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 204, 62),
                    Color.fromARGB(255, 250, 158, 12),
                  ],
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                'SCANNER KARTU',
                style: TextStyle(
                  fontFamily: 'Chewy',
                  fontSize: MediaQuery.of(context).size.width * 0.025,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/scanner-card-1.png',
                  fit: BoxFit.fitHeight,
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Image.asset(
                  'assets/images/scanner-card-2.png',
                  fit: BoxFit.fitHeight,
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
