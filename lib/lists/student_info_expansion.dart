import 'package:flutter/material.dart';

import '../dictionary/dictionary_student_info.dart';
import '../models/ExpansionPanelItem.dart';
import '../widgets/information_item.dart';

final List<ExpansionPanelItemModel> expandedList = [
  ExpansionPanelItemModel(
    headerValue: 'Персональна інформація',
    widgets: [
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          children: [
            InformationItem(
              firstText: "Дата вступу",
              secondText: studentInfo['Дата вступу'],
            ),
            InformationItem(
              firstText: "Переведений на бюджет",
              secondText: studentInfo['Переведений на бюджет'],
            ),
            InformationItem(
              firstText: "Дата переводу на бюджет",
              secondText: studentInfo['Дата переводу на бюджет'],
            ),
            InformationItem(
              firstText: "Номер телефону студента",
              secondText: '${studentInfo['Номер телефону студента']}',
            ),
            InformationItem(
              firstText: "Місце проживання",
              secondText: studentInfo['Місце проживання'],
            ),
            InformationItem(
              firstText: "Дата Народження",
              secondText: studentInfo['Дата народження'],
            ),
          ],
        ),
      ),
    ],
  ),
  ExpansionPanelItemModel(
    headerValue: 'Інформація про батьків',
    widgets: [
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          children: [
            InformationItem(
              firstText: "Ім'я матері",
              secondText: studentInfo['Ім\'я матері'],
            ),
            InformationItem(
              firstText: "Номер телефону матері",
              secondText: '${studentInfo['Номер телефону матері']}',
            ),
            InformationItem(
              firstText: "Назва організації матері",
              secondText: studentInfo['Назва організації матері'],
            ),
            InformationItem(
              firstText: "Назва посади матері",
              secondText: studentInfo['Назва посади матері'],
            ),
            InformationItem(
              firstText: "Ім'я батька",
              secondText: studentInfo['Ім\'я батька'],
            ),
            InformationItem(
              firstText: "Номер телефону батька",
              secondText: '${studentInfo['Номер телефону батька']}',
            ),
            InformationItem(
              firstText: "Назва організації батька",
              secondText: studentInfo['Назва організації батька'],
            ),
            InformationItem(
              firstText: "Назва посади батька",
              secondText: studentInfo['Назва посади батька'],
            ),
          ],
        ),
      ),
    ],
  ),
  ExpansionPanelItemModel(
    headerValue: 'Особливі умови',
    widgets: [
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          children: [
            InformationItem(
              firstText: "Сирота чи напівсирота",
              secondText: studentInfo['Сирота чи напівсирота'] ? 'так' : 'ні',
            ),
            InformationItem(
              firstText: "Розлучені батьки",
              secondText: studentInfo['Розлучені батьки'] ? 'так' : 'ні',
            ),
            InformationItem(
              firstText: "Малозабезпечена сім'я",
              secondText: studentInfo['Малозабезпечена сім\'я'] ? 'так' : 'ні',
            ),
            InformationItem(
              firstText: "Одноосібне виховання",
              secondText: studentInfo['Одноосібне виховання'] ? 'так' : 'ні',
            ),
            InformationItem(
              firstText: "Багатодітна",
              secondText: studentInfo['Багатодітна'] ? 'так' : 'ні',
            ),
            InformationItem(
              firstText: "Чорнобилець",
              secondText: studentInfo['Чорнобилець'] ? 'так' : 'ні',
            ),
            InformationItem(
              firstText: "Дитина учасників УБД",
              secondText: studentInfo['Дитина учасників УБД'] ? 'так' : 'ні',
            ),
            InformationItem(
              firstText: "Тимчасово переміщена особа",
              secondText:
                  studentInfo['Тимчасово переміщена особа'] ? 'так' : 'ні',
            ),
            InformationItem(
              firstText: "Інвалід",
              secondText: studentInfo['Інвалід'] ? 'так' : 'ні',
            ),
          ],
        ),
      ),
    ],
  ),
  ExpansionPanelItemModel(
    headerValue: 'Оцінки за вступні екзамени',
    widgets: [
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          children: [
            InformationItem(
              firstText: "Бали за вступний екзамен з української мови",
              secondText:
                  '${studentInfo['Бали за вступний екзамен з української мови']}',
            ),
            InformationItem(
              firstText: "Бали за вступний екзамен з математики",
              secondText:
                  '${studentInfo['Бали за вступний екзамен з математики']}',
            ),
            InformationItem(
              firstText: "Оцінка атестату",
              secondText: '${studentInfo['Оцінка атестату']}',
            ),
            InformationItem(
              firstText: "Конкурсний бал",
              secondText: '${studentInfo['Конкурсний бал']}',
            ),
          ],
        ),
      ),
    ],
  ),
];
