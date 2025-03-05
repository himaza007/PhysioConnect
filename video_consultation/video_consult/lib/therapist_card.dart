import 'package:flutter/material.dart';
import '../models/therapist.dart';

class TherapistCard extends StatelessWidget {
  final Therapist therapist;
  final VoidCallback onBookPressed;

  TherapistCard({
    required this.therapist,
    required this.onBookPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(therapist.image),
            radius: 30,
          ),
          SizedBox(height: 8),
          Text(
            therapist.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2),
          Text(
            therapist.specialty,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.amber, size: 14),
              Text(
                ' ${therapist.rating}',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            therapist.available ? 'Available' : 'Not Available',
            style: TextStyle(
              fontSize: 12,
              color: therapist.available ? Colors.green : Colors.red,
            ),
          ),
          SizedBox(height: 6),
          therapist.available
              ? ElevatedButton(
                  onPressed: onBookPressed,
                  child: Text('Book', style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: Size(60, 28),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
