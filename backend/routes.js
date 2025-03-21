const express = require("express");
const Resource = require("../models/Resource");
const router = express.Router();

// Fetch all resources
router.get("/", async (req, res) => {
  try {
    const resources = await Resource.find();
    res.json(resources);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});