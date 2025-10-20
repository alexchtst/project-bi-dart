// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:syndo/screen/scan_flash_card.dart';

class ScannerCard extends StatelessWidget {
  const ScannerCard({super.key});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          // ganti bagian ini menjadi 
          MaterialPageRoute(builder: (context) => ScanFlashCard(name: 'SCAN-CARD-TEST')),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.19,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/scanner-card-1.png',
              fit: BoxFit.fitHeight,
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.005),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SCANNER KARTU',
                  style: TextStyle(
                    fontFamily: 'Chewy',
                    fontSize: MediaQuery.of(context).size.width * 0.025,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 88, 81, 161),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.005),
                Image.asset(
                  'assets/images/scanner-card-2.png',
                  fit: BoxFit.fitHeight,
                  height: MediaQuery.of(context).size.width * 0.06,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
