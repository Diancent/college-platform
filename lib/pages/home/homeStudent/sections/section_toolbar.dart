import 'package:college_platform_mobile/widgets/home_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:college_platform_mobile/routs.dart' as route;

class SectionToolbar extends StatelessWidget {
  const SectionToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Панель інструментів",
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
          children: [
            const Padding(padding: EdgeInsets.symmetric(horizontal: 0)),
            HomeItem(
              title: "Не ",
              secondTitle: "верифіковані",
              icon: const Icon(
                Icons.badge_outlined,
                size: 35,
                color: Color.fromRGBO(30, 26, 82, 1),
              ),
              onPressed: () {
                Navigator.pushNamed(context, route.allUsersWithoutRoles);
              },
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
            HomeItem(
              title: "Додавання",
              secondTitle: "групи",
              icon: const Icon(
                Icons.add_box_outlined,
                size: 35,
                color: Color.fromRGBO(30, 26, 82, 1),
              ),
              onPressed: () {
                Navigator.pushNamed(context, route.addGroup);
              },
            ),
          ],
        ),
      ],
    );
  }
}
