import 'package:flutter/material.dart';

import '../dictionary/dictionary_student_info.dart';

class InformationItem extends StatelessWidget {
  String firstText, secondText;
  InformationItem(
      {super.key, required this.firstText, required this.secondText});

  // String name = studentInfo['Ім\'я'];
  // DateTime dateOfAdmission = studentInfo['Дата вступу'];

  @override
  Widget build(BuildContext context) {
    //   List<Widget> studentInfoWidgets = [];

    //   studentInfo.forEach((key, value) {
    //     var keyText = Text(
    //       key + ':',
    //       style: TextStyle(fontWeight: FontWeight.bold),
    //     );
    //     var valueText = Text(value.toString());
    //     studentInfoWidgets.add(
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [keyText, valueText],
    //       ),
    //     );
    //   });

    //Widget studentInfoWidget = Row(children: studentInfoWidgets);
    return Column(
      children: [
        Container(
          height: 48,
          padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // studentInfoWidget,
              Text(
                firstText,
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                secondText,
                style: const TextStyle(
                  color: Color.fromRGBO(30, 26, 82, 1),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
