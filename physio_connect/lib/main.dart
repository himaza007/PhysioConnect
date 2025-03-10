import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/pain_monitoring.dart';
import 'screens/first_aid_tutorial.dart';
import 'screens/first_aid_details.dart';

void main() {
  runApp(PhysioConnectApp());
}

class PhysioConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PhysioConnect',

      // ✅ Elegant Light Theme
      theme: ThemeData(
        primaryColor: Color(0xFF33724B),
        scaffoldBackgroundColor: Color(0xFFEAF7FF),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF33724B),
          elevation: 5,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F4B3D),
            shadows: [
              Shadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ],
          ),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
          labelLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF33724B),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),

      // ✅ Stylish Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF1F1F1F),
        scaffoldBackgroundColor: Color(0xFF121212),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          elevation: 5,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
          labelLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),

      // ✅ Route Management
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return _customPageRoute(
                child: HomeScreen(), transitionType: "fade");

          case '/pain-monitoring':
            return _customPageRoute(
                child: PainMonitoringPage(), transitionType: "slideRight");

          case '/first-aid-tutorials':
            return _customPageRoute(
                child: FirstAidTutorialScreen(), transitionType: "slideLeft");

          case '/first-aid-details':
            return _customPageRoute(
                child: FirstAidDetailsScreen(title: "First Aid Details"),
                transitionType: "scale");

          default:
            return MaterialPageRoute(
              builder: (context) => _errorScreen(),
            );
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
              position: Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
                  .animate(animation),
              child: child,
            );
          case "slideLeft":
            return SlideTransition(
              position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
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
      transitionDuration: Duration(milliseconds: 500),
    );
  }

  // ✅ Error Screen for Undefined Routes
  Widget _errorScreen() {
    return Scaffold(
      body: Center(
        child: Text(
          "Oops! Page not found.",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
