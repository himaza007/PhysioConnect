import 'package:flutter/material.dart';
import 'muscle_selection_screen.dart';

class BodyModelScreen extends StatefulWidget {
  final String gender;
  const BodyModelScreen({super.key, required this.gender});

  @override
  State<BodyModelScreen> createState() => _BodyModelScreenState();
}

class _BodyModelScreenState extends State<BodyModelScreen> {
  final PageController _pageController = PageController(initialPage: 1);

  final List<String> maleImages = [
    "assets/images/2.png",
    "assets/images/3.png",
    "assets/images/4.png"
  ];
  final List<String> femaleImages = [
    "assets/images/5.png",
    "assets/images/6.png",
    "assets/images/7.png"
  ];

  // Define pain area positions as fractions (0.0 - 1.0)
  // These fractions represent the relative position on the model image.
  final Map<String, Offset> painAreaPositions = {
    "Head": Offset(0.5, 0.1),
    "Shoulder": Offset(0.5, 0.3),
    "Elbow": Offset(0.75, 0.5),
    "Knee": Offset(0.5, 0.8),
    "Ankle": Offset(0.35, 0.95),
  };

  @override
  Widget build(BuildContext context) {
    final List<String> images = widget.gender == "Male" ? maleImages : femaleImages;
    final screenWidth = MediaQuery.of(context).size.width;
    // Let the model image occupy 90% of screen width.
    final modelWidth = screenWidth * 0.9;
    // Assume an aspect ratio for the image (e.g., 3:5)
    final modelHeight = modelWidth * (5 / 3);

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.gender} Body Model"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image for overall theme
          Image.asset("assets/images/bg.jpg", fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.4)),
          Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Container(
                        width: modelWidth,
                        height: modelHeight,
                        // Use LayoutBuilder to determine container size for dot placement.
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final containerWidth = constraints.maxWidth;
                            final containerHeight = constraints.maxHeight;
                            return Stack(
                              children: [
                                // The model image
                                Image.asset(
                                  images[index],
                                  width: containerWidth,
                                  height: containerHeight,
                                  fit: BoxFit.contain,
                                ),
                                // Overlay smaller red dots on the model image.
                                for (var entry in painAreaPositions.entries)
                                  Positioned(
                                    left: entry.value.dx * containerWidth - 7.5,
                                    top: entry.value.dy * containerHeight - 7.5,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MuscleSelectionScreen(
                                              selectedAreas: [entry.key],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
