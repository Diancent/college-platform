import 'package:flutter/material.dart';

import '../widgets/information_item.dart';

List<Widget> widgetListPersonalInformation = [
  const Text(
    "Персональна інформація студента",
    style: TextStyle(
      fontSize: 14,
    ),
  ),
  InformationItem(firstText: "Дата вступу", secondText: "1 вересня 2019"),
  InformationItem(firstText: "Переведений на бюджет", secondText: "так"),
  InformationItem(
      firstText: "Дата переводу на бюджет", secondText: "28 червня 2020"),
  InformationItem(
      firstText: "Номер телефону студента", secondText: "+380683423970"),
  InformationItem(
      firstText: "Місце проживання", secondText: "вул. Шевченка 19"),
  InformationItem(firstText: "Дата Народження", secondText: "25 січня 2004"),
];
List<Widget> widgetListParents = [
  const Text(
    "Інформація про батьків",
    style: TextStyle(
      fontSize: 14,
    ),
  ),
  Divider(
    color: Colors.grey,
    height: 1,
  ),
  InformationItem(firstText: "Ім'я матері", secondText: "Ірина Володимирівна"),
  InformationItem(
      firstText: "Номер телефону матері", secondText: "+380974426439"),
  InformationItem(firstText: "Назва організації матері", secondText: "---"),
  InformationItem(firstText: "Назва посади матері", secondText: "---"),
  InformationItem(firstText: "Ім'я батька", secondText: "Ім'я батька"),
  InformationItem(
      firstText: "Номер телефону батька", secondText: "+380974235700"),
  InformationItem(firstText: "Назва організації батька", secondText: "---"),
  InformationItem(firstText: "Назва посади батька", secondText: "---"),
];
List<Widget> widgetListParentsSpecialConditions = [
  const Text(
    "Особливі умови",
    style: TextStyle(
      fontSize: 14,
    ),
  ),
  InformationItem(firstText: "Сирота чи напівсирота", secondText: "ні"),
  InformationItem(firstText: "Розлучені батьки", secondText: "ні"),
  InformationItem(firstText: "Малозабезпечена сім'я", secondText: "ні"),
  InformationItem(firstText: "Одноосібне виховання", secondText: "ні"),
  InformationItem(firstText: "Багатодітна", secondText: "ні"),
  InformationItem(firstText: "Чорнобилець", secondText: "ні"),
  InformationItem(firstText: "Дитина УБД", secondText: "ні"),
  InformationItem(firstText: "Тимчасово переміщена особа", secondText: "ні"),
  InformationItem(firstText: "Інвалід", secondText: "ні"),
];
List<Widget> widgetListGradesForEntranceExams = [
  const Text(
    "Оцінки за вступні екзамени",
    style: TextStyle(
      fontSize: 14,
    ),
  ),
  InformationItem(
      firstText: "Бали за вступний екзамен з української мови",
      secondText: "12"),
  InformationItem(
      firstText: "Бали за вступний екзамен з математики", secondText: "12"),
  InformationItem(firstText: "Оцінка атестату", secondText: "12"),
  InformationItem(firstText: "Конкурсний бал", secondText: "12"),
];
