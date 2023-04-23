module.exports = {
    getIndex : function getIndex(weight, height, unit ='metric') {
            if(typeof(weight) === 'number' && typeof(height) === 'number') {
                return ((weight*((unit==='metric')?10000.0:703.0)) / (height * height));
            }
    },
    getDescription : function getDescription(index) {
        if (index < 16) {
            return "Severely underweight";
        } else if (index < 17) {
            return "Underweight";
        } else if (index < 18.5) {
            return "Skinny";
        } else if (index < 25.0) {
            return "Normal";
        } else if (index < 30.0) {
            return "Overweight";
        } else{
            return "Obese";
        }
    }
};