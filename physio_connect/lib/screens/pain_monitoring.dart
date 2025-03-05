import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/storage_helper.dart';

class PainMonitoringPage extends StatefulWidget {
  @override
  _PainMonitoringPageState createState() => _PainMonitoringPageState();
}

class _PainMonitoringPageState extends State<PainMonitoringPage> {
  int _painLevel = 5;
  String _painLocation = '';
  List<Map<String, dynamic>> _painHistory = [];

  final Map<int, String> painReliefSuggestions = {
    1: "Minimal discomfort, rest well! 💆‍♂️",
    3: "Try gentle stretching & hydration. 💧",


  @override
  void initState() {
    super.initState();
    _loadPainHistory();
  }

  Future<void> _loadPainHistory() async {
    _painHistory = await StorageHelper.loadPainHistory();
    setState(() {});
  }

  Future<void> _savePainEntry() async {
    if (_painLocation.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter pain location!")));
      return;
    }

    Map<String, dynamic> newEntry = {
      'date': DateTime.now().toString().substring(0, 16),
      'painLevel': _painLevel,
      'painLocation': _painLocation,
    };

    _painHistory.insert(0, newEntry);
    await StorageHelper.savePainHistory(_painHistory);
    setState(() {});
  }

  void _showPainLogDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pain Log History'),
          content: Container(
            height: 200,
            child: ListView.builder(
              itemCount: _painHistory.length,
              itemBuilder: (context, index) {
                final entry = _painHistory[index];
                return ListTile(
                  title: Text("Pain Level: ${entry['painLevel']}"),
                  subtitle: Text(
                    "Location: ${entry['painLocation']} - ${entry['date']}",
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pain Monitoring')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Select Pain Level:", style: TextStyle(fontSize: 16)),
            Slider(
              value: _painLevel.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: _painLevel.toString(),
              onChanged: (value) {
                setState(() {
                  _painLevel = value.toInt();
                });
              },
            ),
            LinearProgressIndicator(value: _painLevel / 10, color: Colors.red),
            TextField(
              decoration: InputDecoration(labelText: "Pain Location"),
              onChanged: (value) => _painLocation = value,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _savePainEntry,
              child: Text('Save Entry'),
            ),
            TextButton(
              onPressed: _showPainLogDialog,
              child: Text('View Pain Log'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Back to Menu"),
            ),
          ],
        ),
      ),
    );
  }
}
