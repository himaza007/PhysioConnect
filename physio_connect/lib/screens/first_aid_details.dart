import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FirstAidDetailsScreen extends StatefulWidget {
  final String title;
  final String? videoId;

  const FirstAidDetailsScreen({super.key, required this.title, this.videoId});

  @override
  State<FirstAidDetailsScreen> createState() => _FirstAidDetailsScreenState();
}

class _FirstAidDetailsScreenState extends State<FirstAidDetailsScreen> {
  late YoutubePlayerController _youtubeController;

  static final Map<String, Map<String, dynamic>> firstAidData = {
    "Foot Pain Relief": {
      "summary":
          "Effective stretches and techniques to reduce foot pain at home.",
      "steps": [
        "Stretch your toes and arches.",
        "Roll a cold water bottle under your foot.",
        "Avoid tight shoes and support with cushions."
      ],
      "videoId": "8Sj8uUOeobI"
    },
    "Knee Pain Relief": {
      "summary":
          "Simple movements to ease knee joint pain and improve flexibility.",
      "steps": [
        "Do straight leg raises.",
        "Stretch your hamstrings and calves.",
        "Avoid prolonged standing and stairs."
      ],
      "videoId": "1rHqj6oSmuI"
    },
    // ➕ Add other entries here like you've listed
    "Wrist Taping": {
      "summary": "Supportive tape method for wrist strains and sprains.",
      "steps": [
        "Wrap anchor around the wrist joint.",
        "Apply support strips across the wrist back and palm.",
        "Avoid overly tight wrapping."
      ],
      "videoId": "91DHdEeFokM"
    },
  };

  @override
  void initState() {
    super.initState();
    final videoId =
        widget.videoId ?? firstAidData[widget.title]?['videoId'] ?? "";
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = firstAidData[widget.title] ??
        {
          "summary": "No instructions available.",
          "steps": ["⚠ No steps found."],
          "videoId": "dQw4w9WgXcQ"
        };

    final List<String> steps = List<String>.from(data['steps']);
    final String summary = data['summary'];

    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FF),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(widget.title,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade800)),
                  ),
                ],
              ),
            ),
            YoutubePlayer(
              controller: _youtubeController,
              showVideoProgressIndicator: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                summary,
                style: const TextStyle(
                    fontSize: 16, color: Colors.black87, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: steps.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.medical_services_rounded,
                            color: Colors.teal.shade700),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Step ${index + 1}: ${steps[index]}",
                            style: const TextStyle(
                                fontSize: 16,
                                height: 1.4,
                                color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
