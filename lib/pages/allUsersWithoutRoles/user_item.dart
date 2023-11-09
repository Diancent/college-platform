import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final String nameOfTeacher, subjectName;
  final Function()? onTap;
  const UserItem(
      {super.key,
      required this.nameOfTeacher,
      required this.subjectName,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              // const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameOfTeacher,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    subjectName,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
