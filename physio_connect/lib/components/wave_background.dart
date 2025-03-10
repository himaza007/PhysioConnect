import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WaveBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "lib/assets/animations/waves_background.json",
      fit: BoxFit.cover,
      alignment: Alignment.bottomCenter,
    );
  }
}
