import 'package:flutter/material.dart';
import 'package:syndo/widgets/card/coin_card.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen({super.key});

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/playbackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // coins
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.18,
                  height: MediaQuery.of(context).size.width * 0.05,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 49, 57, 97),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage('assets/images/play-coinicon.png'),
                        fit: BoxFit.cover,
                      ),
                      Text(
                        '0',
                        style: TextStyle(
                          fontFamily: 'Baloo',
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      Image(
                        image: AssetImage('assets/images/play-plusicon.png'),
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            // actifities
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // titile
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.062,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 255, 204, 62),
                          Color.fromARGB(255, 250, 158, 12),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Text(
                      'COIN',
                      style: TextStyle(
                        fontFamily: 'Baloo',
                        fontSize: 32.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CoinCard(amount: 15),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      CoinCard(amount: 65),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      CoinCard(amount: 150),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      CoinCard(amount: 300),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
