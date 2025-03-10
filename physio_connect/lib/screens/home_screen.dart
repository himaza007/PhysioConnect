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
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.05).animate(_animationController);
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
