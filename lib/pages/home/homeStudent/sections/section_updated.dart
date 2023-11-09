import 'package:flutter/material.dart';
import 'package:college_platform_mobile/routs.dart' as route;

import 'package:college_platform_mobile/lists/schedule_change_data.dart';
import 'package:college_platform_mobile/pages/scheduleChange/schedule_change_page.dart';
import 'package:college_platform_mobile/widgets/home_item.dart';
import 'package:flutter/cupertino.dart';

class SectionUpdated extends StatelessWidget {
  const SectionUpdated({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Тримаємо в курсі",
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
              title: "Події",
              secondTitle: "",
              icon: const Icon(
                Icons.calendar_month_outlined,
                size: 35,
                color: Color.fromRGBO(30, 26, 82, 1),
              ),
              onPressed: () {
                Navigator.pushNamed(context, route.events);
              },
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 18)),
            HomeItem(
              title: "Новини",
              secondTitle: "",
              icon: const Icon(
                Icons.campaign_rounded,
                size: 35,
                color: Color.fromRGBO(30, 26, 82, 1),
              ),
              onPressed: () {
                Navigator.pushNamed(context, route.newsFeed);
              },
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 18)),
            HomeItem(
              title: "Заміни",
              secondTitle: "",
              icon: const Icon(
                CupertinoIcons.repeat,
                size: 35,
                color: Color.fromRGBO(30, 26, 82, 1),
              ),
              onPressed: () {
                // Navigator.pushNamed(
                //   context,
                //   route.scheduleChange,
                //   arguments: scheduleData,
                // );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduleChangePage(
                      scheduleData: scheduleData,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
