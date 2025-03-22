import 'package:flutter/material.dart';
import 'package:physioconnect/data/tutorial_data.dart';
import 'package:physioconnect/widgets/tutorial_card.dart';
import 'tutorial_detail_screen.dart';

class TutorialListScreen extends StatelessWidget {
  final String category;

  const TutorialListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final filteredTutorials =
        tutorials.where((t) => t.category == category).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FF),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.teal.shade700,
            floating: true,
            pinned: true,
            elevation: 6,
            centerTitle: true,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 16),
              title: Text(
                "$category Tutorials",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          filteredTutorials.isEmpty
              ? SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildEmptyState(context),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final tutorial = filteredTutorials[index];
                      return TweenAnimationBuilder(
                        duration: Duration(milliseconds: 300 + (index * 80)),
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 30 * (1 - value)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: TutorialCard(
                                  tutorial: tutorial,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => TutorialDetailScreen(
                                            tutorial: tutorial),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    childCount: filteredTutorials.length,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.video_library_outlined,
                size: 72, color: Colors.teal.shade400),
            const SizedBox(height: 24),
            const Text(
              "No tutorials available in this category yet.",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              label: const Text("Back"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
