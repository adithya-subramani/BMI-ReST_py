const express = require("express");
const bmiCalc = require("../controllers/bmiCalc");
const router = express.Router();

module.exports = function (req, res, next) {
    return res.json(
        {
            result: {
                bmi : bmiCalc.getIndex(req.weight, req.height, req.unit),
                description : bmiCalc.getDescription(bmiCalc.getIndex(req.weight, req.height, req.unit))
            }
        }
    );
};


// module.exports = router;