import 'package:flutter/material.dart';
// import 'Patient_list_screen.dart';
// import 'appointments_screen.dart';
// import 'profile_screen.dart';

class DashboardScreen extends StatelessWidget {
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
          _buildTile(context, "Patients", Icons.people, PatientListScreen()),
          _buildTile(
            context,
            "Appointments",
            Icons.calendar_today,
            AppointmentsScreen(),
          ),
          _buildTile(context, "Profile", Icons.person, ProfileScreen()),
        ],
      ),
    );
  }

  Widget _buildTile(
    BuildContext context,
    String title,
    IconData icon,
    Widget screen,
  ) {
    return Card(
      color: Colors.green[100],
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
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
      ),
    );
  }
}
