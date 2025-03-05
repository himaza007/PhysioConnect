import 'package:flutter/material.dart';
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
    5: "Apply an ice pack and do light movements. ❄️",
    7: "Use heat therapy & consider physiotherapy. 🔥",
    9: "Seek medical advice for persistent pain. 🏥",
    10: "Severe pain detected! Consult a doctor immediately. 🚨",
  };

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter pain location!"),
          backgroundColor: Colors.redAccent,
        ),
      );
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
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Row(
            children: [
              Icon(Icons.history, color: Colors.teal),
              SizedBox(width: 10),
              Text('Pain Log History',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          content: Container(
            height: 250,
            child: _painHistory.isEmpty
                ? Center(
                    child: Text("No records found.",
                        style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    itemCount: _painHistory.length,
                    itemBuilder: (context, index) {
                      final entry = _painHistory[index];
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: Icon(Icons.local_hospital,
                              color: Colors.redAccent),
                          title: Text("Pain Level: ${entry['painLevel']}"),
                          subtitle: Text(
                              "Location: ${entry['painLocation']} - ${entry['date']}"),
                        ),
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close',
                  style: TextStyle(
                      color: Colors.teal, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White Background
      appBar: AppBar(
        title: Text('Pain Monitoring',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF33724B),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Pain Level",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            // ✅ Circular Pain Indicator
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: CircularProgressIndicator(
                    value: _painLevel / 10,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                    strokeWidth: 10,
                  ),
                ),
                Column(
                  children: [
                    Icon(Icons.favorite, color: Colors.redAccent, size: 30),
                    SizedBox(height: 5),
                    Text(
                      "$_painLevel",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 15),

            // ✅ Slider for Pain Level
            Slider(
              value: _painLevel.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: _painLevel.toString(),
              activeColor: Colors.redAccent,
              onChanged: (value) {
                setState(() {
                  _painLevel = value.toInt();
                });
              },
            ),

            // ✅ Smart Pain Relief Suggestion with Icon
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info, color: Colors.teal),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      painReliefSuggestions.entries
                          .firstWhere((entry) => _painLevel <= entry.key,
                              orElse: () => MapEntry(
                                  10, "Please seek professional help."))
                          .value,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            // ✅ Pain Location Input
            TextField(
              decoration: InputDecoration(
                labelText: "Pain Location",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
              onChanged: (value) => _painLocation = value,
            ),

            SizedBox(height: 15),

            // ✅ Buttons Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _savePainEntry,
                  icon: Icon(Icons.save, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF33724B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  label:
                      Text('Save Entry', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton.icon(
                  onPressed: _showPainLogDialog,
                  icon: Icon(Icons.history, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  label:
                      Text('View Log', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),

            SizedBox(height: 10),

            // ✅ Back to Menu Button
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Back to Menu",
                style: TextStyle(
                    color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
