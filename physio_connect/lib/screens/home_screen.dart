import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      'date': DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
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
              Text(
                'Pain Log History',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
          content: Container(
            height: 250,
            child: _painHistory.isEmpty
                ? Center(
                    child: Text(
                      "No records found.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _painHistory.length,
                    itemBuilder: (context, index) {
                      final entry = _painHistory[index];
                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: Icon(Icons.local_hospital,
                              color: Colors.redAccent),
                          title: Text(
                            "Pain Level: ${entry['painLevel']}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          subtitle: Text(
                            "Location: ${entry['painLocation']} - ${entry['date']}",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  ),
          ),
                actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Close',
                style:
                    TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
