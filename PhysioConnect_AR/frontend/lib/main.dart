// File: lib/main.dart
// Description: Entry point for the PhysioConnect AR application
// Author: PhysioConnect Team
// Date: April 9, 2025

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config/app_colors.dart';
import 'screens/home_screen.dart';
import 'screens/posture_detection_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/exercise_list_screen.dart';
import 'screens/settings_screen.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Run the app
  runApp(const MyApp());
}

/// MyApp is the root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhysioConnect AR',
      theme: _buildTheme(),
      debugShowCheckedModeBanner: false,
      home: const MainNavigationScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/posture': (context) => const PostureDetectionScreen(),
        //        '/exercises': (context) => const ExerciseListScreen(),
        //        '/profile': (context) => const ProfileScreen(),
        //        '/settings': (context) => const SettingsScreen(),
      },
    );
  }

  /// Build the app theme with PhysioConnect colors
  ThemeData _buildTheme() {
    return ThemeData(
      primaryColor: AppColors.midnightTeal,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.midnightTeal,
        primary: AppColors.midnightTeal,
        secondary: AppColors.aliceBlue,
        surface: AppColors.white,
        background: AppColors.backgroundPrimary,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.backgroundPrimary,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.midnightTeal,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.midnightTeal,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.midnightTeal),
      ),
      cardTheme: CardTheme(
        color: AppColors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.textPrimary),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.textPrimary),
        bodySmall: TextStyle(fontSize: 12, color: AppColors.textSecondary),
      ),
    );
  }
}

/// MainNavigationScreen contains the bottom navigation bar and screens
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // List of main screens
  final List<Widget> _screens = const [
    HomeScreen(),
    PostureDetectionScreen(),
    //    ExerciseListScreen(),
    //    ProfileScreen(),
  ];

  // Navigate to a different tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationItem(
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              label: 'Home',
            ),
            BottomNavigationItem(
              icon: Icons.camera_outlined,
              activeIcon: Icons.camera,
              label: 'Posture',
            ),
            BottomNavigationItem(
              icon: Icons.fitness_center_outlined,
              activeIcon: Icons.fitness_center,
              label: 'Exercises',
            ),
            BottomNavigationItem(
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.midnightTeal,
          unselectedItemColor: AppColors.textSecondary,
          backgroundColor: AppColors.white,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

/// Helper class for bottom navigation items
class BottomNavigationItem extends BottomNavigationBarItem {
  const BottomNavigationItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) : super(icon: Icon(icon), activeIcon: Icon(activeIcon), label: label);
}
