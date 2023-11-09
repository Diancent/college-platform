import 'package:college_platform_mobile/services/auth_service.dart';
import 'package:college_platform_mobile/models/group_semesters.dart';
import 'package:college_platform_mobile/models/semester.dart';
import 'package:college_platform_mobile/models/subject.dart';
import 'package:college_platform_mobile/pages/addGroup/semester_page.dart';
import 'package:college_platform_mobile/widgets/confirmation_dialog.dart';
import 'package:college_platform_mobile/widgets/separator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddGroupPage extends StatefulWidget {
  const AddGroupPage({super.key});

  @override
  State<AddGroupPage> createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  final UserService userService = UserService();
  final TextEditingController _groupNameController = TextEditingController();
  List<Semester> semesters = [];

  void addSemester(List<Subject> subjects) {
    setState(() {
      semesters.add(Semester(
        semesterNumber: semesters.length + 1,
        subjects: subjects,
      ));
    });
  }

  void removeSemester(int index) {
    setState(() {
      semesters.removeAt(index);
      for (int i = index; i < semesters.length; i++) {
        semesters[i] = Semester(
          semesterNumber: i + 1,
          subjects: semesters[i].subjects,
        );
      }
    });
  }

  Future<void> goToSemesterPage(Semester semester) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SemesterPage(semester: semester),
      ),
    );
    if (result != null) {
      // Обробка повернутих даних із SemesterPage
      setState(() {
        semester.subjects = result;
      });
      print('Returned data from SemesterPage: $result');
    }
  }

  void saveData() async {
    final String groupName = _groupNameController.text;

    // Створення об’єкта Group із введеною назвою групи та семестрами
    final GroupSemesters group = GroupSemesters(
      groupName: groupName,
      semesters: semesters,
    );

    try {
      await userService
          .addGroup(group); // Викликаємо метод addGroup з вашого сервісу
      print('Дані групи збережено: $group');
    } catch (error) {
      print('Помилка додавання групи: $error');
    }

    print('Дані групи збережено: $group');
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(semesters: semesters);
      },
    ).then((result) async {
      if (result != null && result) {
        // Код, який виконується, коли користувач підтверджує діалог

        final String groupName = _groupNameController.text;

        // Створення об’єкта Group із введеною назвою групи та семестрами
        final GroupSemesters group = GroupSemesters(
          groupName: groupName,
          semesters: semesters,
        );

        try {
          await userService
              .addGroup(group); // Викликаємо метод addGroup з вашого сервісу
          print('Дані групи збережено: $group');
        } catch (error) {
          print('Помилка додавання групи: $error');
        }

        print('Дані групи збережено: $group');
      }
    });
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
          "Додати групу",
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Назва групи",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _groupNameController,
                  decoration: const InputDecoration(
                    hintText: 'Назва групи',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(30, 26, 82, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const MySeparator(
            height: 1.0,
            color: Colors.grey,
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                "Семестри",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: semesters.length,
            itemBuilder: (context, index) {
              final semester = semesters[index];
              return Column(
                children: [
                  const Divider(
                    thickness: 2,
                  ),
                  ListTile(
                    title: Text('Семестр ${semester.semesterNumber}'),
                    subtitle: Text("Предмети: ${semester.subjects.length}"),
                    onTap: () {
                      goToSemesterPage(semester);
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        removeSemester(index);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addSemester([]);
        },
        backgroundColor: const Color.fromRGBO(30, 26, 82, 1),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _showConfirmationDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(30, 26, 82, 1),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          child: const Text('Зберегти'),
        ),
      ),
    );
  }
}
