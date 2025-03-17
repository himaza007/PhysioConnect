import 'package:flutter/material.dart';

class PainSlider extends StatelessWidget {
  final double painLevel;
  final ValueChanged<double> onPainLevelChanged;

  const PainSlider({
    Key? key,
    required this.painLevel,
    required this.onPainLevelChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 8,
        thumbColor: Colors.black,
        overlayColor: Colors.black.withOpacity(0.2),
        activeTrackColor: Colors.redAccent,
        inactiveTrackColor: Colors.grey.shade300,
      ),
      child: Slider(
        min: 0,
        max: 10,
        divisions: 10,
        value: painLevel,
        onChanged: onPainLevelChanged,
      ),
    );
  }
}
