import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syndo/utils/game_data.dart';

class SkinSetup extends StatefulWidget {
  const SkinSetup({super.key});

  @override
  State<SkinSetup> createState() => _SkinSetupState();
}

class _SkinSetupState extends State<SkinSetup> {
  @override
  Widget build(BuildContext context) {
    final gameData = Provider.of<GameData>(context);
    final int balance = gameData.coinBalance;

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
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/coins');
                  },
                  child: Container(
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
                          '$balance',
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
                      'Craharacters',
                      style: TextStyle(
                        fontFamily: 'Baloo',
                        fontSize: 32.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
