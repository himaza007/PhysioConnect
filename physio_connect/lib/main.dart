import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/pain_monitoring.dart';
import 'screens/first_aid_tutorial.dart';

void main() {
  runApp(PhysioConnectApp());
}

class PhysioConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PhysioConnect',

      // ✅ Light Theme
      theme: ThemeData(
        primaryColor: Color(0xFF33724B),
        scaffoldBackgroundColor: Color(0xFFEAF7FF),
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
          bodyLarge: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
          labelLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF33724B),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),

      // ✅ Dark Theme (for future updates)
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF1F1F1F),
        scaffoldBackgroundColor: Color(0xFF121212),
      ),

      // ✅ Route Management
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/pain-monitoring': (context) => PainMonitoringPage(),
        '/tutorials': (context) => TutorialScreen(),
      },
    );
  }
}
