import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugePainIndicator extends StatelessWidget {
  final double painLevel; // 🟢 Dynamic pain level input

  const GaugePainIndicator({Key? key, required this.painLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Pain Level: ${painLevel.toInt()}",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 15),

        // ✅ Gauge UI (Modern & Enhanced)
        SizedBox(
          height: 220, // Adjusted for better visibility
          child: SfRadialGauge(
            axes: [
              RadialAxis(
                minimum: 0,
                maximum: 10,
                interval: 1,
                startAngle: 180, // ✅ Better semicircle view
                endAngle: 0,
                showLabels: true,
                showTicks: true,
                axisLineStyle: AxisLineStyle(
                  thickness: 15,
                  color: Colors.grey.shade300, // Background for contrast
                ),
                ranges: [
                  GaugeRange(startValue: 0, endValue: 3, color: Colors.green),
                  GaugeRange(startValue: 3, endValue: 7, color: Colors.orange),
                  GaugeRange(startValue: 7, endValue: 10, color: Colors.red),
                ],
                pointers: [
                  NeedlePointer(
                    value: painLevel,
                    enableAnimation: true,
                    animationType: AnimationType.ease, // ✅ Smooth animation
                    needleColor: Colors.black,
                    knobStyle: KnobStyle(
                      color: Colors.black,
                      borderColor: Colors.white,
                      borderWidth: 3,
                    ),
                    tailStyle: TailStyle(
                      color: Colors.black,
                      width: 5,
                      length: 0.2,
                    ),
                    needleEndWidth: 6,
                  ),
                ],
                annotations: [
                  GaugeAnnotation(
                    widget: Text(
                      "${painLevel.toInt()}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    angle: 90,
                    positionFactor: 0.6,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
