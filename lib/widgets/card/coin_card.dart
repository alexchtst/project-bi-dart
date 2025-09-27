import 'package:flutter/material.dart';

class CoinCard extends StatefulWidget {
  const CoinCard({super.key, this.amount = 15});
  final int amount;

  @override
  State<CoinCard> createState() => _CoinCardState();
}

class _CoinCardState extends State<CoinCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // card title
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.2,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 22, 110, 212),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(2),
              bottomRight: Radius.circular(2),
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Text(
            widget.amount.toString(),
            style: TextStyle(
              fontFamily: 'Baloo',
              fontSize: 25.0,
              color: Colors.white,
            ),
          ),
        ),
        // card coins image
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.4,
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/buycoinbackground.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Image(
            image: AssetImage(
               widget.amount == 15
                ? 'assets/images/fiftycentcoins.png'
                : widget.amount == 65
                ? 'assets/images/sixtfivecoins.png'
                : widget.amount == 150
                ? 'assets/images/hunandfiftycoins.png'
                : widget.amount == 300
                ? 'assets/images/threehundcoins.png'
                : 'assets/images/threehundcoins.png',
              
            ),
            fit: BoxFit.scaleDown,
          ),
        ),
        // card coins value
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.2,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 154, 229, 73),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
              topLeft: Radius.circular(2),
              topRight: Radius.circular(2),
            ),
          ),
          child: Text(
            widget.amount == 15
                ? 'FREE'
                : widget.amount == 65
                ? 'RP. 7.000'
                : widget.amount == 150
                ? 'RP. 15.000'
                : widget.amount == 300
                ? 'RP. 25.000'
                : 'RP. -',
            style: TextStyle(
              fontFamily: 'Baloo',
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
