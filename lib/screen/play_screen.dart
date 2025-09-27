import 'package:flutter/material.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

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
          children: [
            // coin
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
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/coins');
                        },
                        child: Image(
                          image: AssetImage('assets/images/play-plusicon.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // actifities
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width * 0.5,
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
                        'CHARACTERS',
                        style: TextStyle(
                          fontFamily: 'Baloo',
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.62,
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
                      child: Column(
                        children: [
                          // slider
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                color: const Color.fromARGB(255, 247, 167, 81),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.navigate_before_sharp,
                                  size: 30.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                width: MediaQuery.of(context).size.width * 0.08,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 163, 99, 35),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2,
                                        horizontal: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                          255,
                                          96,
                                          30,
                                          25,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          20.0,
                                        ),
                                      ),
                                      child: Text(
                                        '1',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Baloo',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2,
                                        horizontal: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                          255,
                                          96,
                                          30,
                                          25,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                      ),
                                      child: Text(
                                        '2',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Baloo',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                color: const Color.fromARGB(255, 247, 167, 81),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.navigate_next_sharp,
                                  size: 30.0,
                                ),
                              ),
                            ],
                          ),
                          // content
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 96, 30, 25),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.15,
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.08,
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade400,
                                    ),
                                    child: Text(
                                      'FREE',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'baloo',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 96, 30, 25),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.15,
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.08,
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade400,
                                    ),
                                    child: Text(
                                      'FREE',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'baloo',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 96, 30, 25),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.15,
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.08,
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade400,
                                    ),
                                    child: Text(
                                      'FREE',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'baloo',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 25.0),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8.0),
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.height * 0.594,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/playcard.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
