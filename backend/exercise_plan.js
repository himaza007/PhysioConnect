const express = require('express');
const router = express.Router();
const ExercisePlan = require('../models/ExercisePlan');

// GET all exercise plans
router.get('/', async (req, res) => {
  try {
    const plans = await ExercisePlan.find();
    res.json(plans);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// GET exercise plans by category
router.get('/category/:category', async (req, res) => {
  try {
    const plans = await ExercisePlan.find({ category: req.params.category });
    res.json(plans);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// POST a new exercise plan
router.post('/', async (req, res) => {
  const { title, description, instructions, category } = req.body;
  const plan = new ExercisePlan({ title, description, instructions, category });

  try {
    const newPlan = await plan.save();
    res.status(201).json(newPlan);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// DELETE an exercise plan
router.delete('/:id', getPlan, async (req, res) => {
  try {
    await res.plan.remove();
    res.json({ message: 'Deleted Exercise Plan' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Middleware to get a plan by ID
async function getPlan(req, res, next) {
  let plan;
  try {
    plan = await ExercisePlan.findById(req.params.id);
    if (!plan) return res.status(404).json({ message: 'Cannot find plan' });
  } catch (err) {
    return res.status(500).json({ message: err.message });
  }

  res.plan = plan;
  next();
}

module.exports = router;