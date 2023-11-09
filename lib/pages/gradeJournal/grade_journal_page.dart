import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradeJournalPage extends StatefulWidget {
  const GradeJournalPage({super.key});

  @override
  State<GradeJournalPage> createState() => _GradeJournalPageState();
}

class _GradeJournalPageState extends State<GradeJournalPage> {
  List<String> courses = ['1 курс', '2 курс']; // Список курсів
  List<String> subjects = ['Математика', 'Фізика', 'Хімія']; // Список предметів
  List<String> semesters = ['Семестр 1', 'Семестр 2']; // Список семестрів

  late String selectedCourse;
  late String selectedSubject;
  late String selectedSemester;

  List<Map<String, dynamic>> grades = [
    {
      'course': '1 курс',
      'subject': 'Математика',
      'semester': 'Семестр 1',
      'grade': 12,
      'date': '2023-05-15'
    },
    {
      'course': '1 курс',
      'subject': 'Математика',
      'semester': 'Семестр 1',
      'grade': 12,
      'date': '2023-05-20'
    },
    {
      'course': '1 курс',
      'subject': 'Фізика',
      'semester': 'Семестр 1',
      'grade': 8,
      'date': '2023-05-18'
    },
    {
      'course': '1 курс',
      'subject': 'Фізика',
      'semester': 'Семестр 2',
      'grade': 8,
      'date': '2023-05-23'
    },
    {
      'course': '2 курс',
      'subject': 'Хімія',
      'semester': 'Семестр 1',
      'grade': 9,
      'date': '2023-05-22'
    },
    {
      'course': '2 курс',
      'subject': 'Хімія',
      'semester': 'Семестр 2',
      'grade': 10,
      'date': '2023-05-28'
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedCourse = courses[0];
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<String>(
                value: selectedCourse,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCourse = newValue!;
                  });
                },
                items: courses.map<DropdownMenuItem<String>>((String course) {
                  return DropdownMenuItem<String>(
                    value: course,
                    child: Text(course),
                  );
                }).toList(),
              ),
              SizedBox(height: 10.0),
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
              const SizedBox(height: 10.0),
              DropdownButton<String>(
                value: selectedSemester,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSemester = newValue!;
                  });
                },
                items: semesters.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          // Expanded(
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: _buildTableColumns(),
                rows: _buildTableRows(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DataColumn> _buildTableColumns() {
    return [
      DataColumn(label: Text('Дата')),
      DataColumn(label: Text('Оцінка')),
    ];
  }

  List<DataRow> _buildTableRows() {
    List<DataRow> rows = [];

    for (int i = 0; i < grades.length; i++) {
      Map<String, dynamic> grade = grades[i];

      if (grade['course'] == selectedCourse &&
          grade['subject'] == selectedSubject &&
          grade['semester'] == selectedSemester) {
        rows.add(
          DataRow(
            cells: [
              DataCell(Text(grade['date'])),
              DataCell(Text(grade['grade'].toString())),
            ],
          ),
        );
      }
    }

    return rows;
  }

  //  Функція для отримання оцінки з певного предмету та семестру
  int getGrade(String subject, int semester, int index) {
    // Логіка отримання оцінки

    return 5 + index;
  }
}
