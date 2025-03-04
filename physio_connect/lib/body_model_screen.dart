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

  // Pain area positions as fractions (0.0 - 1.0) of the image's dimensions.
  final Map<String, Offset> painAreaPositions = {
    "Head": Offset(0.5, 0.1),
    "Shoulder": Offset(0.5, 0.3),
    "Elbow": Offset(0.75, 0.5),
    "Knee": Offset(0.5, 0.8),
    "Ankle": Offset(0.35, 0.95),
  };

  // NEW: A set to hold multiple selected pain areas.
  Set<String> selectedPainPoints = {};

  @override
  Widget build(BuildContext context) {
    final List<String> images = widget.gender == "Male" ? maleImages : femaleImages;
    final screenWidth = MediaQuery.of(context).size.width;
    final modelWidth = screenWidth * 0.9;
    final modelHeight = modelWidth * (5 / 3); // Adjust the aspect ratio as needed.

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.gender} Body Model"),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/bg.jpg", fit: BoxFit.cover),
          Container(color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.4)),
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
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final containerWidth = constraints.maxWidth;
                            final containerHeight = constraints.maxHeight;
                            return Stack(
                              children: [
                                // The model image.
                                Image.asset(
                                  images[index],
                                  width: containerWidth,
                                  height: containerHeight,
                                  fit: BoxFit.contain,
                                ),
                                // NEW: Overlay multiple tappable dots.
                                for (var entry in painAreaPositions.entries)
                                  Positioned(
                                    left: entry.value.dx * containerWidth - 7.5,
                                    top: entry.value.dy * containerHeight - 7.5,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (selectedPainPoints.contains(entry.key)) {
                                            selectedPainPoints.remove(entry.key);
                                          } else {
                                            selectedPainPoints.add(entry.key);
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: selectedPainPoints.contains(entry.key)
                                              ? const Color.fromARGB(255, 5, 78, 23)  // Indicates selection.
                                              : const Color.fromARGB(255, 146, 29, 29),
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
              // NEW: "Continue" button to navigate with selected pain areas.
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: selectedPainPoints.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MuscleSelectionScreen(
                                selectedAreas: selectedPainPoints.toList(),
                              ),
                            ),
                          );
                        },
                  child: const Text("Continue"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
