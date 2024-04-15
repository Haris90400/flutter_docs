//packages
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const authRouter = require('./routes/auth');
require('dotenv').config();

const PORT = 3001;
const DB = process.env.MONGODB_URL;

const app = express();
app.use(cors());

//Middleware
app.use(express.json());
app.use(authRouter);

//mongodb connection
mongoose.connect(DB).then(()=>{
    console.log("Connection Successful");
});

//start server
app.listen(PORT,process.env.IP_ADDRESS,()=>{
    console.log('Connected at port :'+PORT)
});

