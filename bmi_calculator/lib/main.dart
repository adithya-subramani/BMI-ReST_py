import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(BMICalculator());

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  String result = '';
  String bmi='',desc='';
  bool isMetric = true;
  Color? _bmiColor;

  Future<List<String>> calculateBMI(double height, double weight,String unit) async {
    final response = await http.get(
      Uri.parse('https://bmi-rest-api.onrender.com/bmi?height=$height&weight=$weight&unit=$unit'),
    );
    if (response.statusCode == 200) {
      return [(json.decode(response.body)['result']['bmi']).toStringAsFixed(2),(json.decode(response.body)['result']['desc']).toString()];
    } else {
      throw Exception('Failed to calculate BMI');
    }
  }

  Color? getBMIColor(double bmi) {
    if (bmi < 18.5) {
      return Colors.yellow[700];
    } else if (bmi < 25) {
      return Colors.green[700];
    } else if (bmi < 30) {
      return Colors.orange[700];
    } else {
      return Colors.red[700];
    }
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('BMI Calculator'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          // padding: EdgeInsets.only(top: -16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Calculate your BMI here!'),
              SizedBox(height: 16),
              TextField(
                controller: heightController,
                decoration: InputDecoration(
                  labelText: 'Height',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: weightController,
                decoration: InputDecoration(
                  labelText: 'Weight',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Imperial (in,lb)'),
                  Switch(
                    value: isMetric,
                    onChanged: (value) {
                      setState(() {
                        isMetric = value;
                      });
                    },
                  ),
                  Text('Metric (cm,kg)'),
                ],
              ),
              SizedBox(height: 16),
              RaisedButton(
                child: Text('Calculate BMI'),
                onPressed: () async {
                  double height = double.parse(heightController.text);
                  double weight = double.parse(weightController.text);
                  List<String>res = await calculateBMI(height, weight,(isMetric)?'metric':'imperial');
                  setState(() {
                    bmi = res[0];
                    desc = res[1];
                    _bmiColor = getBMIColor(double.parse(bmi));
                  });
                },
              ),
              SizedBox(height: 16),
              Text(
                bmi,
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _bmiColor,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 10,
                        color: Colors.blue,
                        child: Text(
                          'Underweight',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 10,
                        color: Colors.green,
                        child: Text(
                          'Normal',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 10,
                        color: Colors.orange,
                        child: Text(
                          'Overweight',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 10,
                        color: Colors.red,
                        child: Text(
                          'Obese',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
