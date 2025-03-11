import 'package:flutter/material.dart';

class PatientDetailsScreen extends StatelessWidget {
  final String patientName; // Added parameter to accept patient name

  PatientDetailsScreen({required this.patientName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(patientName), // Display patient's name in the AppBar
        backgroundColor: Colors.green[700],
      ),
      body: Center(
        child: Text(
          "Patient Name: $patientName", // Display patient name in body
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
