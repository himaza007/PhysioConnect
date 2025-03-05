import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageHelper {
  static Future<List<Map<String, dynamic>>> loadPainHistory() async {
