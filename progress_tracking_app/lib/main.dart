import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const ProgressTrackingApp());
}

class ProgressTrackingApp extends StatelessWidget {
  const ProgressTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Progress Tracking',
      theme: ThemeData(
        primaryColor: const Color(0xFF33724B),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ProgressTrackingScreen(),
    );
  }
}

class ProgressTrackingScreen extends StatefulWidget {
  const ProgressTrackingScreen({super.key});

  @override
  _ProgressTrackingScreenState createState() => _ProgressTrackingScreenState();
}

class _ProgressTrackingScreenState extends State<ProgressTrackingScreen> {
  final List<double> painLevels = [8, 7, 6, 5, 4, 3, 2, 2, 1, 1];
  final List<String> dates = List.generate(
      10, (index) => DateFormat('MMM dd').format(DateTime.now().subtract(Duration(days: index)))).reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Tracking'),
        backgroundColor: const Color(0xFF33724B),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          
          // Progress Summary
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Your Recovery Progress",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Your pain levels have reduced significantly over time! Keep up the great work with your exercises.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Progress Graph
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(sideTitles: _leftTitles()),
                        bottomTitles: AxisTitles(sideTitles: _bottomTitles()),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: List.generate(
                            painLevels.length,
                            (index) => FlSpot(index.toDouble(), painLevels[index]),
                          ),
                          isCurved: true,
                          color: const Color(0xFF33724B),
                          dotData: const FlDotData(show: true),
                          belowBarData: BarAreaData(show: true, color: Colors.green.withOpacity(0.3)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Summary Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _summaryCard("Avg Pain", "3.2", Icons.healing),
                _summaryCard("Best Day", "Pain Level 1", Icons.thumb_up),
                _summaryCard("Last Updated", "Today", Icons.calendar_today),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Summary Card Widget
  Widget _summaryCard(String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Icon(icon, color: const Color(0xFF33724B), size: 28),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  // Y-Axis (Pain Levels)
  SideTitles _leftTitles() {
    return SideTitles(
      showTitles: true,
      interval: 2,
      getTitlesWidget: (value, meta) {
        return Text(value.toInt().toString(), style: const TextStyle(fontSize: 12));
      },
    );
  }

  // X-Axis (Dates)
  SideTitles _bottomTitles() {
    return SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        if (value < 0 || value >= dates.length) return Container();
        return Text(dates[value.toInt()], style: const TextStyle(fontSize: 10));
      },
    );
  }
}
