import 'package:flutter/material.dart';

class GameData extends ChangeNotifier {
  int _coinBalance = 0;
  int _quizLevelAlphabet = 1;
  int _quizLevelWord = 1;
  int _quizLevelGeneral = 1;

  int get coinBalance => _coinBalance;
  int get quizLevelAlphabet => _quizLevelAlphabet;
  int get quizLevelWord => _quizLevelWord;
  int get quizLevelGeneral => _quizLevelGeneral;

  set coinBalance(int value) {
    _coinBalance = value;
    notifyListeners();
  }

  set quizLevelAlphabet(int value) {
    _quizLevelAlphabet = value;
    notifyListeners();
  }

  set quizLevelWord(int value) {
    _quizLevelWord = value;
    notifyListeners();
  }

  set quizLevelGeneral(int value) {
    _quizLevelGeneral = value;
    notifyListeners();
  }

  // ===== Coin Management =====
  void addCoins(int amount) {
    _coinBalance += amount;
    notifyListeners();
  }

  void subtractCoins(int amount) {
    if (_coinBalance - amount >= 0) {
      _coinBalance -= amount;
      notifyListeners();
    }
  }

  // ===== Level Management =====
  void levelUpAlphabet() {
    _quizLevelAlphabet++;
    notifyListeners();
  }

  void levelUpWord() {
    _quizLevelWord++;
    notifyListeners();
  }

  void levelUpGeneral() {
    _quizLevelGeneral++;
    notifyListeners();
  }

  void resetAlphabetLevel() {
    _quizLevelAlphabet = 1;
    notifyListeners();
  }

  void resetWordLevel() {
    _quizLevelWord = 1;
    notifyListeners();
  }

  void resetGeneralLevel() {
    _quizLevelGeneral = 1;
    notifyListeners();
  }

  // ===== Reset All Data =====
  void resetAll() {
    _coinBalance = 0;
    _quizLevelAlphabet = 1;
    _quizLevelWord = 1;
    _quizLevelGeneral = 1;
    notifyListeners();
  }
}
