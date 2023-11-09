import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int selectedDayIndex = 0;

  final List<String> daysOfWeek = [
    'Пн',
    'Вт',
    'Ср',
    'Чт',
    'Пт',
    'Сб',
  ];

  final List<List<Lesson>> schedule = [
    [
      Lesson('Громадянська освіта', '8:30', '9:50', '122'),
      Lesson('Іноземна мова', '10:00', '11:20', '135'),
      Lesson('Українська мова', '11:50', '13:10', '127'),
      Lesson('Українська література', '13:20', '14:40', '127'),
    ],
    [
      Lesson('Історія України', '8:30', '9:50', '133a'),
      Lesson('Фізика', '10:00', '11:20', '131'),
      Lesson('Математика', '11:50', '13:10', '145'),
    ],
    [
      Lesson('Зарубіжна література', '8:30', '9:50', '127'),
      Lesson('Інформатика', '10:00', '11:20', '235a'),
      Lesson('Фізична культура', '11:50', '13:10', ''),
    ],
    [
      Lesson('Математика', '8:30', '9:50', '144a'),
      Lesson('Історія України', '10:00', '11:20', '133a'),
      Lesson('Біологія', '11:50', '13:10', '142'),
      Lesson('Фізика', '13:20', '14:40', '131'),
    ],
    [
      Lesson('Інформатика', '8:30', '9:50', '235a'),
      Lesson('Фізична культура', '10:00', '11:20', ''),
      Lesson('Математика', '11:50', '13:10', '145'),
    ],
    [],
  ];

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
        elevation: 0,
        title: const Text(
          "Розклад занять",
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 25,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(224, 225, 235, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              height: 35,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: daysOfWeek.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDayIndex = index;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: selectedDayIndex == index
                            ? const Color.fromRGBO(30, 26, 82, 1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        daysOfWeek[index],
                        style: TextStyle(
                          color: selectedDayIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: schedule[selectedDayIndex].length,
                itemBuilder: (context, index) {
                  Lesson lesson = schedule[selectedDayIndex][index];
                  return Column(
                    children: [
                      Card(
                        elevation: 1,
                        shadowColor: Colors.black,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            // side: BorderSide(width: 0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          tileColor: const Color.fromRGBO(224, 225, 235, 1),
                          title: Text(
                            lesson.subject,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            '${lesson.startTime} - ${lesson.endTime}',
                          ),
                          trailing: Text(
                            '${lesson.className} аудиторія',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Lesson {
  final String subject;
  final String startTime;
  final String endTime;
  final String className;

  Lesson(this.subject, this.startTime, this.endTime, this.className);
}
