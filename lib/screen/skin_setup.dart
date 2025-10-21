import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syndo/screen/skin_review.dart';
import 'package:syndo/utils/char_data.dart';
import 'package:syndo/utils/game_data.dart';

class CharacterComponent extends StatelessWidget {
  const CharacterComponent({
    super.key,
    required this.name,
    required this.imgPath,
    required this.price,
    required this.lockStatus,
    required this.onTap,
  });

  final String name;
  final String imgPath;
  final int price;
  final bool lockStatus;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: size * 0.15,
            height: size * 0.20,
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(size * 0.01),
              image: DecorationImage(
                image: AssetImage(imgPath),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),

          // 🔒 Overlay lock
          if (lockStatus)
            Container(
              width: size * 0.15,
              height: size * 0.20,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(size * 0.01),
              ),
              child: Center(
                child: Text(
                  'LOCKED',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Baloo',
                    fontSize: size * 0.015,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final List<Map<String, dynamic>> charactersData;
  final Function(Map<String, dynamic>) onCharacterTap;

  const Content({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onPrevious,
    required this.charactersData,
    required this.onCharacterTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.center,
      width: size * 0.5,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 250, 206, 84),
            Color.fromARGB(255, 250, 158, 12),
          ],
        ),
      ),
      child: Column(
        children: [
          // 🔹 Pagination bar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: onPrevious,
                child: Icon(
                  Icons.navigate_before_rounded,
                  color: Colors.brown[900],
                  size: size * 0.05,
                ),
              ),
              Row(
                children: List.generate(totalPages, (index) {
                  final pageNumber = index + 1;
                  final isActive = pageNumber == currentPage;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: size * 0.01),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: size * 0.006,
                        horizontal: size * 0.015,
                      ),
                      decoration: BoxDecoration(
                        color: isActive ? Colors.brown[600] : Colors.brown[300],
                        borderRadius: BorderRadius.circular(size * 0.015),
                      ),
                      child: Text(
                        "$pageNumber",
                        style: const TextStyle(
                          fontFamily: 'Baloo',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              InkWell(
                onTap: onNext,
                child: Icon(
                  Icons.navigate_next_rounded,
                  color: Colors.brown[900],
                  size: size * 0.05,
                ),
              ),
            ],
          ),

          // 🔹 Character list
          Padding(
            padding: EdgeInsets.all(size * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  charactersData.map((element) {
                    return CharacterComponent(
                      imgPath:
                          element['imgPath'] ?? "assets/images/arin-bali.png",
                      lockStatus: element['isLock'] ?? true,
                      name: element['name'] ?? 'arin-bali',
                      price: element['price'] ?? 100,
                      onTap: () => onCharacterTap(element),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class SkinSetup extends StatefulWidget {
  const SkinSetup({super.key});

  @override
  State<SkinSetup> createState() => _SkinSetupState();
}

class _SkinSetupState extends State<SkinSetup> {
  int currentPage = 1;
  int itemsPerPage = 3;
  Map<String, dynamic>? selectedCharacter;

  void nextPage(int totalPages) {
    if (currentPage < totalPages) {
      setState(() => currentPage++);
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      setState(() => currentPage--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameData = Provider.of<GameData>(context);
    final charData = Provider.of<CharacterProvider>(context);

    final int balance = gameData.coinBalance;
    final List<Map<String, dynamic>> characters = charData.characters;

    // 🔹 Pagination logic
    final totalPages = (characters.length / itemsPerPage).ceil();
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex =
        (startIndex + itemsPerPage < characters.length)
            ? startIndex + itemsPerPage
            : characters.length;

    final currentCharacters = characters.sublist(startIndex, endIndex);
    final panutan = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/playbackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔸 Coin Balance
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/coins'),
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
                        Image.asset('assets/images/play-coinicon.png'),
                        Text(
                          '$balance',
                          style: const TextStyle(
                            fontFamily: 'Baloo',
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        Image.asset('assets/images/play-plusicon.png'),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: panutan * 0.02),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.062,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 255, 204, 62),
                              Color.fromARGB(255, 250, 158, 12),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: const Text(
                          'Characters',
                          style: TextStyle(
                            fontFamily: 'Baloo',
                            fontSize: 32.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: panutan * 0.02),

                      Content(
                        charactersData: currentCharacters,
                        currentPage: currentPage,
                        totalPages: totalPages,
                        onNext: () => nextPage(totalPages),
                        onPrevious: previousPage,
                        onCharacterTap: (char) {
                          setState(() {
                            selectedCharacter = char;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                // 🔸 Selected preview
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Skin',
                          style: const TextStyle(
                            fontFamily: 'Baloo',
                            fontSize: 26,
                            color: Colors.white,
                          ),
                        ),
                        if (selectedCharacter != null)
                          if (selectedCharacter!['isLock'] == false)
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => SkinReview(
                                          imgPath:
                                              selectedCharacter!['imgPath'],
                                        ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  selectedCharacter!['imgPath'],
                                  height: panutan * 0.3,
                                ),
                              ),
                            )
                          else
                            const Text(
                              'Character belom terbuka',
                              style: TextStyle(
                                fontFamily: 'Baloo',
                                fontSize: 18,
                                color: Colors.white70,
                              ),
                            )
                        else
                          const Text(
                            'Pilih karakter',
                            style: TextStyle(
                              fontFamily: 'Baloo',
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                          ),
                      ],
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
