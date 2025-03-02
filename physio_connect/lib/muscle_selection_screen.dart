import 'package:flutter/material.dart';

class MuscleSelectionScreen extends StatelessWidget {
  final String painArea;
  MuscleSelectionScreen({super.key, required this.painArea});

  final Map<String, List<Map<String, String>>> muscleMap = {
    "Head": [
      {"name": "Forehead Muscle", "image": "assets/muscles/forehead.png"},
      {"name": "Jaw Muscle", "image": "assets/muscles/jaw.png"},
    ],
    "Shoulder": [
      {"name": "Deltoid", "image": "assets/muscles/deltoid.png"},
      {"name": "Trapezius", "image": "assets/muscles/trapezius.png"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>>? muscles = muscleMap[painArea];

    return Scaffold(
      appBar: AppBar(title: Text("Select Muscle in $painArea"), backgroundColor: Color(0xFF33724B)),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: muscles?.length ?? 0,
        itemBuilder: (context, index) {
          var muscle = muscles![index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/remedies', arguments: muscle["name"]);
            },
            child: Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: Image.asset(muscle["image"]!, width: 60),
                title: Text(muscle["name"]!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          );
        },
      ),
    );
  }
}
