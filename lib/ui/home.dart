import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  State createState() => HomeState();
}

class HomeState extends State<Home> {

  final TextEditingController _userAge = new TextEditingController();
  final TextEditingController _userHeight = new TextEditingController();
  final TextEditingController _userWeight = new TextEditingController();
  double _calculatedBMI;
  String _messageCalculatedBMI = "";
  String _bodyConditionMessage = "";
  String _errorMessage = "";

  void _printResult(){
    setState(() {
      _calculatedBMI = _calculateBMI(_userHeight.text, _userWeight.text);
      _messageCalculatedBMI = "Your BMI: ${_calculatedBMI.toStringAsFixed(1)}";
      _bodyConditionMessage = _bodyCondition(_calculatedBMI);
    });
  }

  String _bodyCondition(double bmi){
    bmi = _calculatedBMI;
    /*
      If your BMI is:
      below 18.5 – you're in the underweight range
      between 18.5 and 24.9 – you're in the healthy weight range
      between 25 and 29.9 – you're in the overweight range
      between 30 and 39.9 – you're in the obese range 
    */
    if (bmi < 18.25){
      return "Underweight";
    }
    else if (bmi >= 12.25 && bmi < 25){
      return "Healthy";
    }
    else if(bmi >=25 && bmi < 30){
      return "Overweight";
    }
    else if (bmi > 30) {
      return "Obese";
    }
  }

  double _calculateBMI(String height, String weight){
    /*
      BMI Formula: 703 x weight (lbs) / [height (in)]2
    */
    if (int.parse(weight).toString().isNotEmpty && int.parse(weight) > 0){
      return ((703 *(double.parse(weight)))/((double.parse(height)*12) * (double.parse(height))*12));
    }
    else {
      _errorMessage="Please make sure to correctly give all necessary info!!";
      return double.parse('$_errorMessage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "BMI",
        ),
        centerTitle: true,
        backgroundColor: Colors.pink.shade200,
      ),
      body: new Container(
        alignment: Alignment.center,
        child: ListView(
          padding: const EdgeInsets.all(2.5),
          children: <Widget>[
            new Image.asset(
              './images/bmilogo.png',
              height: 120.0,
            ),
            new Container(
              margin: const EdgeInsets.all(3.0),
              color: Colors.grey.shade200,
              child: new Column(
                children: <Widget>[
                  // Age
                  new TextField(
                    controller: _userAge,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      hintText: "Age",
                      icon: Icon(Icons.person_outline),
                    ),
                  ),
                  // Height
                  new TextField(
                    controller: _userHeight,
                    keyboardType:  TextInputType.numberWithOptions(decimal: true),
                    decoration: new InputDecoration(
                      hintText: "Height in Feet",
                      icon: Icon(Icons.insert_chart),
                    ),
                  ),
                  // Weight
                  new TextField(
                    controller: _userWeight,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: new InputDecoration(
                      hintText: "Weight in lb",
                      icon: Icon(Icons.line_weight),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(10.5),
                  ),
                  new Center(
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          child: new RaisedButton(
                            onPressed: () => _printResult(),
                            color: Colors.pink.shade200,
                            child: new Text(
                              'Calculate',
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 16.9,
                              ),
                            ),
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.all(5.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(3.0),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  "$_messageCalculatedBMI",
                  style: new TextStyle(
                    color: Colors.blue[300],
                    fontSize: 25.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(3.0),
                ),
                new Text(
                  "$_bodyConditionMessage",
                  style: new TextStyle(
                    color: Colors.pink.shade200,
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
