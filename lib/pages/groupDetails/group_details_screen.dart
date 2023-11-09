import 'package:college_platform_mobile/services/auth_service.dart';
import 'package:college_platform_mobile/models/page_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupDetailsScreen extends StatefulWidget {
  final GroupPage groupPage;
  const GroupDetailsScreen({super.key, required this.groupPage});

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  final UserService _groupService = UserService();
  List<Map<String, dynamic>> _semesters = [];
  List<Map<String, dynamic>> _subjects = [];
  int? _selectedSemesterId;

  @override
  void initState() {
    super.initState();
    fetchSemesters();
  }

  Future<void> fetchSemesters() async {
    final semesters = await _groupService.fetchSemesters(widget.groupPage.id);
    setState(() {
      _semesters = semesters;
      _selectedSemesterId = semesters.isNotEmpty ? semesters[0]['id'] : null;
    });
    if (_selectedSemesterId != null) {
      fetchSubjects(_selectedSemesterId!);
    }
  }

  Future<void> fetchSubjects(int semesterId) async {
    final subjects = await _groupService.fetchSubjects(semesterId);
    setState(() {
      _subjects = subjects;
    });
  }

  List<DropdownMenuItem<int>> _buildSemesterDropdownItems() {
    return _semesters
        .map<DropdownMenuItem<int>>(
          (semester) => DropdownMenuItem<int>(
            value: semester['id'],
            child: Text('Семестр ${semester['value']}'),
          ),
        )
        .toList();
  }

  DropdownButton<int> _buildSemesterDropdown() {
    return DropdownButton<int>(
      value: _selectedSemesterId,
      onChanged: (int? newValue) {
        if (newValue != null) {
          fetchSubjects(newValue);
          setState(() {
            _selectedSemesterId = newValue;
          });
        }
      },
      items: _buildSemesterDropdownItems(),
    );
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
        title: Text(
          'Група ${widget.groupPage.name}',
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: _buildSemesterDropdown(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _subjects.length,
              itemBuilder: (context, index) {
                final subject = _subjects[index];
                return ListTile(
                  title: Text(subject['name']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
