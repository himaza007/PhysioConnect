import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/theme_provider.dart';
import 'screens/home_screen.dart';
import 'screens/pain_monitoring.dart';
import 'screens/first_aid_tutorial.dart';
import 'screens/first_aid_details.dart';
import 'components/settings_screen.dart';

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
                child: const HomeScreen(), transitionType: "fade");

          case '/pain-monitoring':
            return _customPageRoute(
                child: const PainMonitoringPage(),
                transitionType: "slideRight");

          case '/first-aid-tutorials':
            return _customPageRoute(
                child: const FirstAidTutorialScreen(),
                transitionType: "slideLeft");

          case '/first-aid-details':
            return _customPageRoute(
                child: const FirstAidDetailsScreen(title: "First Aid Details"),
                transitionType: "scale");

          case '/settings':
            return _customPageRoute(
                child: const SettingsScreen(), transitionType: "fade");

          default:
            return MaterialPageRoute(builder: (context) => _errorScreen());
        }
      },
    );
  }

  // ✅ Custom Transition Function
  PageRoute _customPageRoute(
      {required Widget child, required String transitionType}) {
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
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          default:
            return child;
        }
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  // ✅ Error Screen for Undefined Routes
  Widget _errorScreen() {
    return const Scaffold(
      body: Center(
        child: Text(
          "Oops! Page not found.",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
