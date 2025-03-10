import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/storage_helper.dart';

class PainMonitoringPage extends StatefulWidget {
  @override
  _PainMonitoringPageState createState() => _PainMonitoringPageState();
}

class _PainMonitoringPageState extends State<PainMonitoringPage> {
  int _painLevel = 5;
  String _painLocation = '';
  List<Map<String, dynamic>> _painHistory = [];

  final Map<int, String> painReliefSuggestions = {
    1: "Minimal discomfort, rest well! 💆‍♂️",
    3: "Try gentle stretching & hydration. 💧",
    5: "Apply an ice pack and do light movements. ❄️",
    7: "Use heat therapy & consider physiotherapy. 🔥",
    9: "Seek medical advice for persistent pain. 🏥",
    10: "Severe pain detected! Consult a doctor immediately. 🚨",
  };


// pass on
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ Full-Screen Background
      body: Stack(
        children: [
          // ✅ Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF33724B), Color(0xFFEAF7FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // ✅ Animated Overlays
          Positioned(
            top: -100,
            left: -50,
            child: Opacity(
              opacity: 0.3,
              child: Lottie.asset(
                "lib/assets/animations/bubble_animation.json",
                height: 400,
                repeat: true,
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -50,
            child: Opacity(
              opacity: 0.3,
              child: Lottie.asset(
                "lib/assets/animations/bubble_animation.json",
                height: 400,
                repeat: true,
              ),
            ),
          ),

          // ✅ Main Content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ✅ Lottie Animation (Header)
                Lottie.asset(
                  "lib/assets/animations/physio_animation.json",
                  height: 150,
                  fit: BoxFit.cover,
                ),

                SizedBox(height: 20),

                // ✅ Title
                Text(
                  "Welcome to PhysioConnect",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 40),

                // ✅ Interactive Buttons
                _buildAnimatedButton(
                  label: "Pain Monitoring",
                  icon: Icons.favorite,
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  route: "/pain-monitoring",
                ),

                SizedBox(height: 20),

                _buildAnimatedButton(
                  label: "First Aid Tutorials",
                  icon: Icons.local_hospital,
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  route: "/first-aid-tutorials",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Animated Button Widget
  Widget _buildAnimatedButton({
    required String label,
    required IconData icon,
    required Color color,
    required Color textColor,
    required String route,
  }) {
    return MouseRegion(
      onEnter: (_) => _animateButton(true),
      onExit: (_) => _animateButton(false),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(2, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 30, color: textColor),
                SizedBox(width: 10),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

