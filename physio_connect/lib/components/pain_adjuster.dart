import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';

class PainAdjuster extends StatefulWidget {
  final double painLevel;
  final Function(double) onPainLevelChanged;

  const PainAdjuster(
      {Key? key, required this.painLevel, required this.onPainLevelChanged})
      : super(key: key);

  @override
  _PainAdjusterState createState() => _PainAdjusterState();
}

class _PainAdjusterState extends State<PainAdjuster> {
  final AudioPlayer _player = AudioPlayer();

  void _updatePainLevel(double value) {
    widget.onPainLevelChanged(value);
    _playSound();
    _vibrate();
  }

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Adjust Pain Level",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 10),
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(colors: [Colors.teal, Colors.green]),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 10, offset: Offset(2, 4))
            ],
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                left: ((widget.painLevel - 1) / 9) *
                    (MediaQuery.of(context).size.width - 60),
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    double newLevel = ((details.localPosition.dx /
                                (MediaQuery.of(context).size.width - 50)) *
                            9) +
                        1;
                    if (newLevel >= 1 && newLevel <= 10) {
                      _updatePainLevel(newLevel);
                    }
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(2, 4))
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "${widget.painLevel.toInt()}",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
