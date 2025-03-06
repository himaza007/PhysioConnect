import 'package:flutter/material.dart';

class MilestoneTile extends StatelessWidget {
  final String title;
  final bool achieved;

  const MilestoneTile({super.key, required this.title, required this.achieved});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        achieved ? Icons.check_circle : Icons.circle_outlined,
        color: achieved ? Colors.green : Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
