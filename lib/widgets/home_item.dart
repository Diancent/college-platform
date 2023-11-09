import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  final String title, secondTitle;
  final dynamic icon;
  final Function()? onPressed;
  const HomeItem(
      {super.key,
      required this.title,
      required this.secondTitle,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          // fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            const CircleAvatar(
                radius: 30,
                // backgroundColor: Color.fromRGBO(235, 233, 222, 1),
                backgroundColor: Color.fromRGBO(224, 225, 235, 1)),
            Center(
              child: IconButton(onPressed: onPressed, icon: icon),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
              fontSize: 14, color: Color.fromRGBO(88, 90, 94, 1)),
        ),
        Text(
          secondTitle,
          style: const TextStyle(
              fontSize: 14, color: Color.fromRGBO(88, 90, 94, 1)),
        ),
      ],
    );
  }
}
