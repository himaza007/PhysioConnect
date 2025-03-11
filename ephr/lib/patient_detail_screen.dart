import 'package:flutter/material.dart';

class PatientDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Details"),
        backgroundColor: Colors.green[700], // Set app bar color
      ),
      body: Center(
        child: Text(
          "Patient details will be displayed here.",
        ), // Placeholder text
      ),
    );
  }
}
