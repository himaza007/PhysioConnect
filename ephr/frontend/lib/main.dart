import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/patient_screen.dart';
import 'screens/record_screen.dart';
import 'screens/assessment_screen.dart';
import 'screens/treatment_screen.dart';

/// Main entry point for the application
void main() {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const Physioconnect_ephr_App());
}

/// Root widget for the healthcare application
// ignore: camel_case_types
class Physioconnect_ephr_App extends StatelessWidget {
  const Physioconnect_ephr_App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Physioconnect EPHR',
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: AppTheme.lightTheme,
      home: const LoginScreen(), // Start with login screen
      // Define routes for navigation
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/patients': (context) => const PatientScreen(),
        '/records': (context) => const RecordScreen(),
        '/assessment': (context) => const AssessmentScreen(),
        '/treatment': (context) => const TreatmentScreen(),
      },
    );
  }
}
