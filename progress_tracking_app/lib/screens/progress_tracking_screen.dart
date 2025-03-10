import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressTrackingScreen extends StatefulWidget {
  const ProgressTrackingScreen({Key? key}) : super(key: key);

  @override
  _ProgressTrackingScreenState createState() => _ProgressTrackingScreenState();
}

class _ProgressTrackingScreenState extends State<ProgressTrackingScreen> {
  late TooltipBehavior _tooltipBehavior;

  // Sample progress data
  final List<ProgressData> _progressData = [
    ProgressData("Week 1", 20),
    ProgressData("Week 2", 40),
    ProgressData("Week 3", 55),
    ProgressData("Week 4", 70),
    ProgressData("Week 5", 90),
  ];

  // Sample milestones
  final List<Milestone> _milestones = [
    Milestone(title: "Completed First Exercise Session", achieved: true),
    Milestone(title: "Improved Mobility by 50%", achieved: false),
    Milestone(title: "Able to Perform Squats", achieved: false),
    Milestone(title: "Ran 1km Without Pain", achieved: false),
  ];

  // Sample past milestones history
  final List<Milestone> _pastMilestones = [
    Milestone(title: "Walked Without Support", achieved: true),
    Milestone(title: "Reduced Pain by 30%", achieved: true),
  ];

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // App background remains white
      appBar: AppBar(
        title: const Text(
          "Progress Tracker",
          style: TextStyle(color: Colors.white), // Keep title white on dark bar
        ),
        backgroundColor: const Color(0xFF33724B), // Midnight Teal
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              "Recovery Progress 📈",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),

            // Progress Chart
            Expanded(
              flex: 2,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Colors.white, // Ensure the chart card remains white
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SfCartesianChart(
                    backgroundColor: Colors.white, // Keep chart background white
                    primaryXAxis: CategoryAxis(
                      labelStyle: const TextStyle(color: Colors.black), // X-Axis Labels
                    ),
                    primaryYAxis: NumericAxis(
                      labelStyle: const TextStyle(color: Colors.black), // Y-Axis Labels
                    ),
                    title: ChartTitle(
                      text: "Your Recovery Journey",
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    legend: Legend(isVisible: false),
                    tooltipBehavior: _tooltipBehavior,
                    series: <CartesianSeries<ProgressData, String>>[
                      LineSeries<ProgressData, String>(
                        dataSource: _progressData,
                        xValueMapper: (ProgressData progress, _) => progress.week,
                        yValueMapper: (ProgressData progress, _) => progress.percentage,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          textStyle: TextStyle(color: Colors.black), // Ensure data labels are black
                        ),
                        color: const Color(0xFF33724B), // Midnight Teal for the chart line
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Milestones Section
            const Text(
              "Milestones 🏆",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),

            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: _milestones.length,
                itemBuilder: (context, index) {
                  return AnimatedMilestoneTile(
                    milestone: _milestones[index],
                    onTap: () {
                      setState(() {
                        _milestones[index].achieved = !_milestones[index].achieved;
                      });
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Past Milestones History
            const Text(
              "Past Achievements 🏅",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),

            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: _pastMilestones.length,
                itemBuilder: (context, index) {
                  return PastMilestoneTile(milestone: _pastMilestones[index]);
                },
              ),
            ),
          ],
        ),
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

// 📌 Milestone Model
class Milestone {
  final String title;
  bool achieved;

  Milestone({required this.title, required this.achieved});
}

// 📌 Fun & Interactive Milestone Tile
class AnimatedMilestoneTile extends StatefulWidget {
  final Milestone milestone;
  final VoidCallback onTap;

  const AnimatedMilestoneTile({Key? key, required this.milestone, required this.onTap})
      : super(key: key);

  @override
  _AnimatedMilestoneTileState createState() => _AnimatedMilestoneTileState();
}

class _AnimatedMilestoneTileState extends State<AnimatedMilestoneTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.milestone.achieved ? const Color(0xFFEAF7FF) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.milestone.achieved ? const Color(0xFF33724B) : Colors.grey,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              widget.milestone.achieved ? Icons.check_circle : Icons.radio_button_unchecked,
              color: widget.milestone.achieved ? const Color(0xFF33724B) : Colors.grey,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.milestone.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  decoration: widget.milestone.achieved ? TextDecoration.lineThrough : null,
                  color: widget.milestone.achieved ? const Color(0xFF33724B) : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 📌 Past Milestones Tile (Static)
class PastMilestoneTile extends StatelessWidget {
  final Milestone milestone;

  const PastMilestoneTile({Key? key, required this.milestone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF7FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF33724B),
          width: 2,
        ),
      ),
      child: Text(
        milestone.title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
