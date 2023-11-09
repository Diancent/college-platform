import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClassRegisterScreen extends StatefulWidget {
  const ClassRegisterScreen({super.key});

  @override
  State<ClassRegisterScreen> createState() => _ClassRegisterScreenState();
}

class _ClassRegisterScreenState extends State<ClassRegisterScreen> {
  List<String> courses = ['1st Course', '2nd Course'];
  List<String> subjects = ['Math', 'Science', 'English'];
  List<int> semesters = [1, 2];
  late String selectedCourse;
  late String selectedSubject;
  late int selectedSemester;

  List<Map<String, dynamic>> grades = [
    {
      'course': '1st Course',
      'subject': 'Math',
      'semester': 1,
      'grade': 90,
      'date': '2023-05-15'
    },
    {
      'course': '1st Course',
      'subject': 'Math',
      'semester': 2,
      'grade': 85,
      'date': '2023-06-20'
    },
    {
      'course': '1st Course',
      'subject': 'Science',
      'semester': 1,
      'grade': 92,
      'date': '2023-05-18'
    },
    {
      'course': '1st Course',
      'subject': 'Science',
      'semester': 2,
      'grade': 88,
      'date': '2023-06-23'
    },
    {
      'course': '2nd Course',
      'subject': 'English',
      'semester': 1,
      'grade': 88,
      'date': '2023-05-22'
    },
    {
      'course': '2nd Course',
      'subject': 'English',
      'semester': 2,
      'grade': 90,
      'date': '2023-06-28'
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedCourse,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCourse = newValue!;
                      });
                    },
                    items:
                        courses.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedSubject,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSubject = newValue!;
                      });
                    },
                    items:
                        subjects.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: DropdownButton<int>(
                    value: selectedSemester,
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedSemester = newValue!;
                      });
                    },
                    items: semesters.map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
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
      DataColumn(label: Text('Date')),
      DataColumn(label: Text('Grade')),
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

  // Припустима функція для отримання оцінки з певного предмету та семестру
  int getGrade(String subject, int semester, int index) {
    // Логіка отримання оцінки
    // Замініть цю функцію на реальну логіку отримання оцінки з вашого джерела даних
    return 5 + index;
  }
}
