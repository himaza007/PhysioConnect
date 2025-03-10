const mongoose = require("mongoose");

const ProgressSchema = new mongoose.Schema({
  userId: { type: String, required: true },
  week: { type: String, required: true },
  percentage: { type: Number, required: true },
  milestones: [
    {
      title: String,
      achieved: Boolean,
    },
  ],
});

module.exports = mongoose.model("Progress", ProgressSchema);
