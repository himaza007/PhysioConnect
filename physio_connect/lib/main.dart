import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'interactive_human_body.dart';
=======
import 'package:provider/provider.dart';
import 'components/theme_provider.dart';
import 'components/settings_screen.dart';
import 'models/tutorial_model.dart';
import 'screens/splash_screen.dart'; // ✅ Splash Screen Integrated
import 'screens/home_screen.dart';
import 'screens/pain_monitoring.dart';
import 'screens/first_aid/tutorial_list_screen.dart';
import 'screens/first_aid/tutorial_detail_screen.dart';
import 'screens/first_aid/first_aid_screen.dart';
>>>>>>> dev

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const PhysioConnectApp(),
    ),
  );
}

// ✅ Centralized Route Names
class Routes {
  static const String splash = '/';
  static const String home = '/home';
  static const String painMonitoring = '/pain-monitoring';
  static const String firstAidTabs = '/first-aid-tutorials';
  static const String tutorialCategory = '/tutorial-category';
  static const String tutorialDetail = '/first-aid-details';
  static const String settings = '/settings';
}

class PhysioConnectApp extends StatelessWidget {
  const PhysioConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhysioConnect',
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F6662),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1F6662),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF06130D),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0E3F3F),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1F6662),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      home: InteractiveHumanBody(
        toggleTheme: toggleTheme,
        isDarkMode: isDarkMode,
=======
      title: 'PhysioConnect',
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      initialRoute: Routes.splash,
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return _customPageRoute(
            child: const SplashScreen(), transition: "fade");

      case Routes.home:
        return _customPageRoute(child: const HomeScreen(), transition: "fade");

      case Routes.painMonitoring:
        return _customPageRoute(
            child: const PainMonitoringPage(), transition: "slideRight");

      case Routes.firstAidTabs:
        return _customPageRoute(
            child: const FirstAidScreen(), transition: "slideLeft");

      case Routes.tutorialCategory:
        final data = settings.arguments as Map<String, dynamic>?;
        final category = data?['category'] ?? 'Taping';
        return _customPageRoute(
          child: TutorialListScreen(category: category),
          transition: "slideLeft",
        );

      case Routes.tutorialDetail:
        final tutorial = settings.arguments as TutorialModel?;
        if (tutorial != null) {
          return _customPageRoute(
            child: TutorialDetailScreen(tutorial: tutorial),
            transition: "scale",
          );
        }
        return _errorRoute("Missing tutorial data");

      case Routes.settings:
        return _customPageRoute(
            child: const SettingsScreen(), transition: "fade");

      default:
        return _errorRoute("Oops! Page not found.");
    }
  }

  // ✅ Custom Transitions
  PageRoute _customPageRoute({
    required Widget child,
    required String transition,
  }) {
    return PageRouteBuilder(
      pageBuilder: (_, animation, __) => child,
      transitionsBuilder: (_, animation, __, child) {
        final curved =
            CurvedAnimation(parent: animation, curve: Curves.easeInOut);
        switch (transition) {
          case "fade":
            return FadeTransition(opacity: curved, child: child);
          case "slideRight":
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
                      .animate(curved),
              child: child,
            );
          case "slideLeft":
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                      .animate(curved),
              child: child,
            );
          case "scale":
            return ScaleTransition(scale: curved, child: child);
          default:
            return child;
        }
      },
      transitionDuration: const Duration(milliseconds: 450),
    );
  }

  // ✅ Friendly Fallback UI
  MaterialPageRoute _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline,
                  color: Colors.redAccent, size: 48),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Go Back"),
              ),
            ],
          ),
        ),
>>>>>>> dev
      ),
    );
  }
}
