import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '0';

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '0';
      } else if (value == 'D') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else if (value == '=') {
        try {
          Parser p = Parser();
          Expression exp =
              p.parse(_expression.replaceAll('×', '*').replaceAll('÷', '/'));
          ContextModel cm = ContextModel();
          _result = exp.evaluate(EvaluationType.REAL, cm).toString();
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += value;
      }
    });
  }

  Widget _buildButton(String value, Color textColor, Color buttonColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(value),
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: textColor,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            textStyle: const TextStyle(fontSize: 24),
          ),
          child: Text(value),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _expression,
              style: const TextStyle(fontSize: 36, color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _result,
              style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton('D', Colors.white, Colors.blueGrey),
                  _buildButton('C', Colors.white, Colors.blueGrey),
                  _buildButton('%', Colors.white, Colors.orange),
                  _buildButton('÷', Colors.white, Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton('7', Colors.white, Colors.black54),
                  _buildButton('8', Colors.white, Colors.black54),
                  _buildButton('9', Colors.white, Colors.black54),
                  _buildButton('×', Colors.white, Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton('4', Colors.white, Colors.black54),
                  _buildButton('5', Colors.white, Colors.black54),
                  _buildButton('6', Colors.white, Colors.black54),
                  _buildButton('-', Colors.white, Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton('1', Colors.white, Colors.black54),
                  _buildButton('2', Colors.white, Colors.black54),
                  _buildButton('3', Colors.white, Colors.black54),
                  _buildButton('+', Colors.white, Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton('0', Colors.white, Colors.black54),
                  _buildButton('.', Colors.white, Colors.black54),
                  _buildButton('=', Colors.white, Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
