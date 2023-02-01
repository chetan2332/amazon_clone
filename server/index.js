// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");

// IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter =require("./routes/product");

// INIT
const app = express();
const PORT = 3000;
const DB = "mongodb+srv://chetan:chetan233257@cluster0.wikics7.mongodb.net/?retryWrites=true&w=majority";

// middlewares
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);

// connections
mongoose.set('strictQuery', true);
mongoose.connect(DB).then(() => {
    console.log('Connection Sucessful');
}).catch((e)=> {
    console.log(e);
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port ${PORT}`);
})