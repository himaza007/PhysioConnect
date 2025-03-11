import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressTrackingScreen extends StatefulWidget {
  const ProgressTrackingScreen({Key? key}) : super(key: key);

  @override
  _ProgressTrackingScreenState createState() => _ProgressTrackingScreenState();
}

class _ProgressTrackingScreenState extends State<ProgressTrackingScreen> {
  late TooltipBehavior _tooltipBehavior;
  bool _isDarkMode = false; // Dark Mode Toggle

  // Sample progress data
  final List<ProgressData> _progressData = [
    ProgressData("Week 1", 20),
    ProgressData("Week 2", 40),
    ProgressData("Week 3", 55),
    ProgressData("Week 4", 70),
    ProgressData("Week 5", 90),
  ];

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          "Progress Tracker",
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.white),
        ),
        backgroundColor: const Color(0xFF33724B),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recovery Progress 📈",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            // Progress Chart
            Expanded(
              flex: 2,
              child: Card(
                elevation: 5,
                color: _isDarkMode ? Colors.grey[900] : Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                      labelStyle: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                    ),
                    primaryYAxis: NumericAxis(
                      labelStyle: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                    ),
                    title: ChartTitle(
                      text: "Your Recovery Journey",
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    legend: Legend(isVisible: false),
                    tooltipBehavior: _tooltipBehavior,
                    series: <CartesianSeries<ProgressData, String>>[
                      LineSeries<ProgressData, String>(
                        dataSource: _progressData,
                        xValueMapper: (ProgressData progress, _) => progress.week,
                        yValueMapper: (ProgressData progress, _) => progress.percentage,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          textStyle: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                        ),
                        color: const Color(0xFF33724B),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Insights Section with Navigation
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _isDarkMode ? Colors.grey[900] : const Color(0xFFEAF7FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Progress Insights",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _progressCard(
                          "Average Improvement", "+15%", Icons.trending_up, context, ImprovementPage()),
                      _progressCard("Total Weeks", "5", Icons.date_range, context, WeekProgressPage()),
                      _progressCard("Current Level", "Intermediate", Icons.star, context, LevelProgressPage()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _progressCard(String title, String value, IconData icon, BuildContext context, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Column(
        children: [
          Icon(icon, size: 30, color: const Color(0xFF33724B)),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 14, color: _isDarkMode ? Colors.white70 : Colors.black54),
          ),
        ],
      ),
    );
  }
}

// 📌 Progress Data Model
class ProgressData {
  final String week;
  final double percentage;

  ProgressData(this.week, this.percentage);
}
