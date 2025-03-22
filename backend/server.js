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

