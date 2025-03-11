import 'package:flutter/material.dart';

class LevelProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Current Level Details"),
        backgroundColor: const Color(0xFF33724B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Progression Pathway 🎯",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),
            _levelCard("Beginner", "Completed ✅"),
            _levelCard("Intermediate", "Current Level 🔵"),
            _levelCard("Advanced", "10 More Sessions to Unlock"),
            _levelCard("Expert", "25 More Sessions to Unlock"),
          ],
        ),
      ),
    );
  }

  Widget _levelCard(String level, String status) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFFEAF7FF),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.check_circle_outline, color: Color(0xFF33724B), size: 30),
        title: Text(
          level,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        subtitle: Text(status, style: const TextStyle(fontSize: 14, color: Colors.black87)),
      ),
    );
  }
}
