import 'package:college_platform_mobile/models/get_teacher.dart';
import 'package:college_platform_mobile/services/auth_service.dart';

import 'package:college_platform_mobile/pages/teacherDetail/teacher_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:college_platform_mobile/routs.dart' as route;

class AllTeachersScreen extends StatefulWidget {
  const AllTeachersScreen({super.key});

  @override
  State<AllTeachersScreen> createState() => _AllTeachersScreenState();
}

class _AllTeachersScreenState extends State<AllTeachersScreen> {
  List<GetTeacher> teachers = [];
  int pageNumber = 1;
  int pageSize = 13;
  bool isLoading = false;
  final UserService userService = UserService();

  @override
  void initState() {
    super.initState();
    _fetchTeachers();
  }

  List filteredTeachers = [];

  TextEditingController searchController = TextEditingController();

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
          "Список усіх викладачів",
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
      ),
      // body: getBody(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (!isLoading &&
              notification is ScrollEndNotification &&
              notification.metrics.extentAfter == 0) {
            // Досягнуто кінця списку, завантаження наступної сторінки
            _loadMoreTeachers();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: teachers.length + 1,
          itemBuilder: (context, index) {
            if (index < teachers.length) {
              final teacher = teachers[index];
              return ListTile(
                title: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(width: 10),
                    Text(teacher.surname),
                    const SizedBox(width: 10),
                    Text(teacher.name),
                    const SizedBox(width: 10),
                    Text(teacher.patronim),
                  ],
                ),
                onTap: () {
                  navigateToTeacherDetail(teacher.id);
                },
              );
            } else if (isLoading) {
              // Відображення CircularProgressIndicator під час завантаження
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(30, 26, 82, 1),
                  ),
                ),
              );
            } else {
              // Всі елементи вже завантажені
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Future<void> _fetchTeachers() async {
    try {
      setState(() {
        isLoading = true;
      });
      final users = await userService.getTeachers(pageNumber, pageSize);
      setState(() {
        teachers.addAll(users);
        // pageNumber++;
        isLoading = false;
      });
    } catch (error) {
      // Обробка помилок
      print('Error fetching teachers users: $error');
    }
  }

  Future<void> _loadMoreTeachers() async {
    try {
      setState(() {
        isLoading = true;
      });
      final users = await userService.getTeachers(pageNumber + 1, pageSize);
      setState(() {
        teachers.addAll(users);
        pageNumber++;
        isLoading = false;
      });
    } catch (error) {
      // Обробка помилок
      print('Error fetching teachers: $error');
    }
  }

  void navigateToTeacherDetail(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeacherDetailScreen(teacherId: id),
      ),
    );
  }
}
