import 'package:flutter/material.dart';
import 'therapist.dart';
import 'booking_screen.dart';
import 'support_chat_screen.dart';
import 'therapist_card.dart';

class TherapistSelectionScreen extends StatelessWidget {
  final List<Therapist> therapists = [
    Therapist(
      name: 'Dr. John Doe',
      specialty: 'Sports Injury',
      available: true,
      image: 'build/flutter_assets/img/therapist1.jpg',
      rating: 4.8,
    ),
    Therapist(
      name: 'Dr. Sarah Smith',
      specialty: 'Neurological',
      available: false,
      image: '',
      rating: 4.9,
    ),
    Therapist(
      name: 'Dr. Sarah Smith',
      specialty: 'Neurological',
      available: false,
      image: '',
      rating: 4.9,
    ),
    Therapist(
      name: 'Dr. Alex Brown',
      specialty: 'Orthopedic',
      available: true,
      image: '',
      rating: 4.7,
    ),
    Therapist(
      name: 'Dr. Emily Johnson',
      specialty: 'Pediatric',
      available: true,
      image: '',
      rating: 4.6,
    ),
    Therapist(
      name: 'Dr.  Michael Chen',
      specialty: 'Geriatric',
      available: true,
      image: '',
      rating: 4.9,
    ),
    Therapist(
      name: 'Dr Robert Garcia',
      specialty: 'Cardiopulmonary',
      available: false,
      image: '',
      rating: 4.9,
    ),
    Therapist(
      name: 'Dr. Lisa Wilson',
      specialty: 'Sports Rehabilitation',
      available: true,
      image: '',
      rating: 4.9,
    ),

    // Add remaining therapists
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Therapist'),
        backgroundColor: Colors.green.shade700,
        actions: [
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MessagingScreen()),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: therapists.length,
        itemBuilder: (context, index) {
          return TherapistCard(
            therapist: therapists[index],
            onBookPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingScreen(
                    therapistName: therapists[index].name,
                    therapistSpecialty: therapists[index].specialty,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SupportChatScreen()),
          );
        },
        backgroundColor: Colors.green.shade700,
        child: Icon(Icons.support_agent),
        tooltip: 'Contact Support',
      ),
    );
  }
}

class MessagingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support & Chat'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Center(child: Text('Messaging Feature Coming Soon...')),
    );
  }
}
