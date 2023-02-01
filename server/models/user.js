const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    name : {
        required: true,
        type : String,
        trim : true,
    },
    email : {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^[a-zA-Z0-9_.+]+(?<!^[0-9]*)@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
                return value.match(re);
            },
            message: 'Please enter a valid email address',
        }
    },
    password : {
        required: true,
        type: String,
    },
    address: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'user',
    },
    // cart
});

const User = mongoose.model("User", userSchema);
module.exports = User;