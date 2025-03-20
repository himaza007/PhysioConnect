import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../utils/storage_helper.dart';
import 'package:intl/intl.dart';

class PainHistoryScreen extends StatefulWidget {
  final List<Map<String, dynamic>> painHistory; // ✅ Ensure correct data passing

  const PainHistoryScreen({super.key, required this.painHistory});

  @override
  _PainHistoryScreenState createState() => _PainHistoryScreenState();
}

class _PainHistoryScreenState extends State<PainHistoryScreen> {
  List<Map<String, dynamic>> _painHistory = [];
  List<Map<String, dynamic>> _filteredPainHistory = [];
  String selectedFilter = "Month"; // Default selection

  @override
  void initState() {
    super.initState();
    _loadPainHistory();
  }

  /// ✅ Load pain history from local storage & apply the filter
  Future<void> _loadPainHistory() async {
    final history = await StorageHelper.loadPainHistory();
    setState(() {
      _painHistory = history;
      _applyFilter(selectedFilter); // Apply the selected filter on load
    });
  }

  /// ✅ Apply selected timeframe filter to history
  void _applyFilter(String filter) {
    DateTime now = DateTime.now();
    DateTime cutoffDate;

    switch (filter) {
      case "Day":
        cutoffDate = now.subtract(const Duration(days: 1));
        break;
      case "Week":
        cutoffDate = now.subtract(const Duration(days: 7));
        break;
      case "Month":
        cutoffDate = now.subtract(const Duration(days: 30));
        break;
      case "6 Months":
        cutoffDate = now.subtract(const Duration(days: 180));
        break;
      default:
        cutoffDate = now;
    }

    setState(() {
      selectedFilter = filter;
      _filteredPainHistory = _painHistory.where((entry) {
        try {
          return DateFormat('yyyy-MM-dd – kk:mm')
              .parse(entry['date'])
              .isAfter(cutoffDate);
        } catch (e) {
          print("⚠ Error parsing date: ${entry['date']}");
          return false;
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21), // Dark Theme
      appBar: AppBar(
        title: const Text(
          'Pain History',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Refresh Data",
            onPressed: _loadPainHistory,
          ),
        ],
      ),
      body: Column(
        children: [
          // ✅ Filter Selection
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ["Day", "Week", "Month", "6 Months"]
                  .map((filter) => ChoiceChip(
                        label: Text(filter),
                        selected: selectedFilter == filter,
                        onSelected: (selected) {
                          if (selected) _applyFilter(filter);
                        },
                        backgroundColor: Colors.black,
                        selectedColor: Colors.blueAccent,
                        labelStyle: TextStyle(
                          color: selectedFilter == filter
                              ? Colors.white
                              : Colors.grey.shade400,
                        ),
                      ))
                  .toList(),
            ),
          ),

          // ✅ Pain Trend Chart with Modern UI
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.5),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: SfCartesianChart(
                backgroundColor: Colors.transparent,
                title: ChartTitle(
                  text: "Pain Level Trend",
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                primaryXAxis: CategoryAxis(
                  title: AxisTitle(
                      text: "Date", textStyle: TextStyle(color: Colors.white)),
                  labelRotation: 45,
                  majorGridLines: const MajorGridLines(width: 0),
                  labelStyle: const TextStyle(color: Colors.white),
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(
                      text: "Pain Level",
                      textStyle: TextStyle(color: Colors.white)),
                  minimum: 0,
                  maximum: 10,
                  interval: 1,
                  majorGridLines: const MajorGridLines(
                    dashArray: [5, 5],
                  ),
                  labelStyle: const TextStyle(color: Colors.white),
                ),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  color: Colors.blueAccent,
                  textStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  format: 'Date: point.x \nPain Level: point.y',
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePinching: true,
                  enablePanning: true,
                ),
                series: <CartesianSeries>[
                  SplineSeries<Map<String, dynamic>, String>(
                    dataSource: _filteredPainHistory,
                    xValueMapper: (data, _) => data['date'].toString(),
                    yValueMapper: (data, _) => data['painLevel'],
                    width: 4,
                    color: Colors.blueAccent.withOpacity(0.8),
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      shape: DataMarkerType.circle,
                      color: Colors.blueAccent,
                      borderColor: Colors.white,
                      borderWidth: 2,
                    ),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ✅ Pain History List
          Expanded(
            flex: 2,
            child: _filteredPainHistory.isEmpty
                ? const Center(
                    child: Text(
                      "No pain history records found.",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredPainHistory.length,
                    itemBuilder: (context, index) {
                      final entry = _filteredPainHistory[index];
                      return Card(
                        elevation: 6,
                        color: Colors.black,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: const Icon(Icons.local_hospital,
                              color: Colors.redAccent),
                          title: Text(
                            "Pain Level: ${entry['painLevel']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            "Location: ${entry['painLocation']} \n${entry['date']}",
                            style: const TextStyle(color: Colors.white60),
                          ),
                          trailing: Text(
                            entry['painLevel'] >= 7 ? "Critical" : "Normal",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: entry['painLevel'] >= 7
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
