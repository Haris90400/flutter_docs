//packages
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const http = require('http');
const authRouter = require('./routes/auth');
require('dotenv').config();
const documentRouter = require('./routes/document');

const PORT = 3001;
const DB = process.env.MONGODB_URL;

const app = express();
var server = http.createServer(app);
var io = require('socket.io')[server];
app.use(cors());

//Middleware
app.use(express.json());
app.use(authRouter);
app.use(documentRouter);

//mongodb connection
mongoose.connect(DB).then(()=>{
    console.log("Connection Successful");
});

//start socket
io.on("connection",(socket)=>{
    console.log('Connected '+socket.id);
});

//start server
app.listen(PORT,process.env.IP_ADDRESS,()=>{
    console.log('Connected at port :'+PORT)
});

