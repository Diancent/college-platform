import 'package:flutter/material.dart';

class TeacherItem extends StatelessWidget {
  final String nameOfTeacher, subjectName;
  final Function()? onTap;
  const TeacherItem(
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
              const CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 30,
              ),
              const SizedBox(width: 10),
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
