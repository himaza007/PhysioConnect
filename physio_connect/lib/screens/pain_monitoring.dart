import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class PainMonitorAdjuster extends StatefulWidget {
  @override
  _PainMonitorAdjusterState createState() => _PainMonitorAdjusterState();
}

class _PainMonitorAdjusterState extends State<PainMonitorAdjuster> {
  double _painLevel = 5.0; // 🔥 Default pain level
  final AudioPlayer _player = AudioPlayer();

  final Map<int, String> _painDescriptions = {
    1: "Minimal discomfort, just relax! 💆‍♂️",
    3: "Try gentle stretching & hydration. 💧",
    5: "Apply an ice pack and move lightly. ❄️",
    7: "Use heat therapy & consider physiotherapy. 🔥",
    9: "Seek medical advice for persistent pain. 🏥",
    10: "Severe pain detected! Consult a doctor immediately. 🚨",
  };

  void _playSound() async {
    try {
      await _player.play(AssetSource("sounds/click_sound.mp3"));
    } catch (e) {
      print("Error playing sound: $e");
    }
  }

  void _vibrate() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    }
  }

  void _updatePainLevel(double value) {
    setState(() {
      _painLevel = value;
      _playSound();
      _vibrate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FF), // ✅ Soft gradient background
      appBar: AppBar(
        title: const Text('Pain Level Adjuster',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF33724B),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ Modern Gauge (Syncs with Adjuster)
            SizedBox(
              height: 250,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 1,
                    maximum: 10,
                    startAngle: 180,
                    endAngle: 0,
                    axisLineStyle: AxisLineStyle(
                      thickness: 20,
                      gradient: const SweepGradient(
                        colors: [Colors.green, Colors.yellow, Colors.red],
                      ),
                    ),
                    ranges: [
                      GaugeRange(
                          startValue: 1, endValue: 3, color: Colors.green),
                      GaugeRange(
                          startValue: 4, endValue: 6, color: Colors.yellow),
                      GaugeRange(
                          startValue: 7, endValue: 10, color: Colors.red),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        value: _painLevel,
                        enableAnimation: true,
                        animationType:
                            AnimationType.elasticOut, // ✅ Smooth effect
                        needleColor: Colors.black,
                        knobStyle: const KnobStyle(
                          color: Colors.black,
                          borderColor: Colors.white,
                          borderWidth: 3,
                        ),
                        tailStyle: const TailStyle(
                          color: Colors.black,
                          width: 5,
                          length: 0.2,
                        ),
                        needleEndWidth: 6,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.favorite,
                                color: Colors.redAccent, size: 40),
                            Text(
                              "${_painLevel.toInt()}",
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        positionFactor: 0.5,
                        angle: 90,
                      )
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ✅ Context-Based Pain Level Pop-up
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Text(
                _painDescriptions.entries
                    .firstWhere((entry) => _painLevel <= entry.key,
                        orElse: () => const MapEntry(
                            10, "Consult a doctor immediately. 🚨"))
                    .value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Mac-Style Linear Adjuster
            Column(
              children: [
                const Text(
                  "Adjust Pain Level",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 15),

                // ✅ Custom Adjuster UI
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade300, Colors.teal.shade800],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 200),
                        left: (_painLevel - 1) /
                            9 *
                            (MediaQuery.of(context).size.width - 60),
                        child: GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            double newLevel = ((details.localPosition.dx /
                                        (MediaQuery.of(context).size.width -
                                            50)) *
                                    9) +
                                1;
                            if (newLevel >= 1 && newLevel <= 10) {
                              _updatePainLevel(newLevel);
                            }
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: const Offset(2, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "${_painLevel.toInt()}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
