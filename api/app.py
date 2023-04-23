from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/bmi', methods=['GET'])
def calculate_bmi():
    height = float(request.args.get('height'))
    weight = float(request.args.get('weight'))
    unit = request.args.get('unit')

    bmi = calculate_bmi_value(height, weight, unit)
    category = get_bmi_category(bmi)

    response = {'result':{
        'bmi': bmi,
        'desc': category
    }}

    return jsonify(response)

def calculate_bmi_value(height, weight, unit='metric'):
    if unit.lower() == 'metric':
        return 10000 * weight / (height ** 2)
    else:
        return 703 * weight / (height ** 2)

def get_bmi_category(bmi):
    if bmi < 16:
        return 'Severely Underweight'
    elif bmi < 17:
        return 'Underweight'
    elif bmi < 18.5:
        return 'Skinny'
    elif bmi < 25:
        return 'Normal'
    elif bmi < 30:
        return 'Overweight'
    else:
        return 'Obese'

if __name__ == '__main__':
    app.run()
