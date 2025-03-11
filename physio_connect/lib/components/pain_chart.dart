import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class PainChart extends StatelessWidget {
  final List<Map<String, dynamic>> painHistory;

  const PainChart({Key? key, required this.painHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
            "Pain Level Trend",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10),
          painHistory.isEmpty
              ? Center(
                  child: Text(
                    "No pain records available.",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : SfCartesianChart(
                  primaryXAxis: DateTimeAxis(
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    title: AxisTitle(text: 'Date & Time'),
                    dateFormat: DateFormat.MMMd().add_Hm(),
                  ),
                  primaryYAxis: NumericAxis(
                    minimum: 1,
                    maximum: 10,
                    interval: 1,
                    title: AxisTitle(text: 'Pain Level'),
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries<Map<String, dynamic>, DateTime>>[
                    LineSeries<Map<String, dynamic>, DateTime>(
                      name: "Pain Level",
                      dataSource: painHistory,
                      xValueMapper: (data, _) =>
                          DateFormat("yyyy-MM-dd – kk:mm")
                              .parse(data['date']), // ✅ Fixed Date Parsing
                      yValueMapper: (data, _) => data['painLevel'],
                      color: Colors.redAccent,
                      markerSettings: MarkerSettings(
                        isVisible: true,
                        shape: DataMarkerType.circle,
                        borderColor: Colors.red,
                        color: Colors.white,
                        borderWidth: 2,
                      ),
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
