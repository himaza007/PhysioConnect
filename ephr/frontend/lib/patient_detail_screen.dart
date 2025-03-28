import 'package:flutter/material.dart';

class PatientDetailsScreen extends StatelessWidget {
  final String patientName;

  PatientDetailsScreen({required this.patientName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(patientName),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Patient Name: $patientName",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Medical History: No major conditions.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Placeholder for navigation or functionality
                },
                child: Text("View Full History"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700], // Match app theme
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
