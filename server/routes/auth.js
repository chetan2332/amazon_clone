const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/user");
const auth = require("../middlewares/auth");

const authRouter = express.Router();

authRouter.post('/api/signup', async (req, res) => {
    // get the data from client side
    const {name, email, password} = req.body;

    // validate user email
    try {
        const existingUser = await User.findOne({email});
        if(existingUser) {
            return res.status(400).json({msg: "User with the same email already exists"});
        }

        // create user in database

        const hashedPassword = await bcryptjs.hash(password, 6);
        let user = new User({
            email,
            password: hashedPassword,
            name,
        })
        user = await user.save();
        res.json(user);
    } catch(e) {
        res.status(500).json({error: e.message});
    }
});

// sign in route
authRouter.post('/api/signin', async (req, res) => {
    try{
        const {email, password} = req.body;
        const user = await User.findOne({email});
        if(!user){
            return res
                .status(400)
                .json({msg: "User with this email does not exist."});
        }
        const isMatch = await bcryptjs.compare(password, user.password);
        if(!isMatch){
            return res
                .status(400)
                .json({msg: "Incorrect Password."});   
        }
        const token = jwt.sign({id: user._id}, "passwordKey");
        res.json({ token, ...user._doc });
    } catch(e) {
        res.status(500).json({error: e.message});
    }
});

authRouter.post("/tokenIsValid", async (req, res) => {
    try{

        const token = req.header('x-auth-token');
        if(!token) return res.json(false);

        const verified = jwt.verify(token, "passwordKey");
        if(!verified) return res.json(false);
        console.log(verified);
        const user = await User.findById(verified.id);
        console.log(user);
        if(!user) return res.json(false);
        res.json(true);
        
    } catch(e) {
        res.status(500).json({error: e.message});
    }
});

// get user data
authRouter.get('/', auth, async(req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token});
});

module.exports = authRouter;