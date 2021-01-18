import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";
  String equation = "0";
  String expression;

  _buttonPressed(String btnTxt) {
    setState(() {
      if (btnTxt == 'C') {
        equation = "0";
        output = "0";
      } else if (btnTxt == 'Del') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (btnTxt == '=') {
        expression = equation;

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          output = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          output = "Error";
        }
      } else {
        if (equation == "0") {
          equation = btnTxt;
        } else {
          equation = equation + btnTxt;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    equation,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Divider(
                    height: 10,
                    color: Colors.grey,
                  ),
                  Text(
                    output,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 10,
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildKeyButton("C", context)),
                    Expanded(child: _buildKeyButton("Del", context)),
                    // Expanded(child: _buildKeyButton("%", context)),
                    Expanded(child: _buildKeyButton("/", context)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildKeyButton("7", context)),
                    Expanded(child: _buildKeyButton("8", context)),
                    Expanded(child: _buildKeyButton("9", context)),
                    Expanded(child: _buildKeyButton("*", context)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildKeyButton("4", context)),
                    Expanded(child: _buildKeyButton("5", context)),
                    Expanded(child: _buildKeyButton("6", context)),
                    Expanded(child: _buildKeyButton("-", context)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildKeyButton("1", context)),
                    Expanded(child: _buildKeyButton("2", context)),
                    Expanded(child: _buildKeyButton("3", context)),
                    Expanded(child: _buildKeyButton("+", context)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildKeyButton("00", context)),
                    Expanded(child: _buildKeyButton("0", context)),
                    Expanded(child: _buildKeyButton(".", context)),
                    Expanded(child: _buildKeyButton("=", context)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyButton(btnTxt, context) {
    return Container(
      margin: EdgeInsets.all(4),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey[850],
        child: FlatButton(
          onPressed: () => _buttonPressed(btnTxt),
          child: Text(
            btnTxt,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
