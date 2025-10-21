import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CharacterProvider with ChangeNotifier {
  static const String _storageKey = 'character_data';

  List<Map<String, dynamic>> _characters = [
    {
      "imgPath": "assets/images/arin-bali.png",
      "isLock": false,
      "price": 0,
      "name": "arin-bali",
    },
    {
      "imgPath": "assets/images/arin-batak.png",
      "isLock": true,
      "price": 10,
      "name": "arin-batak",
    },
    {
      "imgPath": "assets/images/arin-dayak.png",
      "isLock": true,
      "price": 10,
      "name": "arin-dayak",
    },
    {
      "imgPath": "assets/images/arin-jawa.png",
      "isLock": true,
      "price": 10,
      "name": "arin-jawa",
    },
    {
      "imgPath": "assets/images/giel-bali.png",
      "isLock": false,
      "price": 0,
      "name": "giel-bali",
    },
    {
      "imgPath": "assets/images/giel-jawa.png",
      "isLock": true,
      "price": 10,
      "name": "giel-jawa",
    },
  ];

  List<Map<String, dynamic>> get characters => _characters;

  Future<void> loadCharacters() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString(_storageKey);

    if (storedData != null) {
      final List<dynamic> decoded = jsonDecode(storedData);
      _characters =
          decoded.map((item) => Map<String, dynamic>.from(item)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveCharacters() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(_characters));
  }

  Future<void> unlockCharacter(String name) async {
    for (var char in _characters) {
      if (char['name'] == name) {
        char['isLock'] = false;
        break;
      }
    }
    await _saveCharacters();
    notifyListeners();
  }

  Future<void> unlockCharacterByPrice(String name, int balance) async {
    for (var char in _characters) {
      if (char['name'] == name) {
        if (char['price'] <= balance) {
          char['isLock'] = false;
        }
        break;
      }
    }
    await _saveCharacters();
    notifyListeners();
  }

  Future<void> resetCharacters() async {
    _characters = [
      {
        "imgPath": "assets/images/arin-bali.png",
        "isLock": false,
        "price": 0,
        "name": "arin-bali",
      },
      {
        "imgPath": "assets/images/arin-batak.png",
        "isLock": true,
        "price": 100,
        "name": "arin-batak",
      },
      {
        "imgPath": "assets/images/arin-dayak.png",
        "isLock": true,
        "price": 100,
        "name": "arin-dayak",
      },
      {
        "imgPath": "assets/images/arin-jawa.png",
        "isLock": true,
        "price": 100,
        "name": "arin-jawa",
      },
      {
        "imgPath": "assets/images/giel-bali.png",
        "isLock": false,
        "price": 0,
        "name": "giel-bali",
      },
      {
        "imgPath": "assets/images/giel-jawa.png",
        "isLock": true,
        "price": 100,
        "name": "giel-jawa",
      },
    ];
    await _saveCharacters();
    notifyListeners();
  }
}
