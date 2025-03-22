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

// Fetch a specific resource by ID
router.get("/:id", async (req, res) => {
    try {
      const resource = await Resource.findById(req.params.id);
      if (!resource) return res.status(404).json({ message: "Resource not found" });
      res.json(resource);
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  });
  
  // Add a new resource (admin-only)
  router.post("/", async (req, res) => {
    const { title, description, subtopics } = req.body;
    const resource = new Resource({ title, description, subtopics });
    try {
      const newResource = await resource.save();
      res.status(201).json(newResource);
    } catch (error) {
      res.status(400).json({ message: error.message });
    }
  });

  // Update a resource (admin-only)
  router.put("/:id", async (req, res) => {
    try {
        const resources = await Resource.findByIdAndUpdate(req.params.id, req.body, {new: true});
        if (!resources) return res.status(404).json({ message: "Resource not found" });
        res.json(resources);
    } catch (error){
        res.status(500).json({ message: error.message });
    }
  });

  // Delete a resource (admin-only)
  router.delete("/:id", async (req, res) => {
    try {
        const resources = await Resource.findByIdAndDelete(req.params.id);
        if (!resources) return res.status(404).json({ message: "Resource not found" });
        res.json({ message: "Resource deleted successfully" });
    } catch (error){
        res.status(500).json({ message: error.message });
    }
  });

module.exports = router;

