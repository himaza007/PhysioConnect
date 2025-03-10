require("dotenv").config();
const express = require("express");
const connectDB = require("./db");

// Initialize Express App
const app = express();

// Connect to MongoDB
connectDB();

// Middleware
app.use(express.json()); // For JSON requests

// Test Route
app.get("/", (req, res) => {
  res.send("PhysioConnect Progress Tracking API is Running...");
});

// Server Listener
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
