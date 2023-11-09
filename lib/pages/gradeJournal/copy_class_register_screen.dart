import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClassRegisterScreen extends StatefulWidget {
  const ClassRegisterScreen({super.key});

  @override
  State<ClassRegisterScreen> createState() => _ClassRegisterScreenState();
}

class _ClassRegisterScreenState extends State<ClassRegisterScreen> {
  List<String> subjects = ['Math', 'Science', 'English'];
  List<int> semesters = [1, 2];
  late String selectedSubject;
  late int selectedSemester;
  @override
  void initState() {
    super.initState();
    selectedSubject = subjects[0];
    selectedSemester = semesters[0];
  }

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
          "Журнал",
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedSubject,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSubject = newValue!;
                    });
                  },
                  items: subjects.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButton<int>(
                  value: selectedSemester,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedSemester = newValue!;
                    });
                  },
                  items: semesters.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('Semester $value'),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Загальна кількість оцінок
              itemBuilder: (context, index) {
                // Отримання оцінки для вибраного предмету та семестру
                int grade = getGrade(selectedSubject, selectedSemester, index);
                return ListTile(
                  title: Text('Grade ${index + 1}'),
                  subtitle: Text(
                      'Subject: $selectedSubject, Semester: $selectedSemester'),
                  trailing: Text(grade.toString()), // Відображення оцінки
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Припустима функція для отримання оцінки з певного предмету та семестру
  int getGrade(String subject, int semester, int index) {
    // Логіка отримання оцінки
    // Замініть цю функцію на реальну логіку отримання оцінки з вашого джерела даних
    return 80 + index;
  }
}
