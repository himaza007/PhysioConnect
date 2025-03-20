// Import dependencies
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

// Initialize Express app
const app = express();
const PORT = 5000;

// Middleware
app.use(cors());
app.use(express.json());

// Connect to MongoDB
mongoose.connect('mongodb://localhost:27017/injury_remedies', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
}).then(() => {
  console.log('Connected to MongoDB');
}).catch((err) => {
  console.error('MongoDB connection error:', err);
});

// Define MongoDB Schemas and Models
const KTapingSchema = new mongoose.Schema({
  bodyPart: String,
  steps: [String],
  description: String,
});
const KTaping = mongoose.model('KTaping', KTapingSchema);

const ExerciseSchema = new mongoose.Schema({
  bodyPart: String,
  exercises: [String],
  description: String,
});
const Exercise = mongoose.model('Exercise', ExerciseSchema);

const StretchSchema = new mongoose.Schema({
  bodyPart: String,
  stretches: [String],
  description: String,
});
const Stretch = mongoose.model('Stretch', StretchSchema);

const OilTreatmentSchema = new mongoose.Schema({
  bodyPart: String,
  steps: [String],
  description: String,
});
const OilTreatment = mongoose.model('OilTreatment', OilTreatmentSchema);

const RecoveryRoutineSchema = new mongoose.Schema({
  routineType: String,
  steps: [String],
  description: String,
});
const RecoveryRoutine = mongoose.model('RecoveryRoutine', RecoveryRoutineSchema);

// Seed Database
const seedDatabase = async () => {
  await KTaping.deleteMany({});
  await Exercise.deleteMany({});
  await Stretch.deleteMany({});
  await OilTreatment.deleteMany({});
  await RecoveryRoutine.deleteMany({});

  const kTapingData = [
    {
      bodyPart: "Shoulder",
      steps: [
        "Cut a Y-shaped strip of kinesiology tape.",
        "Anchor the base on the upper arm (deltoid area).",
        "Stretch and apply both arms of the Y along the shoulder muscle.",
        "Smooth out the tape to ensure proper adhesion."
      ],
      description: "Helps with rotator cuff support and shoulder pain relief."
    },
    {
      bodyPart: "Knee",
      steps: [
        "Cut a single long strip and round the edges.",
        "Anchor the base below the kneecap with no stretch.",
        "Stretch the tape around the kneecap in a C-shape.",
        "Apply additional strips for lateral and medial support if needed."
      ],
      description: "Provides stability and reduces knee pain during movement."
    },
  ];
  await KTaping.insertMany(kTapingData);

  const exerciseData = [
    {
      bodyPart: "Neck",
      exercises: [
        "Neck Tilts: Slowly tilt your head side to side, holding for 10 seconds on each side.",
        "Neck Rotations: Gently turn your head left and right, holding for a few seconds.",
        "Chin Tucks: Pull your chin back while keeping your head straight to strengthen the deep neck muscles."
      ],
      description: "Helps relieve neck stiffness and improve mobility."
    },
  ];
  await Exercise.insertMany(exerciseData);

  const stretchData = [
    {
      bodyPart: "Lower Back",
      stretches: [
        "Cat-Cow Stretch: Alternate between arching and rounding your back while on all fours.",
        "Knee-to-Chest Stretch: Pull one knee to your chest and hold for 15 seconds.",
        "Pelvic Tilts: Lie on your back and tilt your pelvis up and down to engage core muscles."
      ],
      description: "Strengthens lower back muscles and alleviates pain."
    },
  ];
  await Stretch.insertMany(stretchData);

  const oilTreatmentData = [
    {
      bodyPart: "Lower Back",
      steps: [
        "Warm up olive oil or eucalyptus oil for better absorption.",
        "Apply the oil along the lower back and massage in slow, circular motions.",
        "Use both hands to apply pressure along the spine and lower back muscles."
      ],
      description: "Provides relief from lower back stiffness and enhances muscle recovery."
    },
  ];
  await OilTreatment.insertMany(oilTreatmentData);

  const recoveryRoutineData = [
    {
      routineType: "Muscle Soreness Relief",
      steps: [
        "Warm Bath with Epsom Salt: Helps relax muscles and reduce soreness.",
        "Foam Rolling: Use a foam roller to massage tight muscle areas.",
        "Gentle Stretching: Perform light stretches to maintain flexibility and prevent stiffness."
      ],
      description: "Reduces muscle tension and promotes faster recovery."
    },
  ];
  await RecoveryRoutine.insertMany(recoveryRoutineData);

  console.log('Database seeded successfully');
};
// Uncomment the line below to seed the database
// seedDatabase();


