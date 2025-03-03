import 'package:flutter/material.dart';
import 'pain_monitoring.dart';
import 'emergency_contact.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PhysioConnect", style: TextStyle(fontSize: 22)),
        backgroundColor: Color(0xFF33724B),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.favorite, size: 28),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF33724B),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PainMonitoringPage()),
                );
              },
              label: Text(
                "Pain Monitoring",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.warning, size: 28),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmergencyContactPage(),
                  ),
                );
              },
              label: Text(
                "One-Tap Emergency",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
