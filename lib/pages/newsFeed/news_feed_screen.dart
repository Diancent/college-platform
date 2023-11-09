import 'package:flutter/material.dart';

import 'package:college_platform_mobile/pages/newsFeed/news_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:college_platform_mobile/routs.dart' as route;

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({super.key});

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
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Новини",
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 30,
        ),
        children: [
          CupertinoSearchTextField(
            placeholder: "Пошук новини",
            decoration: BoxDecoration(
              color: const Color.fromRGBO(224, 225, 235, 1),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 30),
          NewsItem(
            imagePath: "assets/images/news1.jpeg",
            date: "18 травня 2023",
            title:
                "«БЛАГОДІЙНИЙ ЯРМАРОК – 2023» В ХМЕЛЬНИЦЬКОМУ ПОЛІТЕХНІЧНОМУ ФАХОВОМУ КОЛЕДЖІ НУ «ЛЬВІВСЬКА ПОЛІТЕХНІКА»",
            onPressed: () {
              Navigator.pushNamed(context, route.newsDetail);
            },
          ),
          NewsItem(
            imagePath: "assets/images/news2.jpeg",
            date: "17 травня 2023",
            title:
                "Хмельницький політехнічний фаховий коледж переміг у конкурсі «10 найактивніших закладів вищої та професійно-технічної освіти» в межах Global Money Week",
            onPressed: () {},
          ),
          NewsItem(
            imagePath: "assets/images/news1.jpeg",
            date: "18 травня 2023",
            title:
                "«БЛАГОДІЙНИЙ ЯРМАРОК – 2023» В ХМЕЛЬНИЦЬКОМУ ПОЛІТЕХНІЧНОМУ ФАХОВОМУ КОЛЕДЖІ НУ «ЛЬВІВСЬКА ПОЛІТЕХНІКА»",
            onPressed: () {},
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
