import 'package:flutter/material.dart';
import 'dart:math';

class RadarScan extends StatefulWidget {
  @override
  _RadarScanState createState() => _RadarScanState();
}

class _RadarScanState extends State<RadarScan>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();

    _rotationAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.teal.withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 5,
          )
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: CustomPaint(painter: _RadarPainter()),
                );
              },
            ),
          ),
          Icon(Icons.local_hospital, size: 40, color: Colors.redAccent),
        ],
      ),
    );
  }
}

// ✅ Custom Radar Painter
class _RadarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.tealAccent.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    double radius = size.width / 2;
    canvas.drawCircle(Offset(radius, radius), radius, paint);
    paint.color = Colors.tealAccent.withOpacity(0.6);
    canvas.drawCircle(Offset(radius, radius), radius * 0.75, paint);
    paint.color = Colors.tealAccent.withOpacity(0.8);
    canvas.drawCircle(Offset(radius, radius), radius * 0.5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
