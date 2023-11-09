import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScheduleChangePage extends StatelessWidget {
  final List<String>? scheduleData;
  const ScheduleChangePage({Key? key, required this.scheduleData})
      : super(key: key);

  // const ScheduleChangePage({super.key, required this.scheduleData});

  @override
  Widget build(BuildContext context) {
    final group = scheduleData?[0];
    final date = scheduleData?[1];
    final dayOfWeek = scheduleData?[2];
    final regularTeachers = scheduleData?[3];

    final substituteLessons = scheduleData?.sublist(4);
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
        elevation: 0,
        title: const Text(
          'Заміни в розкладі',
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Заміни в розкладі $date р.',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  '$dayOfWeek - чисельник',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Оголошення:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Чергові викладачі:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  regularTeachers!,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Заміни:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  substituteLessons![0],
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  substituteLessons[1],
                  style: const TextStyle(fontSize: 16),
                ),
                // ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: substituteLessons.length - 1,
                //   itemBuilder: (context, index) {
                //     final substituteLesson = substituteLessons[index + 1];
                //     return Text(
                //       substituteLesson,
                //       style: const TextStyle(fontSize: 16),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
