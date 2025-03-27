// File: lib/main.dart
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_page.dart';

void main() {
  runApp(AuthApp());
}

class AuthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth App',
      theme: ThemeData(
        // Primary color (used for buttons, app bars, etc.)
        primaryColor: Color(0xFF33724B), // Midnight Teal
        // Background color for the scaffold
        scaffoldBackgroundColor: Color(0xFFEAF7FF), // Alice Blue
        // Text theme
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            color: Color(0xFF33724B),
          ), // Midnight Teal for titles
          bodyMedium: TextStyle(color: Colors.black87), // Dark text for body
        ),

        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          labelStyle: TextStyle(
            color: Color(0xFF33724B),
          ), // Midnight Teal for labels
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF33724B),
            ), // Midnight Teal for focused borders
          ),
        ),

        // Elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF33724B), // Midnight Teal for buttons
            foregroundColor: Colors.white, // White text on buttons
            minimumSize: Size(double.infinity, 50),
          ),
        ),

        // Text button theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(
              0xFF33724B,
            ), // Midnight Teal for text buttons
          ),
        ),
      ),
      debugShowCheckedModeBanner: false, // Hide the debug banner
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
      },
    );
  }
}
