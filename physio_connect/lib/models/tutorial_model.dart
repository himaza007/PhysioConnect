class TutorialModel {
  final String title;
  final String videoId;
  final String category; // 'Taping', 'Home Remedies', 'Exercises'
  final String summary;
  final List<String> steps;

  TutorialModel({
    required this.title,
    required this.videoId,
    required this.category,
    required this.summary,
    required this.steps,
  });
}
