var express = require('express');
var app = express();
var router=require('./routes/route');

app.use(function (req, res, next) {
    var weight = parseInt(req.query.weight),
        height = parseInt(req.query.height),
        unit = req.query.unit;
    
    if (!weight || !height || isNaN(weight) || isNaN(height)) {
        return res.status(400).json({ error: "invalid parameter or parameter missing" });
    }

    // set parameters
    req.unit = unit;

    req.weight = weight;
    req.height = height;

    return next();
});

// get API endpoint
app.get('/bmi',router);

app.listen(process.env.PORT || 3000,()=>{
    console.log(`Server running @ ${process.env.PORT || 3000}`);
})

module.exports = app;