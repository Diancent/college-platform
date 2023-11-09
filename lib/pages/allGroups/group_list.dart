import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/group_item_in_list.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Комп'ютерна інженерія",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        Divider(
          color: Color.fromRGBO(224, 225, 235, 1),
          height: 30,
          thickness: 1.8,
        ),
        GroupItemInList(
          title: "KI-191",
          course: "4 курс",
        ),
        GroupItemInList(
          title: "KI-192",
          course: "",
        ),
        GroupItemInList(
          title: "KI-193",
          course: "",
        ),
        Divider(
          color: Color.fromRGBO(224, 225, 235, 1),
          height: 0,
          thickness: 1.8,
        ),
        SizedBox(height: 20),
        GroupItemInList(
          title: "KI-201",
          course: "3 курс",
        ),
        GroupItemInList(
          title: "KI-202",
          course: "",
        ),
        GroupItemInList(
          title: "KI-203",
          course: "",
        ),
        Divider(
          color: Color.fromRGBO(224, 225, 235, 1),
          height: 0,
          thickness: 1.8,
        ),
        SizedBox(height: 20),
        GroupItemInList(
          title: "KI-211",
          course: "2 курс",
        ),
        GroupItemInList(
          title: "KI-212",
          course: "",
        ),
        GroupItemInList(
          title: "KI-213",
          course: "",
        ),
        Divider(
          color: Color.fromRGBO(224, 225, 235, 1),
          height: 0,
          thickness: 1.8,
        ),
        SizedBox(height: 20),
        GroupItemInList(
          title: "KI-221",
          course: "1 курс",
        ),
        GroupItemInList(
          title: "KI-222",
          course: "",
        ),
        GroupItemInList(
          title: "KI-223",
          course: "",
        ),
        Divider(
          color: Color.fromRGBO(224, 225, 235, 1),
          height: 0,
          thickness: 1.8,
        ),
        SizedBox(height: 50),
        Text(
          "Програмна інженерія",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        Divider(
          color: Color.fromRGBO(224, 225, 235, 1),
          height: 30,
          thickness: 1.8,
        ),
        GroupItemInList(
          title: "ПI-191",
          course: "4 курс",
        ),
        GroupItemInList(
          title: "ПI-192",
          course: "",
        ),
        Divider(
          color: Color.fromRGBO(224, 225, 235, 1),
          height: 0,
          thickness: 1.8,
        ),
        SizedBox(height: 20),
        GroupItemInList(
          title: "ПI-201",
          course: "3 курс",
        ),
        GroupItemInList(
          title: "ПI-202",
          course: "",
        ),
        Divider(
          color: Color.fromRGBO(224, 225, 235, 1),
          height: 0,
          thickness: 1.8,
        ),
        SizedBox(height: 20),
        GroupItemInList(
          title: "ПI-211",
          course: "2 курс",
        ),
        GroupItemInList(
          title: "ПI-212",
          course: "",
        ),
        Divider(
          color: Color.fromRGBO(224, 225, 235, 1),
          height: 0,
          thickness: 1.8,
        ),
        SizedBox(height: 20),
        GroupItemInList(
          title: "ПI-221",
          course: "1 курс",
        ),
        GroupItemInList(
          title: "ПI-222",
          course: "",
        ),
        Divider(
          color: Color.fromRGBO(224, 225, 235, 1),
          height: 0,
          thickness: 1.8,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
