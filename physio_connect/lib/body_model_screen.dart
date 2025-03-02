import 'package:flutter/material.dart';
import 'muscle_selection_screen.dart';

class BodyModelScreen extends StatefulWidget {
  final String gender;
  const BodyModelScreen({super.key, required this.gender});

  @override
  _BodyModelScreenState createState() => _BodyModelScreenState();
}

class _BodyModelScreenState extends State<BodyModelScreen> {
  final PageController _pageController = PageController(initialPage: 1);

  final Map<String, List<String>> bodyImages = {
    "Male": ["assets/images/2.png", "assets/images/3.png", "assets/images/4.png"],
    "Female": ["assets/images/5.png", "assets/images/6.png", "assets/images/7.png"],
  };

  final Map<String, Offset> painPoints = {
    "Head": Offset(0, -180),
    "Shoulder": Offset(-50, -100),
    "Elbow": Offset(-80, 0),
    "Knee": Offset(-30, 100),
    "Ankle": Offset(-30, 180),
  };

  void _selectPainArea(String area) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MuscleSelectionScreen(painArea: area)),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> images = bodyImages[widget.gender]!;

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.gender} Body Model"),
        backgroundColor: Color(0xFF33724B),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(images[index], width: 250),
                    ...painPoints.entries.map((entry) => _painPointButton(entry.key, entry.value)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _painPointButton(String area, Offset offset) {
    return Positioned(
      left: 150 + offset.dx,
      top: 250 + offset.dy,
      child: GestureDetector(
        onTap: () => _selectPainArea(area),
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
        ),
      ),
    );
  }
}
