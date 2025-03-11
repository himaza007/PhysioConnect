import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.green[700],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(20),
        children: [
          _buildTile("Patients", Icons.people),
          _buildTile("Appointments", Icons.calendar_today),
          _buildTile("Profile", Icons.person),
        ],
      ),
    );
  }

  Widget _buildTile(String title, IconData icon) {
    return Card(
      color: Colors.green[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.green[700]),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
