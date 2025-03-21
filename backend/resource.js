const mongoose = require("mongoose");

const subtopicSchema = new mongoose.Schema({
  id: { type: String, required: true },
  title: { type: String, required: true },
  description: { type: String, required: true },
  icon: { type: String, required: true },
});

const resourceSchema = new mongoose.Schema({
    title: { type: String, required: true },
    description: { type: String, required: true },
    subtopics: [subtopicSchema],
  });
  
  module.exports = mongoose.model("Resource", resourceSchema);