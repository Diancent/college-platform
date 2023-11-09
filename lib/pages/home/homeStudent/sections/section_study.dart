import 'package:college_platform_mobile/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:college_platform_mobile/routs.dart' as route;

import 'package:college_platform_mobile/widgets/home_item.dart';
import 'package:flutter/cupertino.dart';

class SectionStudy extends StatelessWidget {
  final UserService userService;
  const SectionStudy({super.key, required this.userService});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Навчання",
          style: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(30, 26, 82, 1),
          ),
        ),
        const Divider(
          color: Color.fromRGBO(224, 225, 235, 1),
          height: 30,
          thickness: 1.8,
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomeItem(
              title: "Мій розклад",
              secondTitle: "занять",
              icon: const Icon(
                CupertinoIcons.table,
                size: 35,
                color: Color.fromRGBO(30, 26, 82, 1),
              ),
              onPressed: () {
                Navigator.pushNamed(context, route.schedule);
              },
            ),
            HomeItem(
              title: "Журнал",
              secondTitle: "",
              icon: const Icon(
                CupertinoIcons.square_list,
                size: 35,
                color: Color.fromRGBO(30, 26, 82, 1),
              ),
              onPressed: () {
                Navigator.pushNamed(context, route.gradeJournal);
              },
            ),
            HomeItem(
              title: "Список",
              secondTitle: "груп",
              icon: const Icon(
                CupertinoIcons.person_2_fill,
                size: 35,
                color: Color.fromRGBO(30, 26, 82, 1),
              ),
              onPressed: () {
                Navigator.pushNamed(context, route.allGroups);
              },
            ),
            HomeItem(
              title: "Список",
              secondTitle: "викладачів",
              icon: const Icon(
                CupertinoIcons.rectangle_stack_person_crop,
                size: 35,
                color: Color.fromRGBO(30, 26, 82, 1),
              ),
              onPressed: () {
                Navigator.pushNamed(context, route.allTeachers);
              },
            ),
          ],
        ),
      ],
    );
  }
}
