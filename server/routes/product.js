const auth = require("../middlewares/auth");
const express = require("express");
const Product = require("../models/product");
const productRouter = express.Router();

productRouter.get('/api/products', auth, async (req, res) => {
    try{
        console.log(req.query.category);
        const products = await Product.find({category: req.query.category});
        res.json(products);
    } catch(e) {
        res.status(500).json({error: e.message});
    }
});

productRouter.get('/api/search/:name', auth, async (req, res) => {
    try{
        const products = await Product.find({
            name: { $regex: req.params.name, $options: "i" },
        });
        res.json(products);
    } catch(e) {
        res.status(500).json({error: e.message});
    }
});

productRouter.post('/api/rate-product', auth, async (req, res) => {
    try {
        const {id, rating} = req.body;
        let product = await Product.findById(id);

        for(let i=0; i<product.ratings.length; i++){
            if (product.ratings[i].userId == id){
                product.ratings.splice(i, 1);
                break;
            }
        }
    } catch(e) {
        res.status(500).json({error: e.message});
    }
})

module.exports = productRouter;