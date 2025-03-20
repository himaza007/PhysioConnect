import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = _lightTheme;

  static final ThemeData _lightTheme = ThemeData(
    primaryColor: const Color(0xFF33724B),
    scaffoldBackgroundColor: const Color(0xFFEAF7FF),
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF33724B),
      elevation: 5,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1F1F1F),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F1F1F),
      elevation: 5,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme = _currentTheme == _lightTheme ? _darkTheme : _lightTheme;
    notifyListeners();
  }
}
