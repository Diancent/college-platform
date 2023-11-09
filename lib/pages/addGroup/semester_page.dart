import 'package:college_platform_mobile/services/auth_service.dart';
import 'package:college_platform_mobile/models/semester.dart';
import 'package:college_platform_mobile/models/subject.dart';
import 'package:college_platform_mobile/widgets/separator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SemesterPage extends StatefulWidget {
  final Semester semester;

  const SemesterPage({
    Key? key,
    required this.semester,
  }) : super(key: key);

  @override
  State<SemesterPage> createState() => _SemesterPageState();
}

class _SemesterPageState extends State<SemesterPage> {
  final UserService authService = UserService();
  List<Subject> subjects = [];

  final TextEditingController _subjectNameController = TextEditingController();

  void addSubject() {
    setState(() {
      subjects.add(Subject(subjectName: 'Предмет ${subjects.length + 1}'));
    });
  }

  void removeSubject(int index) {
    setState(() {
      subjects.removeAt(index);
    });
  }

  void saveSubjects() {
    Navigator.pop(
        context, subjects); // Повернути список предметів на попередню сторінку
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
          "Додати предмети",
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Вибраний семестр: ${widget.semester.semesterNumber}',
              style: const TextStyle(fontSize: 20),
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
                "Предмети",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 25),
          ListView.builder(
            shrinkWrap: true,
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects[index];
              return ListTile(
                title: Text(subject.subjectName),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    removeSubject(index);
                  },
                ),
                shape: const Border(
                  top: BorderSide(color: Colors.grey),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 36,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: saveSubjects, // Виклик методу для збереження даних
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
            FloatingActionButton(
              onPressed: () {
                _showAddItemDialog();
              },
              backgroundColor: const Color.fromRGBO(30, 26, 82, 1),
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddItemDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Назва предмету",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              TextField(
                controller: _subjectNameController,
                decoration: const InputDecoration(
                  hintText: 'Назва предмету',
                  focusColor: Color.fromRGBO(30, 26, 82, 1),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(30, 26, 82, 1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final subjectName = _subjectNameController.text;
                  if (subjectName.isNotEmpty) {
                    setState(() {
                      subjects.add(Subject(subjectName: subjectName));
                    });
                  }
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(30, 26, 82, 1),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  minimumSize: const Size.fromHeight(50),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                child: const Text('Додати'),
              ),
              Container(
                height: 30,
              )
            ],
          ),
        );
      },
    );
  }
}
