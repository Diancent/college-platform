import 'package:college_platform_mobile/models/group.dart';
import 'package:college_platform_mobile/models/page_group.dart';
import 'package:college_platform_mobile/models/student_group.dart';
import 'package:college_platform_mobile/pages/groupDetails/group_details_screen.dart';
import 'package:college_platform_mobile/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:college_platform_mobile/pages/student/student_screen.dart';
import 'package:flutter/cupertino.dart';

class GroupListScreen extends StatefulWidget {
  final int groupId;
  final GroupPage groupPage;
  const GroupListScreen(
      {super.key, required this.groupId, required this.groupPage});

  @override
  State<GroupListScreen> createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  final UserService _userService = UserService();

  void _navigateToGroupSemesters(GroupPage groupPage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroupDetailsScreen(groupPage: groupPage),
      ),
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
        title: FutureBuilder<Group>(
          future: _userService.getGroup(widget.groupId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final group = snapshot.data!;
              return Text(
                group.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              );
            } else if (snapshot.hasError) {
              return const Text('Помилка отримання групи');
            } else {
              return const SizedBox();
            }
          },
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: ListView(
        children: [
          section("Люди в групі"),
          FutureBuilder<Group>(
            future: _userService.getGroup(widget.groupId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final group = snapshot.data!;
                return Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      section("Куратор"),
                      curatorCell(group.curatorName ?? 'Немає'),
                      divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 58,
                            padding: const EdgeInsets.only(
                                left: 24, top: 20, bottom: 20),
                            child: const Text(
                              "Студенти",
                              style: TextStyle(
                                color: Color.fromRGBO(127, 127, 127, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.people_outline_outlined,
                                color: Colors.grey,
                                size: 22,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                group.students.length.toString(),
                                style: const TextStyle(
                                  color: Color.fromRGBO(127, 127, 127, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: group.students.length,
                        itemBuilder: (context, index) {
                          final student = group.students[index];
                          return Column(
                            children: [
                              studentCell(student),
                              divider(),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Помилка отримання групи');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: ElevatedButton(
              onPressed: () => _navigateToGroupSemesters(widget.groupPage),
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
              child: const Text('Семестри'),
            ),
          ),
        ],
      ),
    );
  }

  Container section(String label) {
    return Container(
      height: 58,
      padding: const EdgeInsets.only(left: 24, top: 20, bottom: 20),
      child: Text(
        label,
        style: const TextStyle(
          color: Color.fromRGBO(127, 127, 127, 1),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  CupertinoButton curatorCell(String curator) {
    return CupertinoButton(
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => StudentScreen(student: student),
        //   ),
        // );
      },
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          curator,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  CupertinoButton studentCell(StudentGroup student) {
    return CupertinoButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentScreen(
              student: student,
              groupName: widget.groupPage.name, // Передача значення groupName
            ),
          ),
        );
      },
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          '${student.name} ${student.surname}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Divider divider() {
    return const Divider(
      color: Colors.grey,
      height: 1,
    );
  }
}
