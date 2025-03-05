import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageHelper {
  static Future<List<Map<String, dynamic>>> loadPainHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? storedData = prefs.getString('painHistory');
    return storedData != null
        ? List<Map<String, dynamic>>.from(json.decode(storedData))
        : [];
  }