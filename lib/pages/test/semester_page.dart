import 'package:college_platform_mobile/pages/test/group_input_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SemesterPage extends StatefulWidget {
  final String semester;

  const SemesterPage({required this.semester});

  @override
  _SemesterPageState createState() => _SemesterPageState();
}

class _SemesterPageState extends State<SemesterPage> {
  List<String> subjects = [];

  void addSubject() {
    setState(() {
      subjects.add('Subject ${subjects.length + 1}');
    });
  }

  void saveSubjects() {
    // Implement your logic to save subjects to the selected semester
    Navigator.pop(context); // Return back to the previous page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Subjects'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Selected Semester: ${widget.semester}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(subjects[index]),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              saveSubjects();
            },
            child: Text('Save'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addSubject();
        },
      ),
    );
  }
}
