import 'package:flutter/material.dart';

class CustomizedInjuryRemediesScreen extends StatelessWidget {
  const CustomizedInjuryRemediesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows transparency effect
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65), // Adjusted AppBar height
        child: AppBar(
          backgroundColor: Colors.transparent, // Fully transparent AppBar
          elevation: 0, // Removes shadow
          centerTitle: true,
          title: const Text(
            "Customized Injury Remedies",
            style: TextStyle(
              fontSize: 20, // Adjusted font size
              fontWeight: FontWeight.bold,
              color: Color(0xFF33724B), // Green text (Midnight Teal)
            ),
          ),
          iconTheme: const IconThemeData(
            color: Color(0xFF33724B),
          ), // Green back button
        ),
      ),
      body: Stack(
        children: [
          // Background Gradient (optional for better readability)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.1), // Light Transparent White
                  Colors.white.withOpacity(0.05), // Fading White
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "These remedies consider factors such as the user's type of injury, acuteness, wounded area, and the progress in healing to provide personalized treatment plans or exercises tailored to an individual’s recovery needs. Below are the key remedies users can access:",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        _buildRemedyCard(
                          context,
                          title: "K-Taping Tutorials",
                          description:
                              "Guidance on applying Kinesiology tape for muscle support and pain relief.",
                          icon: Icons.sports_martial_arts,
                          onTap: () => _showKTapingPopup(context),
                        ),
                        _buildRemedyCard(
                          context,
                          title: "Tailored Exercises",
                          description:
                              "Personalized rehab workouts designed to speed up recovery and prevent re-injury.",
                          icon: Icons.fitness_center,
                          onTap:
                              () => _showTailoredExercisesPopup(
                                context,
                              ), // Add this line
                        ),
                        _buildRemedyCard(
                          context,
                          title: "Targeted Stretches",
                          description:
                              "Stretching routines customized to improve mobility and reduce muscle stiffness.",
                          icon: Icons.self_improvement,
                          onTap:
                              () => _showTargetedStretchesPopup(
                                context,
                              ), // Add this line
                        ),
                        _buildRemedyCard(
                          context,
                          title: "Oil Treatment Instructions",
                          description:
                              "Guidelines on using therapeutic oils for muscle relaxation and healing.",
                          icon: Icons.spa,
                          onTap:
                              () => _showOilTreatmentPopup(
                                context,
                              ), // Add this line
                        ),
                        _buildRemedyCard(
                          context,
                          title: "At-Home Recovery Routines",
                          description:
                              "Easy-to-follow exercises and home remedies using common household items.",
                          icon: Icons.home,
                          onTap:
                              () => _showHomeRecoveryPopup(
                                context,
                              ), // Add this line
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRemedyCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Card(
      color: Colors.white.withOpacity(0.9), // Slight transparency for cards
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2, // Lowered elevation for a smoother look
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF33724B)), // Green icon
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text(description, style: const TextStyle(fontSize: 13)),
        onTap: onTap, // Open popup if onTap is provided
      ),
    );
  }

  void _showKTapingPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("K-Taping Tutorials"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Choose a body part to learn how to apply Kinesiology tape effectively:",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),
              _buildKTapingOption(context, "Shoulder", Icons.accessibility_new),
              _buildKTapingOption(context, "Knee", Icons.directions_walk),
              _buildKTapingOption(context, "Ankle", Icons.directions_run),
              _buildKTapingOption(context, "Elbow", Icons.sports_gymnastics),
              _buildKTapingOption(
                context,
                "Lower Back",
                Icons.self_improvement,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildKTapingOption(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF33724B)), // Green icon
      title: Text(title, style: const TextStyle(fontSize: 15)),
      onTap: () {
        Navigator.of(context).pop();
        _showKTapingDetails(context, title);
      },
    );
  }

  void _showKTapingDetails(BuildContext context, String bodyPart) {
    String content = "";

    switch (bodyPart) {
      case "Shoulder":
        content =
            "1️⃣ Cut a Y-shaped strip of kinesiology tape.\n\n"
            "2️⃣ Anchor the base on the upper arm (deltoid area).\n\n"
            "3️⃣ Stretch and apply both arms of the Y along the shoulder muscle.\n\n"
            "4️⃣ Smooth out the tape to ensure proper adhesion.\n\n"
            "✅ Helps with rotator cuff support and shoulder pain relief.";
        break;

      case "Knee":
        content =
            "1️⃣ Cut a single long strip and round the edges.\n\n"
            "2️⃣ Anchor the base below the kneecap with no stretch.\n\n"
            "3️⃣ Stretch the tape around the kneecap in a C-shape.\n\n"
            "4️⃣ Apply additional strips for lateral and medial support if needed.\n\n"
            "✅ Provides stability and reduces knee pain during movement.";
        break;

      case "Ankle":
        content =
            "1️⃣ Start with a single strip anchored just above the ankle bone.\n\n"
            "2️⃣ Wrap around the foot in a figure-eight pattern.\n\n"
            "3️⃣ Add support strips along the Achilles tendon for extra stability.\n\n"
            "4️⃣ Ensure smooth application to avoid wrinkles.\n\n"
            "✅ Helps reduce swelling and provides ankle support.";
        break;

      case "Elbow":
        content =
            "1️⃣ Cut a single strip long enough to cover the forearm to upper arm.\n\n"
            "2️⃣ Anchor at the forearm with no stretch.\n\n"
            "3️⃣ Stretch over the elbow joint and apply smoothly.\n\n"
            "4️⃣ Add a secondary strip if extra support is needed.\n\n"
            "✅ Reduces strain from tennis elbow and golfer’s elbow.";
        break;

      case "Lower Back":
        content =
            "1️⃣ Cut two long strips and round the edges.\n\n"
            "2️⃣ Anchor the base just above the tailbone with no stretch.\n\n"
            "3️⃣ Stretch upwards along both sides of the spine.\n\n"
            "4️⃣ Apply an extra horizontal strip for added lumbar support.\n\n"
            "✅ Helps relieve lower back pain and improves posture.";
        break;

      default:
        content = "No specific instructions available.";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("K-Taping for $bodyPart"),
          content: Text(content, style: const TextStyle(fontSize: 15)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  //end1
  void _showTailoredExercisesPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Tailored Exercises"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Choose a body part to get personalized rehab exercises:",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),
              _buildExerciseOption(context, "Neck", Icons.accessibility_new),
              _buildExerciseOption(context, "Shoulder", Icons.sports_handball),
              _buildExerciseOption(
                context,
                "Lower Back",
                Icons.self_improvement,
              ),
              _buildExerciseOption(context, "Knee", Icons.directions_walk),
              _buildExerciseOption(context, "Ankle", Icons.directions_run),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildExerciseOption(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF33724B)), // Green icon
      title: Text(title, style: const TextStyle(fontSize: 15)),
      onTap: () {
        Navigator.of(context).pop();
        _showExerciseDetails(context, title);
      },
    );
  }

  void _showExerciseDetails(BuildContext context, String bodyPart) {
    String content = "";

    switch (bodyPart) {
      case "Neck":
        content =
            "1️⃣ Neck Tilts: Slowly tilt your head side to side, holding for 10 seconds on each side.\n\n"
            "2️⃣ Neck Rotations: Gently turn your head left and right, holding for a few seconds.\n\n"
            "3️⃣ Chin Tucks: Pull your chin back while keeping your head straight to strengthen the deep neck muscles.\n\n"
            "✅ Helps relieve neck stiffness and improve mobility.";
        break;

      case "Shoulder":
        content =
            "1️⃣ Shoulder Rolls: Roll your shoulders forward and backward in a circular motion.\n\n"
            "2️⃣ Wall Angels: Stand against a wall and move your arms up and down like a snow angel.\n\n"
            "3️⃣ Resistance Band Pulls: Use a resistance band to strengthen the rotator cuff.\n\n"
            "✅ Improves shoulder mobility and reduces pain from injuries.";
        break;

      case "Lower Back":
        content =
            "1️⃣ Cat-Cow Stretch: Alternate between arching and rounding your back while on all fours.\n\n"
            "2️⃣ Knee-to-Chest Stretch: Pull one knee to your chest and hold for 15 seconds.\n\n"
            "3️⃣ Pelvic Tilts: Lie on your back and tilt your pelvis up and down to engage core muscles.\n\n"
            "✅ Strengthens lower back muscles and alleviates pain.";
        break;

      case "Knee":
        content =
            "1️⃣ Straight Leg Raises: Lie on your back and lift one leg at a time while keeping it straight.\n\n"
            "2️⃣ Heel Slides: Slowly slide your heel towards your glutes while lying down.\n\n"
            "3️⃣ Wall Sits: Hold a squat position against a wall to build knee strength.\n\n"
            "✅ Enhances knee stability and prevents re-injury.";
        break;

      case "Ankle":
        content =
            "1️⃣ Ankle Circles: Rotate your ankle in both directions to increase mobility.\n\n"
            "2️⃣ Toe Taps: Tap your toes up and down to activate ankle muscles.\n\n"
            "3️⃣ Calf Raises: Stand on your toes and slowly lower back down to strengthen the lower leg.\n\n"
            "✅ Improves ankle flexibility and prevents sprains.";
        break;

      default:
        content = "No specific exercises available.";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Exercises for $bodyPart"),
          content: Text(content, style: const TextStyle(fontSize: 15)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  //end2
  void _showTargetedStretchesPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Targeted Stretches"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select a body part to view recommended stretches:",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),
              _buildStretchOption(context, "Neck", Icons.accessibility_new),
              _buildStretchOption(context, "Shoulder", Icons.sports_handball),
              _buildStretchOption(
                context,
                "Lower Back",
                Icons.self_improvement,
              ),
              _buildStretchOption(context, "Hamstrings", Icons.directions_walk),
              _buildStretchOption(context, "Calves", Icons.directions_run),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStretchOption(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF33724B)), // Green icon
      title: Text(title, style: const TextStyle(fontSize: 15)),
      onTap: () {
        Navigator.of(context).pop();
        _showStretchDetails(context, title);
      },
    );
  }

  void _showStretchDetails(BuildContext context, String bodyPart) {
    String content = "";

    switch (bodyPart) {
      case "Neck":
        content =
            "1️⃣ Side Neck Stretch: Tilt your head to one side and hold for 10 seconds, then switch.\n\n"
            "2️⃣ Forward Neck Stretch: Drop your chin to your chest and hold for 10 seconds.\n\n"
            "3️⃣ Neck Rotation: Slowly turn your head left and right, holding each side for a few seconds.\n\n"
            "✅ Relieves neck tension and improves flexibility.";
        break;

      case "Shoulder":
        content =
            "1️⃣ Cross-Body Shoulder Stretch: Bring one arm across your chest and hold for 15 seconds.\n\n"
            "2️⃣ Overhead Triceps Stretch: Reach one hand behind your back and gently press with the other.\n\n"
            "3️⃣ Shoulder Rolls: Roll your shoulders forward and backward in a circular motion.\n\n"
            "✅ Helps reduce shoulder tightness and improves mobility.";
        break;

      case "Lower Back":
        content =
            "1️⃣ Child’s Pose: Sit back on your heels and stretch your arms forward on the floor.\n\n"
            "2️⃣ Seated Spinal Twist: Sit with one leg crossed over the other and twist your torso.\n\n"
            "3️⃣ Cat-Cow Stretch: Alternate between arching and rounding your back while on all fours.\n\n"
            "✅ Alleviates lower back pain and enhances spinal flexibility.";
        break;

      case "Hamstrings":
        content =
            "1️⃣ Standing Toe Touch: Stand straight and reach towards your toes while keeping your legs straight.\n\n"
            "2️⃣ Seated Hamstring Stretch: Sit with one leg extended and lean forward to touch your toes.\n\n"
            "3️⃣ Lying Hamstring Stretch: Lie on your back and pull one leg towards your chest.\n\n"
            "✅ Increases hamstring flexibility and prevents strains.";
        break;

      case "Calves":
        content =
            "1️⃣ Standing Calf Stretch: Place your hands against a wall and step one foot back, pressing the heel into the ground.\n\n"
            "2️⃣ Seated Calf Stretch: Sit with your legs extended and pull your toes towards you.\n\n"
            "3️⃣ Downward Dog: Press your heels toward the floor in a downward-facing dog yoga pose.\n\n"
            "✅ Helps loosen tight calf muscles and prevents cramps.";
        break;

      default:
        content = "No specific stretches available.";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Stretches for $bodyPart"),
          content: Text(content, style: const TextStyle(fontSize: 15)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  //end3
  void _showOilTreatmentPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Oil Treatment Instructions"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select a body part to view the recommended oil treatment:",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),
              _buildOilTreatmentOption(context, "Neck & Shoulders", Icons.spa),
              _buildOilTreatmentOption(
                context,
                "Lower Back",
                Icons.self_improvement,
              ),
              _buildOilTreatmentOption(context, "Knees", Icons.directions_walk),
              _buildOilTreatmentOption(
                context,
                "Ankles & Feet",
                Icons.directions_run,
              ),
              _buildOilTreatmentOption(
                context,
                "Arms & Elbows",
                Icons.sports_gymnastics,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildOilTreatmentOption(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF33724B)), // Green icon
      title: Text(title, style: const TextStyle(fontSize: 15)),
      onTap: () {
        Navigator.of(context).pop();
        _showOilTreatmentDetails(context, title);
      },
    );
  }

  void _showOilTreatmentDetails(BuildContext context, String bodyPart) {
    String content = "";

    switch (bodyPart) {
      case "Neck & Shoulders":
        content =
            "1️⃣ Use warm coconut or lavender oil and apply with gentle circular motions.\n\n"
            "2️⃣ Massage from the base of the neck to the shoulders using upward strokes.\n\n"
            "3️⃣ Apply slight pressure to knots or tense areas, focusing on muscle relaxation.\n\n"
            "✅ Helps relieve tension, improve blood circulation, and promote relaxation.";
        break;

      case "Lower Back":
        content =
            "1️⃣ Warm up olive oil or eucalyptus oil for better absorption.\n\n"
            "2️⃣ Apply the oil along the lower back and massage in slow, circular motions.\n\n"
            "3️⃣ Use both hands to apply pressure along the spine and lower back muscles.\n\n"
            "✅ Provides relief from lower back stiffness and enhances muscle recovery.";
        break;

      case "Knees":
        content =
            "1️⃣ Use sesame or ginger oil for natural anti-inflammatory effects.\n\n"
            "2️⃣ Apply oil around the kneecap and gently massage in circular movements.\n\n"
            "3️⃣ Use long strokes on the front and back of the knee for full coverage.\n\n"
            "✅ Helps reduce knee pain, improve joint mobility, and soothe inflammation.";
        break;

      case "Ankles & Feet":
        content =
            "1️⃣ Apply peppermint or tea tree oil to refresh and relieve soreness.\n\n"
            "2️⃣ Massage from the heel to the toes, focusing on arch and ankle pressure points.\n\n"
            "3️⃣ Use thumbs to apply deeper pressure on tight areas for better circulation.\n\n"
            "✅ Helps reduce swelling, ease foot fatigue, and improve relaxation.";
        break;

      case "Arms & Elbows":
        content =
            "1️⃣ Use almond or castor oil for deep tissue nourishment.\n\n"
            "2️⃣ Massage in circular motions around the elbow joint and forearm muscles.\n\n"
            "3️⃣ Apply gentle pressure to relieve stiffness and promote relaxation.\n\n"
            "✅ Helps alleviate muscle soreness and provides deep hydration to the skin.";
        break;

      default:
        content = "No specific oil treatment instructions available.";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Oil Treatment for $bodyPart"),
          content: Text(content, style: const TextStyle(fontSize: 15)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  //end4
  void _showHomeRecoveryPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("At-Home Recovery Routines"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select a recovery routine based on your needs:",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),
              _buildHomeRecoveryOption(
                context,
                "Muscle Soreness Relief",
                Icons.fitness_center,
              ),
              _buildHomeRecoveryOption(
                context,
                "Joint Pain Management",
                Icons.accessibility_new,
              ),
              _buildHomeRecoveryOption(
                context,
                "Lower Back Support",
                Icons.self_improvement,
              ),
              _buildHomeRecoveryOption(
                context,
                "Post-Workout Recovery",
                Icons.directions_walk,
              ),
              _buildHomeRecoveryOption(
                context,
                "Sleep & Relaxation Techniques",
                Icons.nightlight_round,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHomeRecoveryOption(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF33724B)), // Green icon
      title: Text(title, style: const TextStyle(fontSize: 15)),
      onTap: () {
        Navigator.of(context).pop();
        _showHomeRecoveryDetails(context, title);
      },
    );
  }

  void _showHomeRecoveryDetails(BuildContext context, String routineType) {
    String content = "";

    switch (routineType) {
      case "Muscle Soreness Relief":
        content =
            "1️⃣ Warm Bath with Epsom Salt: Helps relax muscles and reduce soreness.\n\n"
            "2️⃣ Foam Rolling: Use a foam roller to massage tight muscle areas.\n\n"
            "3️⃣ Gentle Stretching: Perform light stretches to maintain flexibility and prevent stiffness.\n\n"
            "✅ Reduces muscle tension and promotes faster recovery.";
        break;

      case "Joint Pain Management":
        content =
            "1️⃣ Heat Therapy: Use a warm compress or heating pad to relax stiff joints.\n\n"
            "2️⃣ Cold Therapy: Apply an ice pack to reduce inflammation and swelling.\n\n"
            "3️⃣ Low-Impact Exercises: Engage in swimming or walking to maintain mobility without strain.\n\n"
            "✅ Helps ease joint discomfort and prevent stiffness.";
        break;

      case "Lower Back Support":
        content =
            "1️⃣ Pelvic Tilts: Lie on your back and tilt your pelvis to engage core muscles.\n\n"
            "2️⃣ Lumbar Stretch: Sit on a chair and lean forward to stretch the lower back.\n\n"
            "3️⃣ Sleeping Posture: Use a pillow under your knees while sleeping for back support.\n\n"
            "✅ Relieves lower back pain and improves posture.";
        break;

      case "Post-Workout Recovery":
        content =
            "1️⃣ Hydration: Drink plenty of water to aid muscle recovery.\n\n"
            "2️⃣ Protein Intake: Consume a protein-rich meal or shake to support muscle repair.\n\n"
            "3️⃣ Light Activity: Take a short walk or do yoga to avoid stiffness.\n\n"
            "✅ Speeds up muscle repair and enhances workout recovery.";
        break;

      case "Sleep & Relaxation Techniques":
        content =
            "1️⃣ Deep Breathing: Practice slow, deep breaths to calm the nervous system.\n\n"
            "2️⃣ Meditation: Spend 5-10 minutes in a quiet space to reduce stress.\n\n"
            "3️⃣ Nighttime Routine: Avoid screens before bed and use calming music for better sleep.\n\n"
            "✅ Improves sleep quality and promotes relaxation.";
        break;

      default:
        content = "No specific recovery techniques available.";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(routineType),
          content: Text(content, style: const TextStyle(fontSize: 15)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
