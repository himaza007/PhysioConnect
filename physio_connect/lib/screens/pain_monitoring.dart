import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../components/pain_adjuster.dart';
import '../components/pop_up_pain_advice.dart';
import '../components/pain_chart.dart';
import '../utils/storage_helper.dart';
import 'package:intl/intl.dart';

class PainMonitoringPage extends StatefulWidget {
  const PainMonitoringPage({super.key});

  @override
  _PainMonitoringPageState createState() => _PainMonitoringPageState();
}

class _PainMonitoringPageState extends State<PainMonitoringPage> {
  double _painLevel = 5.0;
  String _painLocation = '';
  List<Map<String, dynamic>> _painHistory = [];

  @override
  void initState() {
    super.initState();
    _loadPainHistory();
  }

  Future<void> _loadPainHistory() async {
    final history = await StorageHelper.loadPainHistory();
    setState(() {
      _painHistory = history;
    });
  }

  Future<void> _savePainEntry() async {
    if (_painLocation.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a pain location!"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final newEntry = {
      'date': DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
      'painLevel': _painLevel,
      'painLocation': _painLocation,
    };

    setState(() {
      _painHistory.insert(0, newEntry);
    });

    await StorageHelper.savePainHistory(_painHistory);
  }

  void _updatePainLevel(double value) {
    setState(() {
      _painLevel = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FF), // ✅ Soft background
      appBar: AppBar(
        title: const Text(
          'Pain Monitoring',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF33724B),
        centerTitle: true,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            // ✅ Pain Level Gauge (Enhanced UI)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(3, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Current Pain Level",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
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
                          pointers: <GaugePointer>[
                            NeedlePointer(
                              value: _painLevel,
                              enableAnimation: true,
                              animationType: AnimationType.elasticOut,
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
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              positionFactor: 0.5,
                              angle: 90,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Context-Based Pop-up Advice
            PopUpPainAdvice(painLevel: _painLevel),

            const SizedBox(height: 20),

            // ✅ Pain Level Adjuster (Smooth & Interactive)
            PainAdjuster(
              painLevel: _painLevel,
              onPainLevelChanged: _updatePainLevel,
            ),

            const SizedBox(height: 20),

            // ✅ Pain Location Input Field
            TextField(
              decoration: InputDecoration(
                labelText: "Pain Location",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                _painLocation = value;
              },
            ),

            const SizedBox(height: 20),

            // ✅ Save Entry Button
            ElevatedButton.icon(
              onPressed: _savePainEntry,
              icon: const Icon(Icons.save, color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF33724B),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              label: const Text(
                'Save Entry',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Chart Displaying Pain Trends
            Expanded(
              child: PainChart(painHistory: _painHistory),
            ),
          ],
        ),
      ),
    );
  }
}
