import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syndo/utils/data_service.dart';
import 'package:syndo/widgets/button/navigation_button.dart';
import 'package:syndo/widgets/card/scan_card.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.04,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background0.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20.0),
                    NavigationButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          dataProvider
                              .getCardsByType('scanoption')
                              .map(
                                (item) => ScanCard(
                                  locked: item.isLocked,
                                  imgPath: item.imgPath,
                                  name: item.name,
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
