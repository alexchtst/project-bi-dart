import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

// ============================================
// 1. MODEL CLASS
// ============================================

class DataCard {
  final String type;
  final String name;
  final bool isLocked;
  final String imgPath;

  DataCard({
    required this.type,
    required this.name,
    required this.isLocked,
    required this.imgPath,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'isLocked': isLocked,
      'imgPath': imgPath,
    };
  }

  // Create from JSON
  factory DataCard.fromJson(Map<String, dynamic> json) {
    return DataCard(
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      isLocked: json['isLocked'] ?? false,
      imgPath: json['imgPath'] ?? '',
    );
  }

  // Create copy with modified fields
  DataCard copyWith({
    String? type,
    String? name,
    bool? isLocked,
    String? imgPath,
  }) {
    return DataCard(
      type: type ?? this.type,
      name: name ?? this.name,
      isLocked: isLocked ?? this.isLocked,
      imgPath: imgPath ?? this.imgPath,
    );
  }

  @override
  String toString() {
    return 'DataCard{type: $type, name: $name, isLocked: $isLocked}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DataCard &&
        other.type == type &&
        other.name == name &&
        other.isLocked == isLocked;
  }

  @override
  int get hashCode => type.hashCode ^ name.hashCode ^ isLocked.hashCode;
}

// ============================================
// 2. PERSISTENCE SERVICE
// ============================================

class PersistenceService {
  static const String _studyCardsKey = 'study_cards';

  static SharedPreferences? _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Save study cards
  static Future<bool> saveStudyCards(List<DataCard> cards) async {
    try {
      await init();
      List<Map<String, dynamic>> jsonList =
          cards.map((card) => card.toJson()).toList();
      String jsonString = jsonEncode(jsonList);
      return await _prefs!.setString(_studyCardsKey, jsonString);
    } catch (e) {
      print('Error saving study cards: $e');
      return false;
    }
  }

  // Load study cards
  static Future<List<DataCard>> loadStudyCards() async {
    try {
      await init();
      String? jsonString = _prefs!.getString(_studyCardsKey);

      if (jsonString == null) return [];

      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => DataCard.fromJson(json)).toList();
    } catch (e) {
      print('Error loading study cards: $e');
      return [];
    }
  }

  // Save single key-value
  static Future<bool> saveString(String key, String value) async {
    await init();
    return await _prefs!.setString(key, value);
  }

  // Get single string value
  static Future<String?> getString(String key) async {
    await init();
    return _prefs!.getString(key);
  }

  // Save boolean
  static Future<bool> saveBool(String key, bool value) async {
    await init();
    return await _prefs!.setBool(key, value);
  }

  // Get boolean
  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    await init();
    return _prefs!.getBool(key) ?? defaultValue;
  }

  // Clear all data
  static Future<bool> clearAll() async {
    await init();
    return await _prefs!.clear();
  }

  // Remove specific key
  static Future<bool> remove(String key) async {
    await init();
    return await _prefs!.remove(key);
  }
}

// ============================================
// 3. PROVIDER CLASS
// ============================================

class DataProvider extends ChangeNotifier {
  List<DataCard> _studyCards = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<DataCard> get studyCards => List.unmodifiable(_studyCards);
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get locked cards count
  int get lockedCardsCount => _studyCards.where((card) => card.isLocked).length;

  // Get unlocked cards count
  int get unlockedCardsCount =>
      _studyCards.where((card) => !card.isLocked).length;

  // Get cards by type
  List<DataCard> getCardsByType(String type) {
    return _studyCards.where((card) => card.type == type).toList();
  }

  // Initialize and load data
  Future<void> init() async {
    await loadStudyCards();
  }

  // Load study cards from persistence
  Future<void> loadStudyCards() async {
    _setLoading(true);
    _setError(null);

    try {
      _studyCards = await PersistenceService.loadStudyCards();

      // If no data exists, initialize with default data
      if (_studyCards.isEmpty) {
        await _initializeDefaultData();
      }
    } catch (e) {
      _setError('Failed to load study cards: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Initialize with default data
  Future<void> _initializeDefaultData() async {
    _studyCards = [
      DataCard(
        type: "scanoption",
        name: "Sumatera",
        isLocked: true,
        imgPath: 'assets/images/sumatera.png',
      ),
      DataCard(
        type: "scanoption",
        name: "Bali",
        isLocked: false,
        imgPath: 'assets/images/bali.png',
      ),
      DataCard(
        type: "scanoption",
        name: "Jawa",
        isLocked: false,
        imgPath: 'assets/images/jawa.png',
      ),
      DataCard(
        type: "studyoption",
        name: "BERKULINER",
        isLocked: false,
        imgPath: 'assets/images/berkuliner.png',
      ),
      DataCard(
        type: "studyoption",
        name: "BERWISATA",
        isLocked: false,
        imgPath: 'assets/images/berwisata.png',
      ),
      DataCard(
        type: "studyoption",
        name: "BERMAIN",
        isLocked: false,
        imgPath: 'assets/images/bermain.png',
      ),
      DataCard(
        type: "studyoption",
        name: "BERSOSIAL",
        isLocked: true,
        imgPath: 'assets/images/bersosial.png',
      ),
      DataCard(
        type: "studyoption",
        name: "SEKOLAH",
        isLocked: true,
        imgPath: 'assets/images/bersekolah.png',
      ),
    ];

    await _saveToStorage();
  }

  // Add new study card
  Future<void> addStudyCard(DataCard card) async {
    _setLoading(true);
    _setError(null);

    try {
      // Check if card with same name already exists
      bool exists = _studyCards.any(
        (existingCard) => existingCard.name == card.name,
      );

      if (exists) {
        _setError('Study card with name "${card.name}" already exists');
        return;
      }

      _studyCards.add(card);
      await _saveToStorage();
    } catch (e) {
      _setError('Failed to add study card: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Update study card
  Future<void> updateStudyCard(int index, DataCard updatedCard) async {
    if (index < 0 || index >= _studyCards.length) {
      _setError('Invalid index for updating study card');
      return;
    }

    _setLoading(true);
    _setError(null);

    try {
      _studyCards[index] = updatedCard;
      await _saveToStorage();
    } catch (e) {
      _setError('Failed to update study card: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Toggle lock status
  Future<void> toggleLock(int index) async {
    if (index < 0 || index >= _studyCards.length) {
      _setError('Invalid index for toggling lock');
      return;
    }

    try {
      DataCard card = _studyCards[index];
      DataCard updatedCard = card.copyWith(isLocked: !card.isLocked);
      await updateStudyCard(index, updatedCard);
    } catch (e) {
      _setError('Failed to toggle lock: $e');
    }
  }

  // Unlock card by name
  Future<bool> unlockCard(String name) async {
    try {
      int index = _studyCards.indexWhere((card) => card.name == name);

      if (index != -1 && _studyCards[index].isLocked) {
        DataCard updatedCard = _studyCards[index].copyWith(isLocked: false);
        await updateStudyCard(index, updatedCard);
        notifyListeners(); // Pastikan UI ter-update
        return true; // Berhasil unlock
      } else if (index != -1 && !_studyCards[index].isLocked) {
        // Card ditemukan tapi sudah unlocked
        return false;
      } else {
        // Card tidak ditemukan
        return false;
      }
    } catch (e) {
      _setError('Failed to unlock card: $e');
      return false;
    }
  }

  // Remove study card
  Future<void> removeStudyCard(int index) async {
    if (index < 0 || index >= _studyCards.length) {
      _setError('Invalid index for removing study card');
      return;
    }

    _setLoading(true);
    _setError(null);

    try {
      _studyCards.removeAt(index);
      await _saveToStorage();
    } catch (e) {
      _setError('Failed to remove study card: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Clear all study cards
  Future<void> clearAllCards() async {
    _setLoading(true);
    _setError(null);

    try {
      _studyCards.clear();
      await _saveToStorage();
    } catch (e) {
      _setError('Failed to clear all cards: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Reset to default data
  Future<void> resetToDefault() async {
    _setLoading(true);
    _setError(null);

    try {
      _studyCards.clear();
      await _initializeDefaultData();
    } catch (e) {
      _setError('Failed to reset to default: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Save to storage
  Future<void> _saveToStorage() async {
    bool success = await PersistenceService.saveStudyCards(_studyCards);
    if (!success) {
      throw Exception('Failed to save to storage');
    }
    notifyListeners();
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error state
  void _setError(String? error) {
    _error = error;
    if (error != null) {
      notifyListeners();
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
