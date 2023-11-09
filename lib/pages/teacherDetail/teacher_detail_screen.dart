import 'package:college_platform_mobile/models/get_teacher.dart';
import 'package:college_platform_mobile/services/auth_service.dart';
import 'package:college_platform_mobile/widgets/information_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../dictionary/dictionary_teacher_info.dart';

class TeacherDetailScreen extends StatefulWidget {
  // final GetTeacher teacher;
  final String teacherId;
  // final String fullName;
  // final String subject;
  // final String profileUrl;
  const TeacherDetailScreen({super.key, required this.teacherId});

  @override
  State<TeacherDetailScreen> createState() => _TeacherDetailScreenState();
}

class _TeacherDetailScreenState extends State<TeacherDetailScreen> {
  final UserService teacherService = UserService();
  Map<String, dynamic>? teacherInfo;

  @override
  void initState() {
    super.initState();
    _fetchTeacherInfo();
  }

  Future<void> _fetchTeacherInfo() async {
    try {
      final info = await teacherService.getTeacherInfo(widget.teacherId);
      setState(() {
        teacherInfo = info;
      });
    } catch (error) {
      print('Error fetching teacher info: $error');
    }
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
        title: const Text("Викладач"),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(width: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${teacherInfo?['surname']} ${teacherInfo?['name']} ${teacherInfo?['patronim']}' ??
                              '',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // Text(
                        //   "КІ-192",
                        //   style: TextStyle(fontSize: 14),
                        // ),
                      ],
                    ),
                  ],
                ),
                InformationItem(
                  firstText: "Предмети",
                  secondText: "Math",
                ),
                divider(),
                divider(),
                InformationItem(
                  firstText: "З якого року викладає",
                  secondText: teacherInfo?['graduationDate'] != null
                      ? _formatDate(teacherInfo?['graduationDate']) ?? ''
                      : '',
                ),
                divider(),
                InformationItem(
                  firstText: "Посада",
                  secondText: '${teacherInfo?['position']}' ?? '',
                ),
                divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    const Text(
                      "Освіта",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      teacherInfo?['university'] ?? '',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                    divider(),
                    const SizedBox(height: 10),
                    const Text(
                      "Кваліфікація",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      teacherInfo?['degree'] ?? '',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
          divider(),
          // ExpansionPanelWidgets(items: expandedList)
        ],
      ),
    );
  }

  Divider divider() {
    return const Divider(
      color: Colors.grey,
      height: 1,
    );
  }

  String? _formatDate(String? dateString) {
    if (dateString != null) {
      final dateTimeFormat = DateFormat('yyyy-MM-dd');
      final dateTime = DateTime.parse(dateString);
      return dateTimeFormat.format(dateTime);
    }
    return null;
  }
}
