import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../components/pain_adjuster.dart';
import '../components/pop_up_pain_advice.dart';
import '../screens/pain_history_screen.dart';
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
        const SnackBar(
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

    await StorageHelper.addPainEntry(newEntry);
    await _loadPainHistory(); // Refresh history after saving
  }

  void _updatePainLevel(double value) {
    setState(() {
      _painLevel = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Pain Monitoring',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        elevation: 5,
        actions: [
          if (_painHistory
              .isNotEmpty) // Show history button only if records exist
            IconButton(
              icon: const Icon(Icons.history),
              tooltip: "View Pain History",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PainHistoryScreen(painHistory: _painHistory),
                  ),
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            // ✅ Pain Level Gauge
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF33724B), Color(0xFF1F6662)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: const Offset(3, 5),
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
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 260,
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 1,
                          maximum: 10,
                          startAngle: 180,
                          endAngle: 0,
                          showLabels: true,
                          showTicks: true,
                          labelOffset: 10,
                          axisLineStyle: const AxisLineStyle(
                            thickness: 20,
                            thicknessUnit: GaugeSizeUnit.factor,
                          ),
                          ranges: [
                            GaugeRange(
                              startValue: 1,
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
                              value: _painLevel,
                              enableAnimation: true,
                              animationType: AnimationType.elasticOut,
                              needleColor: Colors.white,
                              needleStartWidth: 2,
                              needleEndWidth: 8,
                              knobStyle: const KnobStyle(
                                color: Colors.white,
                                borderColor: Colors.black,
                                borderWidth: 3,
                              ),
                              tailStyle: const TailStyle(
                                color: Colors.white,
                                width: 5,
                                length: 0.2,
                              ),
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
                                      color: Colors.white,
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

            // ✅ Pain Level Advice
            PopUpPainAdvice(painLevel: _painLevel),

            const SizedBox(height: 20),

            // ✅ Pain Level Adjuster
            PainAdjuster(
              painLevel: _painLevel,
              onPainLevelChanged: _updatePainLevel,
            ),

            const SizedBox(height: 20),

            // ✅ Pain Location Input
            TextField(
              decoration: InputDecoration(
                labelText: "Pain Location",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.location_on, color: Colors.teal),
                filled: true,
                fillColor: Theme.of(context).cardColor,
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
                backgroundColor: Theme.of(context).primaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 25),
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

            // ✅ View Pain History Button
            if (_painHistory.isNotEmpty)
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PainHistoryScreen(painHistory: _painHistory),
                    ),
                  );
                },
                child: const Text(
                  "View Pain History",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
