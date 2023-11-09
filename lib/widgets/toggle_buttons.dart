import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

const List<Widget> isBudget = <Widget>[Text('Бюджет'), Text('Контракт')];

class MyToggleButtons extends StatefulWidget {
  const MyToggleButtons({super.key});

  @override
  State<MyToggleButtons> createState() => _MyToggleButtonsState();
}

class _MyToggleButtonsState extends State<MyToggleButtons> {
  int _selectedIsBudgetIndex = 0;
  List<bool> _selectedIsBudget = [false, false];
  bool vertical = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Тип фінансування",
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 5),
        ToggleButtons(
          direction: vertical ? Axis.vertical : Axis.horizontal,
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0;
                  buttonIndex < _selectedIsBudget.length;
                  buttonIndex++) {
                if (buttonIndex == index) {
                  _selectedIsBudget[buttonIndex] =
                      !_selectedIsBudget[buttonIndex];
                } else {
                  _selectedIsBudget[buttonIndex] = false;
                }
              }
            });
          },
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          selectedBorderColor: const Color.fromRGBO(30, 26, 82, 1),
          selectedColor: Colors.white,
          fillColor: const Color.fromRGBO(30, 26, 82, 1),
          color: const Color.fromRGBO(30, 26, 82, 1),
          constraints: const BoxConstraints(
            minHeight: 40.0,
            minWidth: 80.0,
          ),
          isSelected:
              _selectedIsBudget, // Використовуємо змінну _selectedIsBudgetIndex
          children: isBudget,
        ),
      ],
    );
  }
}
