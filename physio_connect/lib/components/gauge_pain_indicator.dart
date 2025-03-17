import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugePainIndicator extends StatelessWidget {
  final double painLevel;

  const GaugePainIndicator({Key? key, required this.painLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF33724B), Color(0xFF1F6662)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Pain Level: ${painLevel.toInt()}",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 280,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 10,
                  interval: 1,
                  startAngle: 180,
                  endAngle: 0,
                  showLabels: true,
                  showTicks: true,
                  labelOffset: 15,
                  axisLineStyle: const AxisLineStyle(
                    thickness: 25,
                  ),
                  ranges: [
                    GaugeRange(
                      startValue: 0,
                      endValue: 3,
                      color: Colors.green,
                      startWidth: 25,
                      endWidth: 25,
                    ),
                    GaugeRange(
                      startValue: 3,
                      endValue: 7,
                      color: Colors.yellow,
                      startWidth: 25,
                      endWidth: 25,
                    ),
                    GaugeRange(
                      startValue: 7,
                      endValue: 10,
                      color: Colors.red,
                      startWidth: 25,
                      endWidth: 25,
                    ),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: painLevel,
                      enableAnimation: true,
                      animationType: AnimationType.elasticOut,
                      needleColor: Colors.white,
                      needleStartWidth: 2,
                      needleEndWidth: 8,
                      lengthUnit: GaugeSizeUnit.factor,
                      knobStyle: KnobStyle(
                        color: Colors.white,
                        borderColor: Colors.black,
                        borderWidth: 3,
                      ),
                    ),
                    MarkerPointer(
                      value: painLevel,
                      markerType: MarkerType.triangle,
                      markerWidth: 15,
                      markerHeight: 20,
                      color: Colors.white,
                      offsetUnit: GaugeSizeUnit.factor,
                      markerOffset: 0.85,
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.redAccent.withOpacity(0.8),
                            size: 45,
                          ),
                          Text(
                            "${painLevel.toInt()}",
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      positionFactor: 0.6,
                      angle: 90,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
