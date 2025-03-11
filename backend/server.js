// server.js
require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(express.json());

// MongoDB Connection
mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// Data Model
const remedySchema = new mongoose.Schema({
  category: String,
  bodyPart: String,
  title: String,
  steps: [String],
  description: String,
});

const Remedy = mongoose.model('Remedy', remedySchema);

// Routes
// GET /api/remedies?category=K-Taping&bodyPart=Shoulder
app.get('/api/remedies', async (req, res) => {
  try {
    const { category, bodyPart } = req.query;
    const query = {};

    if (category) query.category = category;
    if (bodyPart) query.bodyPart = bodyPart;

    const remedies = await Remedy.find(query);
    res.json(remedies);
  } catch (error) {
    res.status(500).json({ error: 'Server error' });
  }
});

// POST /api/remedies (Admin only)
app.post('/api/remedies', async (req, res) => {
  try {
    const newRemedy = new Remedy(req.body);
    await newRemedy.save();
    res.status(201).json(newRemedy);
  } catch (error) {
    res.status(400).json({ error: 'Invalid data' });
  }
});

// Seed endpoint (for development)
app.get('/api/seed', async (req, res) => {
  try {
    await Remedy.deleteMany({});
    
    const seedData = [
      // K-Taping Remedies
      {
        category: 'K-Taping',
        bodyPart: 'Shoulder',
        title: 'Shoulder Support',
        steps: [
          "1️⃣ Cut a Y-shaped strip of kinesiology tape.",
          "2️⃣ Anchor the base on the upper arm (deltoid area).",
          "3️⃣ Stretch and apply both arms of the Y along the shoulder muscle.",
          "4️⃣ Smooth out the tape to ensure proper adhesion.",
          "✅ Helps with rotator cuff support and shoulder pain relief."
        ],
        description: "Guidance on applying Kinesiology tape for muscle support and pain relief."
      },
      {
        category: 'K-Taping',
        bodyPart: 'Knee',
        title: 'Knee Stability',
        steps: [
          "1️⃣ Cut a single long strip and round the edges.",
          "2️⃣ Anchor the base below the kneecap with no stretch.",
          "3️⃣ Stretch the tape around the kneecap in a C-shape.",
          "4️⃣ Apply additional strips for lateral and medial support if needed.",
          "✅ Provides stability and reduces knee pain during movement."
        ],
        description: "Kinesiology taping technique for knee support"
      },
      {
        category: 'K-Taping',
        bodyPart: 'Ankle',
        title: 'Ankle Support',
        steps: [
          "1️⃣ Start with a single strip anchored just above the ankle bone.",
          "2️⃣ Wrap around the foot in a figure-eight pattern.",
          "3️⃣ Add support strips along the Achilles tendon for extra stability.",
          "4️⃣ Ensure smooth application to avoid wrinkles.",
          "✅ Helps reduce swelling and provides ankle support."
        ],
        description: "Ankle stabilization taping method"
      },
      {
        category: 'K-Taping',
        bodyPart: 'Elbow',
        title: 'Elbow Support',
        steps: [
          "1️⃣ Cut a single strip long enough to cover the forearm to upper arm.",
          "2️⃣ Anchor at the forearm with no stretch.",
          "3️⃣ Stretch over the elbow joint and apply smoothly.",
          "4️⃣ Add a secondary strip if extra support is needed.",
          "✅ Reduces strain from tennis elbow and golfer’s elbow."
        ],
        description: "Elbow joint support taping"
      },
      {
        category: 'K-Taping',
        bodyPart: 'Lower Back',
        title: 'Lower Back Support',
        steps: [
          "1️⃣ Cut two long strips and round the edges.",
          "2️⃣ Anchor the base just above the tailbone with no stretch.",
          "3️⃣ Stretch upwards along both sides of the spine.",
          "4️⃣ Apply an extra horizontal strip for added lumbar support.",
          "✅ Helps relieve lower back pain and improves posture."
        ],
        description: "Lumbar support taping technique"
      },

      // Tailored Exercises
      {
        category: 'Tailored Exercises',
        bodyPart: 'Neck',
        title: 'Neck Mobility Exercises',
        steps: [
          "1️⃣ Neck Tilts: Slowly tilt your head side to side",
          "2️⃣ Neck Rotations: Gently turn your head left and right",
          "3️⃣ Chin Tucks: Pull your chin back while keeping head straight",
          "✅ Helps relieve neck stiffness and improve mobility"
        ],
        description: "Personalized rehab workouts for neck injuries"
      },
      {
        category: 'Tailored Exercises',
        bodyPart: 'Shoulder',
        title: 'Shoulder Strengthening',
        steps: [
          "1️⃣ Shoulder Rolls: Roll shoulders forward/backward",
          "2️⃣ Wall Angels: Move arms up/down against wall",
          "3️⃣ Resistance Band Pulls: Strengthen rotator cuff",
          "✅ Improves shoulder mobility and reduces pain"
        ],
        description: "Rehab exercises for shoulder injuries"
      },
      {
        category: 'Tailored Exercises',
        bodyPart: 'Lower Back',
        title: 'Lower Back Exercises',
        steps: [
          "1️⃣ Cat-Cow Stretch: Arch/round back on all fours",
          "2️⃣ Knee-to-Chest Stretch: Pull knee to chest",
          "3️⃣ Pelvic Tilts: Engage core muscles",
          "✅ Strengthens lower back muscles and alleviates pain"
        ],
        description: "Core strengthening exercises for lower back"
      },
      {
        category: 'Tailored Exercises',
        bodyPart: 'Knee',
        title: 'Knee Strengthening',
        steps: [
          "1️⃣ Straight Leg Raises: Lie on back and lift leg",
          "2️⃣ Heel Slides: Slide heel towards glutes",
          "3️⃣ Wall Sits: Hold squat position against wall",
          "✅ Enhances knee stability and prevents re-injury"
        ],
        description: "Knee rehab exercises"
      },
      {
        category: 'Tailored Exercises',
        bodyPart: 'Ankle',
        title: 'Ankle Mobility',
        steps: [
          "1️⃣ Ankle Circles: Rotate ankle in both directions",
          "2️⃣ Toe Taps: Tap toes up and down",
          "3️⃣ Calf Raises: Stand on toes and lower",
          "✅ Improves ankle flexibility and prevents sprains"
        ],
        description: "Ankle rehab exercises"
      },

      // Targeted Stretches
      {
        category: 'Targeted Stretches',
        bodyPart: 'Neck',
        title: 'Neck Stretches',
        steps: [
          "1️⃣ Side Neck Stretch: Tilt head to each side",
          "2️⃣ Forward Neck Stretch: Chin to chest",
          "3️⃣ Neck Rotation: Turn head left/right",
          "✅ Relieves neck tension and improves flexibility"
        ],
        description: "Neck mobility stretches"
      },
      {
        category: 'Targeted Stretches',
        bodyPart: 'Shoulder',
        title: 'Shoulder Stretches',
        steps: [
          "1️⃣ Cross-Body Shoulder Stretch",
          "2️⃣ Overhead Triceps Stretch",
          "3️⃣ Shoulder Rolls",
          "✅ Reduces shoulder tightness and improves mobility"
        ],
        description: "Shoulder flexibility exercises"
      },
      {
        category: 'Targeted Stretches',
        bodyPart: 'Lower Back',
        title: 'Lower Back Stretches',
        steps: [
          "1️⃣ Child’s Pose",
          "2️⃣ Seated Spinal Twist",
          "3️⃣ Cat-Cow Stretch",
          "✅ Alleviates lower back pain and enhances spinal flexibility"
        ],
        description: "Lower back pain relief stretches"
      },
      {
        category: 'Targeted Stretches',
        bodyPart: 'Hamstrings',
        title: 'Hamstring Stretches',
        steps: [
          "1️⃣ Standing Toe Touch",
          "2️⃣ Seated Hamstring Stretch",
          "3️⃣ Lying Hamstring Stretch",
          "✅ Increases hamstring flexibility and prevents strains"
        ],
        description: "Hamstring mobility exercises"
      },
      {
        category: 'Targeted Stretches',
        bodyPart: 'Calves',
        title: 'Calf Stretches',
        steps: [
          "1️⃣ Standing Calf Stretch",
          "2️⃣ Seated Calf Stretch",
          "3️⃣ Downward Dog",
          "✅ Loosens tight calf muscles and prevents cramps"
        ],
        description: "Calf muscle stretches"
      },

      // Oil Treatments
      {
        category: 'Oil Treatment',
        bodyPart: 'Neck & Shoulders',
        title: 'Neck & Shoulder Relaxation',
        steps: [
          "1️⃣ Use warm coconut/lavender oil",
          "2️⃣ Massage with circular motions",
          "3️⃣ Apply pressure to tense areas",
          "✅ Relieves tension and improves circulation"
        ],
        description: "Therapeutic oil application for neck/shoulders"
      },
      {
        category: 'Oil Treatment',
        bodyPart: 'Lower Back',
        title: 'Lower Back Relief',
        steps: [
          "1️⃣ Warm olive/eucalyptus oil",
          "2️⃣ Massage in circular motions",
          "3️⃣ Apply pressure along spine",
          "✅ Relieves lower back stiffness"
        ],
        description: "Lower back massage technique"
      },
      {
        category: 'Oil Treatment',
        bodyPart: 'Knees',
        title: 'Knee Pain Relief',
        steps: [
          "1️⃣ Use sesame/ginger oil",
          "2️⃣ Massage around kneecap",
          "3️⃣ Use long strokes",
          "✅ Reduces knee inflammation"
        ],
        description: "Anti-inflammatory knee massage"
      },
      {
        category: 'Oil Treatment',
        bodyPart: 'Ankles & Feet',
        title: 'Foot Relaxation',
        steps: [
          "1️⃣ Apply peppermint/tea tree oil",
          "2️⃣ Massage from heel to toes",
          "3️⃣ Focus on pressure points",
          "✅ Reduces foot swelling and fatigue"
        ],
        description: "Foot and ankle massage therapy"
      },
      {
        category: 'Oil Treatment',
        bodyPart: 'Arms & Elbows',
        title: 'Arm & Elbow Relief',
        steps: [
          "1️⃣ Use almond/castor oil",
          "2️⃣ Massage elbow joints",
          "3️⃣ Apply gentle pressure",
          "✅ Relieves arm muscle soreness"
        ],
        description: "Upper limb massage therapy"
      },

      // Home Recovery
      {
        category: 'Home Recovery',
        bodyPart: 'General',
        title: 'Muscle Soreness Relief',
        steps: [
          "1️⃣ Warm Bath with Epsom Salt",
          "2️⃣ Foam Rolling",
          "3️⃣ Gentle Stretching",
          "✅ Reduces muscle tension and promotes recovery"
        ],
        description: "Post-workout recovery techniques"
      },
      {
        category: 'Home Recovery',
        bodyPart: 'General',
        title: 'Joint Pain Management',
        steps: [
          "1️⃣ Heat/Cold Therapy",
          "2️⃣ Low-Impact Exercises",
          "3️⃣ Proper Rest",
          "✅ Manages joint pain and stiffness"
        ],
        description: "Joint pain home treatment"
      },
      {
        category: 'Home Recovery',
        bodyPart: 'Lower Back',
        title: 'Lower Back Support',
        steps: [
          "1️⃣ Pelvic Tilts",
          "2️⃣ Lumbar Stretch",
          "3️⃣ Proper Sleeping Posture",
          "✅ Relieves lower back pain"
        ],
        description: "Home care for lower back pain"
      },
      {
        category: 'Home Recovery',
        bodyPart: 'General',
        title: 'Post-Workout Recovery',
        steps: [
          "1️⃣ Hydration",
          "2️⃣ Protein Intake",
          "3️⃣ Light Activity",
          "✅ Speeds up muscle repair"
        ],
        description: "Post-exercise recovery routine"
      },
      {
        category: 'Home Recovery',
        bodyPart: 'General',
        title: 'Sleep & Relaxation',
        steps: [
          "1️⃣ Deep Breathing",
          "2️⃣ Meditation",
          "3️⃣ Nighttime Routine",
          "✅ Improves sleep quality"
        ],
        description: "Relaxation techniques for better sleep"
      }
    ];
    
    await Remedy.insertMany(seedData);
    res.json({ message: 'Data seeded successfully' });
  } catch (error) {
    res.status(500).json({ error: 'Seeding failed' });
  }
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});