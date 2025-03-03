import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _buttonScale = 1.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateButton(bool isHovering) {
    setState(() {
      _buttonScale = isHovering ? 1.05 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ✅ Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF33724B), Color(0xFF1F4B3D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // ✅ Animated Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ✅ Lottie Animation (Header Animation)
                Lottie.asset(
                  "assets/animations/physio_animation.json",
                  height: 180,
                  fit: BoxFit.cover,
                ),

                SizedBox(height: 20),

                // ✅ Interactive Feature Buttons
                _buildAnimatedButton(
                  label: "Pain Monitoring",
                  icon: Icons.favorite,
                  color: Color(0xFFEAF7FF),
                  textColor: Colors.black,
                  route: "/pain-monitoring",
                ),
                SizedBox(height: 20),
                _buildAnimatedButton(
                  label: "One-Tap Emergency",
                  icon: Icons.warning_amber_rounded,
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  route: "/emergency-contact",
                ),
                SizedBox(height: 20),
                _buildAnimatedButton(
                  label: "Kinesiology Tutorials",
                  icon: Icons.play_circle_fill,
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  route: "/tutorials",
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
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transform: Matrix4.diagonal3Values(_buttonScale, _buttonScale, 1),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(2, 4),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
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
                    color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
