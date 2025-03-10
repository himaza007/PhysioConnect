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