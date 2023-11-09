import 'package:flutter/material.dart';

import 'package:college_platform_mobile/pages/student/student_screen.dart';
import 'package:flutter/cupertino.dart';

class GroupListScreen extends StatefulWidget {
  const GroupListScreen({super.key});

  @override
  State<GroupListScreen> createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            const SizedBox(width: 8),
            IconButton(
              color: Colors.white,
              icon: const Icon(CupertinoIcons.chevron_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(30, 26, 82, 1),
        elevation: 0,
        title: const Text("КІ-192"),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
        // centerTitle: true,
      ),
      body: ListView(children: [
        section("Люди в групі"),
        Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(0.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              section("Куратор"),
              studentCell("Ковальова Олександра Сергіївна"),
              divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 58,
                    padding:
                        const EdgeInsets.only(left: 24, top: 20, bottom: 20),
                    child: const Text(
                      "Студенти",
                      style: TextStyle(
                        color: Color.fromRGBO(127, 127, 127, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.people_outline_outlined,
                        color: Colors.grey,
                        size: 22,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "24",
                        style: TextStyle(
                          color: Color.fromRGBO(127, 127, 127, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  )
                ],
              ),
              studentCell("1. Бабчинській Ілля"),
              divider(),
              studentCell("2. Бакалець Назар"),
              divider(),
              studentCell("3. Баклажко Вадим"),
              divider(),
              studentCell("4. Білоока Анна"),
              divider(),
              studentCell("5. Боєв Денис"),
              divider(),
              studentCell("6. Дмітрієв Богдан"),
              divider(),
              studentCell("7. Дреус Максим"),
              divider(),
              studentCell("8. Дудченко Дмитро"),
              divider(),
              studentCell("9. Душко Андрій"),
              divider(),
              studentCell("10. Зваричук Олександр"),
              divider(),
              studentCell("11. Ільченко Владислав"),
              divider(),
              studentCell("12. Кобринський Вадим"),
              divider(),
              studentCell("13. Корольчук Артем"),
              divider(),
              studentCell("14. Малиночко Богдан"),
              divider(),
              studentCell("15. Мельник Ярослав"),
              divider(),
              studentCell("16. Науменко Роман"),
              divider(),
              studentCell("17. Нестеров Орест"),
              divider(),
              studentCell("18. Півовар Ярослав"),
              divider(),
              studentCell("19. Попик Ілля"),
              divider(),
              studentCell("20. Рогожан Владислав"),
              divider(),
              studentCell("21. Романець Віталій"),
              divider(),
              studentCell("22. Саврацький Іван"),
              divider(),
              studentCell("23. Тарасюк Ерік"),
              divider(),
              studentCell("24. Цвігун Владислав"),
            ],
          ),
        ),
      ]),
    );
  }

  Container section(String label) {
    return Container(
      height: 58,
      padding: const EdgeInsets.only(left: 24, top: 20, bottom: 20),
      child: Text(
        label,
        style: const TextStyle(
          color: Color.fromRGBO(127, 127, 127, 1),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  CupertinoButton studentCell(String label) {
    return CupertinoButton(
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     // builder: (context) => StudentScreen(),
        //   ),
        // );
      },
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Divider divider() {
    return const Divider(
      color: Colors.grey,
      height: 1,
    );
  }
}
