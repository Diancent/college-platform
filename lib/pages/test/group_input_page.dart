import 'package:college_platform_mobile/pages/test/semester_page.dart';
import 'package:flutter/material.dart';

class GroupInputPage extends StatefulWidget {
  @override
  _GroupInputPageState createState() => _GroupInputPageState();
}

class _GroupInputPageState extends State<GroupInputPage> {
  List<String> semesters = [''];

  void addSemester() {
    setState(() {
      int currentSemesterCount = semesters.length;
      semesters.insert(
          currentSemesterCount - 1, 'Семестр $currentSemesterCount');
    });
  }

  void removeSemester(int index) {
    setState(() {
      if (index != 0) {
        semesters.removeAt(index);
      }
    });
  }

  void navigateToSemesterPage(String semesterName) {
    // Код для переходу на сторінку з назвою семестру
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semesters'),
      ),
      body: ListView.builder(
        itemCount: semesters.length + 1,
        itemBuilder: (context, index) {
          if (index == semesters.length) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  final semesterNumber = semesters.length + 1;
                  semesters.add('Semester $semesterNumber');
                });
              },
            );
          } else {
            final semester = semesters[index];
            return ListTile(
              title: Text(semester),
              onTap: () {
                navigateToSemesterPage(semester);
              },
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    semesters.removeAt(index);
                    for (int i = index; i < semesters.length; i++) {
                      semesters[i] = 'Semester ${i + 1}';
                    }
                  });
                },
              ),
            );
          }
        },
      ),
    );
  }
}
