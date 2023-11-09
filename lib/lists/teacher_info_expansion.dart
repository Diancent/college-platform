import 'package:flutter/material.dart';

import '../dictionary/dictionary_student_info.dart';
import '../dictionary/dictionary_teacher_info.dart';
import '../models/ExpansionPanelItem.dart';
import '../widgets/information_item.dart';

final List<ExpansionPanelItemModel> expandedList = [
  ExpansionPanelItemModel(
    headerValue: 'Освіта',
    widgets: [
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          children: [
            Text(teacherInfo['Освіта']),
          ],
        ),
      ),
    ],
  ),
  ExpansionPanelItemModel(
    headerValue: 'Кваліфікація',
    widgets: [
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          children: [
            Text("Спеціаліст вищої категорії, кандидат майстри спорту футбол"),
          ],
        ),
      ),
    ],
  ),
];
