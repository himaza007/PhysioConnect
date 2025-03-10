import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageHelper {
  static const String _keyPainHistory = 'painHistory';

  /// ✅ Loads stored pain history from SharedPreferences.
  static Future<List<Map<String, dynamic>>> loadPainHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? storedData = prefs.getString(_keyPainHistory);

      if (storedData == null || storedData.isEmpty) return [];

      // ✅ Decode JSON safely
      final decodedData = json.decode(storedData);
      if (decodedData is List) {
        return List<Map<String, dynamic>>.from(decodedData);
      } else {
        return []; // Invalid data format
      }
    } catch (e) {
      print("⚠ Error loading pain history: $e");
      return [];
    }
  }

  /// ✅ Saves pain history into SharedPreferences.
  static Future<void> savePainHistory(
      List<Map<String, dynamic>> history) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedData = json.encode(history);
      await prefs.setString(_keyPainHistory, encodedData);
    } catch (e) {
      print("⚠ Error saving pain history: $e");
    }
  }

  /// ✅ Clears all stored pain history.
  static Future<void> clearPainHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyPainHistory);
      print("✅ Pain history cleared.");
    } catch (e) {
      print("⚠ Error clearing pain history: $e");
    }
  }

  /// ✅ Adds a new entry to the pain history.
  static Future<void> addPainEntry(Map<String, dynamic> newEntry) async {
    try {
      List<Map<String, dynamic>> history = await loadPainHistory();
      history.insert(0, newEntry); // Add new entry to the beginning
      await savePainHistory(history);
    } catch (e) {
      print("⚠ Error adding pain entry: $e");
    }
  }
}
