import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Новина"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        backgroundColor: const Color.fromRGBO(30, 26, 82, 1),
        elevation: 0,
      ),

      body: ListView(
        children: [
          Container(
            width: double.maxFinite,
            height: 230,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/news1.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "18 травня 2023",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "БЛАГОДІЙНИЙ ЯРМАРОК – 2023» В ХМЕЛЬНИЦЬКОМУ ПОЛІТЕХНІЧНОМУ ФАХОВОМУ КОЛЕДЖІ НУ «ЛЬВІВСЬКА ПОЛІТЕХНІКА",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Народи, як і люди, мають різну вдачу: якісь із них веселуни, якісь педанти, якісь замріяні, якісь запальні, а якісь, як ми, українці, – оптимісти, котрі й у часи важких випробувань не втрачають віри в краще майбутнє, і не просто не втрачають, а й не сидять, склавши руки в очікуванні світлого «завтра». З перших днів війни хмельницькі політехніки розпочали активну діяльність із підтримки наших захисників, заснувавши Штаб опору.  В основному дотепер ця підтримка мала матеріальний характер – продукти, маскувальні сітки, «кікімори», одяг, ліки, миючі засоби, сухпаї, пічки, окопні свічки – всього не перелічити. А ось у День вишиванки викладачі, студенти, співробітники ХПФК вирішили продемонструвати всій нашій країні й усьому світові незламний український характер, оновивши свій рекорд 2018 року, коли на стадіоні навчального закладу найбільша кількість людей у вишиванках утворила формацію тризуба. Тільки цьогоріч на зміну гербу держави прийшов напис «СЛАВА ЗСУ!», який занесено до Книги рекордів України з кількістю 740 політехніків у вишиванках, приурочений 592 річниці заснування міста Хмельницького.  Це вже третій рекорд хмельницьких політехніків, який занесено до Книги рекордів України!!!",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.maxFinite,
                  height: 230,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/1-2.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.maxFinite,
                  height: 230,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/2-2.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.maxFinite,
                  height: 230,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/3-2.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.maxFinite,
                  height: 230,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/4-2.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ],
      ),
      // body: Stack(
      //   children: [
      //     Positioned(
      //       left: 0,
      //       right: 0,
      //       child: Container(
      //         width: double.maxFinite,
      //         height: 350,
      //         decoration: const BoxDecoration(
      //           image: DecorationImage(
      //             image: AssetImage("assets/images/news1.jpeg"),
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       ),
      //     ),
      //     Positioned(
      //       left: 20,
      //       top: 70,
      //       child: Row(
      //         children: [
      //           Container(
      //             height: 45,
      //             width: 45,
      //             decoration: BoxDecoration(
      //                 color: Color.fromRGBO(30, 26, 82, 0.5),
      //                 borderRadius: BorderRadius.circular(12)),
      //             child: Center(
      //               child: IconButton(
      //                 iconSize: 25,
      //                 color: Color.fromRGBO(224, 225, 235, 1),
      //                 icon: Icon(CupertinoIcons.chevron_left),
      //                 onPressed: () {
      //                   Navigator.of(context).pop();
      //                 },
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     Positioned(
      //       top: 330,
      //       child: Container(
      //         width: MediaQuery.of(context).size.width,
      //         height: 500,
      //         decoration: BoxDecoration(
      //           color: Colors.amberAccent,
      //           borderRadius: BorderRadius.only(
      //             topLeft: Radius.circular(30),
      //             topRight: Radius.circular(30),
      //           ),
      //         ),
      //       ),
      //     ),
      //     Positioned(
      //       top: 260,
      //       right: 30,
      //       left: 30,
      //       child: Container(
      //         width: MediaQuery.of(context).size.width,
      //         height: 140,
      //         decoration: BoxDecoration(
      //           color: Color.fromRGBO(30, 26, 82, 0.7),
      //           borderRadius: BorderRadius.circular(25),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
    // body: NestedScrollView(
    //   floatHeaderSlivers: true,
    //   headerSliverBuilder: (context, innerBoxIsScrolled) => [
    //     SliverAppBar(
    //       expandedHeight: 280,
    //       flexibleSpace: FlexibleSpaceBar(
    //         title: Text(""),
    //         background: Image.asset(
    //           "assets/images/news1.jpeg",
    //           alignment: Alignment.topCenter,
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //       floating: true,
    //       snap: true,
    //       pinned: true,
    //     ),
    //   ],
    //   body: ListView(
    //     children: [
    //       Container(
    //         height: 100,
    //         color: Colors.amber,
    //       )
    //     ],
    //   ),
    // children: [
    //   Image.asset(
    //     "assets/images/news1.jpeg",
    //     alignment: Alignment.topCenter,
    //   )
    // ],
  }
}
