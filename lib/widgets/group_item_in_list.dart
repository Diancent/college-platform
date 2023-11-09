import 'package:flutter/material.dart';
import 'package:college_platform_mobile/routs.dart' as route;

class GroupItemInList extends StatelessWidget {
  final String title, course;
  final Function()? onTap;
  const GroupItemInList(
      {super.key, required this.title, required this.course, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Container(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  course,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, route.groupList);
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
