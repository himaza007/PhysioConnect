import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/theme_provider.dart';
import 'components/settings_screen.dart';
import 'models/tutorial_model.dart';

import 'screens/home_screen.dart';
import 'screens/pain_monitoring.dart';
import 'screens/first_aid/tutorial_list_screen.dart';
import 'screens/first_aid/tutorial_detail_screen.dart';
import 'screens/first_aid/first_aid_screen.dart'; // ✅ Tab view screen

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const PhysioConnectApp(),
    ),
  );
}

class PhysioConnectApp extends StatelessWidget {
  const PhysioConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PhysioConnect',
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return _customPageRoute(
              child: const HomeScreen(),
              transitionType: "fade",
            );

          case '/pain-monitoring':
            return _customPageRoute(
              child: const PainMonitoringPage(),
              transitionType: "slideRight",
            );

          // ✅ FULL TAB SCREEN for Taping / Exercise / Home Remedies
          case '/first-aid-tutorials':
            return _customPageRoute(
              child: const FirstAidScreen(),
              transitionType: "slideLeft",
            );

          // ✅ FILTERED LIST SCREEN with passed category
          case '/tutorial-category':
            final data = settings.arguments as Map<String, dynamic>?;
            final category = data?['category'] ?? 'Home Remedies';
            return _customPageRoute(
              child: TutorialListScreen(category: category),
              transitionType: "slideLeft",
            );

          // ✅ TUTORIAL DETAILS SCREEN
          case '/first-aid-details':
            final tutorial = settings.arguments as TutorialModel?;
            if (tutorial != null) {
              return _customPageRoute(
                child: TutorialDetailScreen(tutorial: tutorial),
                transitionType: "scale",
              );
            }
            return _errorRoute("Missing tutorial data");

          case '/settings':
            return _customPageRoute(
              child: const SettingsScreen(),
              transitionType: "fade",
            );

          default:
            return _errorRoute("Oops! Page not found.");
        }
      },
    );
  }

  // ✅ Custom page transitions
  PageRoute _customPageRoute({
    required Widget child,
    required String transitionType,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transitionType) {
          case "fade":
            return FadeTransition(opacity: animation, child: child);
          case "slideRight":
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
                      .animate(animation),
              child: child,
            );
          case "slideLeft":
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                      .animate(animation),
              child: child,
            );
          case "scale":
            return ScaleTransition(scale: animation, child: child);
          default:
            return child;
        }
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  // ✅ Error fallback route
  MaterialPageRoute _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            message,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
