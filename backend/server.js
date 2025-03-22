require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const resourceRoutes = require("./routes/resources");

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

//Routes
app.use("/api/resoureces", resourceRoutes);

// Connect to MongoDB
mongoose.connect(process.env.MONGODB_URI) 
    .then(() => console.log("Connected to MongoDB"))
    .catch((err) => console.log("MongoDB connection error:", err));

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server started on port ${PORT}`));

