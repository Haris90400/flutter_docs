//packages
const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');
require('dotenv').config();

const PORT = 3001;
const DB = process.env.MONGODB_URL;

const app = express();

//Middleware
app.use(express.json());
app.use(authRouter);

//mongodb connection
mongoose.connect(DB).then(()=>{
    console.log("Connection Successful");
});

//start server
app.listen(PORT,"0.0.0.0",()=>{
    console.log('Connected at port :'+PORT)
});

