// File: server.js
const express = require('express');
const mongoose = require('mongoose');
const authRoutes = require('./routes/auth');

const app = express();

// Middleware
app.use(express.json());

// MongoDB Connection
mongoose.connect('mongodb://localhost:27017/auth-db', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', () => {
  console.log('Connected to MongoDB');
});

// Routes
app.use('/api', authRoutes);

// Start Server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});