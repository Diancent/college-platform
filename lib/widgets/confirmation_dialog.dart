import 'package:college_platform_mobile/services/auth_service.dart';
import 'package:college_platform_mobile/models/group_semesters.dart';
import 'package:college_platform_mobile/models/semester.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final List<Semester> semesters;

  ConfirmationDialog({super.key, required this.semesters});
  void saveData() async {
    final String groupName = _groupNameController.text;

    // Create a Group object with the entered group name and semesters
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

  final UserService userService = UserService();
  final TextEditingController _groupNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Підтвердження'),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: semesters.length,
          itemBuilder: (context, index) {
            final semester = semesters[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Семестр ${semester.semesterNumber}:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: semester.subjects.length,
                  itemBuilder: (context, index) {
                    final subject = semester.subjects[index];
                    return ListTile(
                      title: Text(subject.subjectName),
                      // subtitle: Text("Кредити: ${subject.credits}"),
                    );
                  },
                ),
                SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Дії, що виконуються при натисканні кнопки "Підтвердити"
            Navigator.of(context).pop(true);
            // saveData();
          },
          child: const Text(
            'Підтвердити',
            style:
                TextStyle(color: Color.fromRGBO(30, 26, 82, 1), fontSize: 15),
          ),
        ),
        TextButton(
          onPressed: () {
            // Дії, що виконуються при натисканні кнопки "Відмінити"
            Navigator.of(context).pop(false);
          },
          child: const Text(
            'Відмінити',
            style: TextStyle(
              color: Color.fromRGBO(30, 26, 82, 1),
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
