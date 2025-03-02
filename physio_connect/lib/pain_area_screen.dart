import 'package:flutter/material.dart';
import 'muscle_selection_screen.dart';

class PainAreaScreen extends StatelessWidget {
  final Map<String, String> painAreas = {
    "Head": "assets/images/head.png",
    "Shoulder": "assets/images/shoulder.png",
    "Elbow": "assets/images/elbow.png",
    "Knee": "assets/images/knee.png",
    "Ankle": "assets/images/ankle.png",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Pain Area"), backgroundColor: Color(0xFF33724B)),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: painAreas.length,
        itemBuilder: (context, index) {
          String area = painAreas.keys.elementAt(index);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MuscleSelectionScreen(painArea: area),
                ),
              );
            },
            child: Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(painAreas[area]!, width: 80, height: 80),
                  SizedBox(height: 10),
                  Text(area, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
