import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  String output = "";

  final List<String> buttons = [
    "C", "⌫", "%", "/",
    "1", "2", "3", "x",
    "4", "5", "6", "-",
    "7", "8", "9", "+",
    "", "0", ".", "EXE",
  ];

  void buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        output = "";
      } else if (value == "⌫") {
        if (output.isNotEmpty) {
          output = output.substring(0, output.length - 1);
        }
      } else if (value == "EXE") {
        try {
          final userInput = output.replaceAll('x', '*');
          Parser p = Parser();
          Expression exp = p.parse(userInput);
          ContextModel cm = ContextModel();
          final result = exp.evaluate(EvaluationType.REAL, cm);

          if (result == result.toInt()){
            output = result.toInt().toString();
          } else {
            output = result.toString();
          }
        } catch (e) {
          output = "Error";
        }
      } else {
        output += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Output area
        Container(
          padding: const EdgeInsets.all(24),
          alignment: Alignment.bottomRight,
          color: const Color(0xFF86469C),
          height: 210,
          child: Text(
            output,
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        // Fixed-size GridView for buttons
        SizedBox(
          height: MediaQuery.of(context).size.height - 160 - kBottomNavigationBarHeight - 80,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(), // Disable scrolling
            padding: const EdgeInsets.all(12),
            itemCount: buttons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final btnText = buttons[index];
              final bool isOperator = ["C", "⌫", "%", "/", "x", "-", "+", "EXE"].contains(btnText);

              return btnText.isEmpty
                  ? const SizedBox.shrink()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFB9AD1),
                        foregroundColor: isOperator ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => buttonPressed(btnText),
                      child: Text(
                        btnText,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: isOperator ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }
}
