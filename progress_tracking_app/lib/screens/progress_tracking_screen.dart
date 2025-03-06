import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/syncfusion_flutter_charts.dart' as sfCharts;
import '../widgets/milestone_tile.dart';
import '../widgets/progress_input.dart';
import '../models/progress_data.dart';

class ProgressTrackingScreen extends StatefulWidget {
  const ProgressTrackingScreen({super.key});

  @override
  _ProgressTrackingScreenState createState() => _ProgressTrackingScreenState();
}

class _ProgressTrackingScreenState extends State<ProgressTrackingScreen> {
  // ignore: prefer_final_fields
  List<ProgressData> _progressData = [
    ProgressData("Week 1", 20),
    ProgressData("Week 2", 40),
    ProgressData("Week 3", 55),
    ProgressData("Week 4", 75),
    ProgressData("Week 5", 90),
  ];

  void _addProgress(String week, double percentage) {
    setState(() {
      _progressData.add(ProgressData(week, percentage));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Progress Tracking"),
        backgroundColor: const Color(0xFF33724B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recovery Progress",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),

            // Progress Chart
            Expanded(
              flex: 2,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: "Patient's Recovery Over Time"),
                legend: Legend(isVisible: false),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<ProgressData, String>>[
                  LineSeries<ProgressData, String>(
                    dataSource: _progressData,
                    xValueMapper: (ProgressData progress, _) => progress.week,
                    yValueMapper: (ProgressData progress, _) => progress.percentage,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    color: const Color(0xFF66BB6A),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Add Progress
            ProgressInput(onSubmit: _addProgress),

            const SizedBox(height: 20),

            // Milestone Tracking
            const Text(
              "Milestones",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 1,
              child: ListView(
                children: const [
                  MilestoneTile(title: "Completed First Exercise Session", achieved: true),
                  MilestoneTile(title: "Improved Mobility by 50%", achieved: false),
                  MilestoneTile(title: "Able to Perform Squats", achieved: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
