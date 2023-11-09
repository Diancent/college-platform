import 'package:college_platform_mobile/models/student_additional.dart';
import 'package:college_platform_mobile/models/student_group.dart';
import 'package:college_platform_mobile/models/student_info.dart';
import 'package:college_platform_mobile/widgets/expansion_panel_widgets.dart';
import 'package:college_platform_mobile/widgets/information_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../dictionary/dictionary_student_info.dart';
import '../../lists/student_info_expansion.dart';
import '../../services/auth_service.dart';

class StudentScreen extends StatefulWidget {
  final StudentGroup student;
  final String groupName;

  const StudentScreen({
    Key? key,
    required this.student,
    required this.groupName,
  }) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  StudentInfo? studentInfo;
  StudentAdditional? studentAdditional;
  final userService = UserService();

  @override
  void initState() {
    super.initState();
    fetchStudentInfo();
  }

  Future<void> fetchStudentInfo() async {
    try {
      final studentService = UserService();
      final id = widget.student.id;
      final info = await studentService.getStudentInfo(id);
      setState(() {
        studentInfo = info;
      });
      await fetchStudentAdditionalInfo(id); // Передача id
    } catch (error) {
      print("Error: $error");
    }
  }

  Future<void> fetchStudentAdditionalInfo(String studentId) async {
    try {
      final studentData = await userService.getStudentAdditional(studentId);

      // Створення екземпляра StudentAdditional з отриманих даних
      final studentAdditional = StudentAdditional(
        phoneNumber: studentData['phoneNumber'],
        birthday: studentData['birthday'],
        city: studentData['city'],
        street: studentData['street'],
        houseNumber: studentData['houseNumber'],
        apartmentNumber: studentData['apartmentNumber'],
        fatherName: studentData['fatherName'],
        fatherSurname: studentData['fatherSurname'],
        fatherPatronim: studentData['fatherPatronim'],
        fatherPhoneNumber: studentData['fatherPhoneNumber'],
        fatherOrganization: studentData['fatherOrganization'],
        fatherPosition: studentData['fatherPosition'],
        motherName: studentData['motherName'],
        motherSurname: studentData['motherSurname'],
        motherPatronim: studentData['motherPatronim'],
        motherPhoneNumber: studentData['motherPhoneNumber'],
        motherOrganization: studentData['motherOrganization'],
        motherPosition: studentData['motherPosition'],
        isOrphan: studentData['isOrphan'],
        areParentsDivorced: studentData['areParentsDivorced'],
        isFromLowIncomeFamily: studentData['isFromLowIncomeFamily'],
        isRaisedBySingleParent: studentData['isRaisedBySingleParent'],
        isFromLargeFamily: studentData['isFromLargeFamily'],
        isAffectedByChernobyl: studentData['isAffectedByChernobyl'],
        areParentsCombatVeterans: studentData['areParentsCombatVeterans'],
        isTemporarilyDisplaced: studentData['isTemporarilyDisplaced'],
        isDisabled: studentData['isDisabled'],
      );

      setState(() {
        this.studentAdditional = studentAdditional;
      });

      // Використання даних студента
      print('Ім\'я студента: ${studentAdditional.fatherName}');
      print('Телефон матері: ${studentAdditional.motherPhoneNumber}');
      // і так далі
    } catch (e) {
      // Обробка помилки
      print('Помилка при отриманні даних студента: $e');
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
        title: Text(
          '${widget.student.name} ${widget.student.surname}',
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
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
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 30,
                    ),
                    const SizedBox(width: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.student.name} ${widget.student.surname}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.groupName,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                if (studentInfo != null)
                  Column(
                    children: [
                      InformationItem(
                        firstText: 'Email',
                        secondText: studentInfo!.email,
                      ),
                      divider(),
                      InformationItem(
                        firstText: "Ім'я",
                        secondText: studentInfo!.name,
                      ),
                      divider(),
                      InformationItem(
                        firstText: "Прізвище",
                        secondText: studentInfo!.surname,
                      ),
                      // Додайте решту полів з studentInfo,
                      // використовуючи InformationItem замість статичних полів
                      divider(),
                    ],
                  ),
                if (studentAdditional != null)
                  ...studentAdditionalExpansionPanelWidgets(),
                ...parentInformationExpansionPanelWidgets(),
                ...specialConditionsExpansionPanelWidgets(),
                ...entranceExamGradesExpansionPanelWidgets(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> studentAdditionalExpansionPanelWidgets() {
    return [
      if (studentInfo != null && studentAdditional != null)
        ExpansionPanelWidgets(
          items: [
            ExpansionPanelItem(
              headerValue: 'Персональна інформація',
              widgets: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    children: [
                      InformationItem(
                        firstText: "Дата вступу",
                        secondText: studentInfo!.entryDate.toString(),
                      ),
                      InformationItem(
                          firstText: "Дата Народження",
                          secondText: studentAdditional!.birthday),
                      InformationItem(
                        firstText: "Номер телефону",
                        secondText: studentAdditional!.phoneNumber.toString(),
                      ),
                      InformationItem(
                          firstText: "Місто",
                          secondText: studentAdditional!.city),
                      InformationItem(
                          firstText: "Вулиця",
                          secondText: studentAdditional!.street),
                      InformationItem(
                          firstText: "Будинок",
                          secondText: studentAdditional!.houseNumber),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
    ];
  }

  List<Widget> parentInformationExpansionPanelWidgets() {
    return [
      if (studentAdditional != null) // Add null check

        ExpansionPanelWidgets(
          items: [
            ExpansionPanelItem(
              headerValue: 'Інформація про батьків',
              widgets: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    children: [
                      InformationItem(
                        firstText: "Ім'я матері",
                        secondText: studentAdditional!.motherName.toString(),
                      ),
                      InformationItem(
                        firstText: "Номер телефону матері",
                        secondText:
                            studentAdditional!.motherPhoneNumber.toString(),
                      ),
                      InformationItem(
                        firstText: "Назва організації матері",
                        secondText:
                            studentAdditional!.motherOrganization.toString(),
                      ),
                      InformationItem(
                        firstText: "Назва посади матері",
                        secondText:
                            studentAdditional!.motherPosition.toString(),
                      ),
                      InformationItem(
                        firstText: "Ім'я батька",
                        secondText: studentAdditional!.fatherName.toString(),
                      ),
                      InformationItem(
                        firstText: "Номер телефону батька",
                        secondText:
                            studentAdditional!.fatherPhoneNumber.toString(),
                      ),
                      InformationItem(
                        firstText: "Назва організації батька",
                        secondText:
                            studentAdditional!.fatherOrganization.toString(),
                      ),
                      InformationItem(
                        firstText: "Назва посади батька",
                        secondText:
                            studentAdditional!.fatherPosition.toString(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
    ];
  }

  List<Widget> specialConditionsExpansionPanelWidgets() {
    return [
      if (studentAdditional != null)
        ExpansionPanelWidgets(
          items: [
            ExpansionPanelItem(
              headerValue: 'Особливі умови',
              widgets: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    children: [
                      InformationItem(
                        firstText: "Сирота чи напівсирота",
                        secondText: studentAdditional!.isOrphan.toString(),
                      ),
                      InformationItem(
                        firstText: "Розлучені батьки",
                        secondText:
                            studentAdditional!.areParentsDivorced.toString(),
                      ),
                      InformationItem(
                        firstText: "Малозабезпечена сім'я",
                        secondText:
                            studentAdditional!.isFromLowIncomeFamily.toString(),
                      ),
                      InformationItem(
                        firstText: "Одноосібне виховання",
                        secondText: studentAdditional!.isRaisedBySingleParent
                            .toString(),
                      ),
                      InformationItem(
                        firstText: "Багатодітна",
                        secondText:
                            studentAdditional!.isFromLargeFamily.toString(),
                      ),
                      InformationItem(
                        firstText: "Чорнобилець",
                        secondText:
                            studentAdditional!.isAffectedByChernobyl.toString(),
                      ),
                      InformationItem(
                        firstText: "Дитина учасників УБД",
                        secondText: studentAdditional!.areParentsCombatVeterans
                            .toString(),
                      ),
                      InformationItem(
                        firstText: "Тимчасово переміщена особа",
                        secondText: studentAdditional!.isTemporarilyDisplaced
                            .toString(),
                      ),
                      InformationItem(
                        firstText: "Інвалід",
                        secondText: studentAdditional!.isDisabled.toString(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
    ];
  }

  List<Widget> entranceExamGradesExpansionPanelWidgets() {
    return [
      if (studentInfo != null)
        ExpansionPanelWidgets(
          items: [
            ExpansionPanelItem(
              headerValue: 'Оцінки за вступні екзамени',
              widgets: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    children: [
                      InformationItem(
                        firstText: "Бали з української мови",
                        secondText:
                            studentInfo!.ukrainianLanguageScore.toString(),
                      ),
                      InformationItem(
                        firstText: "Бали з математики",
                        secondText: studentInfo!.mathematicsScore.toString(),
                      ),
                      InformationItem(
                        firstText: "Оцінка атестату",
                        secondText: studentInfo!.diplomaGrade.toString(),
                      ),
                      InformationItem(
                        firstText: "Конкурсний бал",
                        secondText: studentInfo!.competitiveScore.toString(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
    ];
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
