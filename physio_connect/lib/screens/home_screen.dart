import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // ✅ Smooth Button Scale Animation
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animateButton(bool isHovered) {
    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // ✅ Gradient Background for Elegant UI
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF33724B), Color(0xFFEAF7FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ✅ Centered Lottie Animation (Header)
                Lottie.asset(
                  "lib/assets/animations/physio_animation.json",
                  height: 180,
                  fit: BoxFit.cover,
                ),

                SizedBox(height: 30),

                // ✅ Elegant Welcome Text
                Text(
                  "Welcome to PhysioConnect",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        color: Colors.black38,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 50),

                // ✅ Interactive Buttons (Centered)
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

  // ✅ Enhanced Animated Button with Smooth Scaling
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
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 30),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(3, 6),
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
                    fontSize: 19,
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
