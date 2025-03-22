const mongoose = require('mongoose');

const exercisePlanSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  instructions: {
    type: String,
    required: true,
  },
  category: {
    type: String,
    enum: [
      'Rehabilitation',
      'Strength Training',
      'Flexibility & Mobility',
      'Balance & Stability',
      'Cardio Recovery',
    ],
    required: true,
  },
});

module.exports = mongoose.model('ExercisePlan', exercisePlanSchema);