import 'package:college_platform_mobile/services/auth_service.dart';
import 'package:college_platform_mobile/services/teacher_service.dart';
import 'package:college_platform_mobile/models/teacher.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:college_platform_mobile/routs.dart' as route;

class AddTeacherScreen extends StatefulWidget {
  final String email;
  const AddTeacherScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<AddTeacherScreen> createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  final UserService userService = UserService();
  final _formfield = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _patronimController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _graduationDateController =
      TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  RegExp get _emailRegex => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  RegExp get _nameRegex =>
      RegExp(r'^([А-ЩЬЮЯЇІЄҐ]{1}[а-щьюяїієґ]{1,23}|[A-Z]{1}[a-z]{1,23})$');

  RegExp get _dateRegex => RegExp(
      r'^\s*(3[01]|[12][0-9]|0?[1-9])\.(1[012]|0?[1-9])\.((?:19|20)\d{2})\s*$');
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
          "Додати нового викладача",
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      ),
      body: Form(
        key: _formfield,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          children: [
            const SizedBox(height: 28),
            const Text(
              "Реєстрація \nвикладача",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            TextFormField(
              readOnly: true,
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "e-mail",
              ),
              validator: (value) {
                bool emailValid = _emailRegex.hasMatch(value!);
                if (value.isEmpty) {
                  return "Введіть Email";
                } else if (!emailValid) {
                  return "Введіть дійсну адресу електронної пошти";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Ім'я викладача",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Введіть ім'я";
                } else if (!_nameRegex.hasMatch(value)) {
                  return "Ви ввели правильне ім’я?";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _surnameController,
              decoration: const InputDecoration(
                labelText: "Прізвище викладача",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Введіть прізвище";
                } else if (!_nameRegex.hasMatch(value)) {
                  return "Ви ввели правильне прізвище?";
                }

                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _patronimController,
              decoration: const InputDecoration(
                labelText: "По батькові",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Введіть по батькові";
                } else if (!_nameRegex.hasMatch(value)) {
                  return "Ви ввели правильне ім'я по батькові?";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                labelText: "Номер телефону",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Введіть номер телефону";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _universityController,
              decoration: const InputDecoration(
                labelText: "Університет",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Введіть університет";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _graduationDateController,
              decoration: const InputDecoration(
                  labelText: "Дата випуску",
                  hintText: "ДД.ММ.РРРР",
                  hintStyle: TextStyle(color: Colors.grey)),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Введіть по батькові";
                } else if (!_dateRegex.hasMatch(value)) {
                  return "Неправильний формат";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _positionController,
              decoration: const InputDecoration(
                labelText: "Посада",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Введіть посаду";
                } else if (!_nameRegex.hasMatch(value)) {
                  return "Ви ввели правильно посаду?";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _degreeController,
              decoration: const InputDecoration(
                labelText: "Ступінь",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Введіть ступінь";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _experienceController,
              decoration: const InputDecoration(
                labelText: "Досвід",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Введіть досвід";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: const Color.fromRGBO(30, 26, 82, 1),
                padding:
                    const EdgeInsets.symmetric(horizontal: 33, vertical: 15),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              onPressed: () async {
                if (_formfield.currentState!.validate()) {
                  final splited = _graduationDateController.text.split(".");
                  final dt = DateTime.utc(
                    int.parse(splited[2]),
                    int.parse(splited[1]),
                    int.parse(splited[0]),
                  );
                  final teacher = Teacher(
                    _emailController.text,
                    _nameController.text,
                    _surnameController.text,
                    _patronimController.text,
                    _phoneNumberController.text,
                    _universityController.text,
                    dt.toIso8601String(),
                    _positionController.text,
                    _degreeController.text,
                    int.parse(_experienceController.text),
                  );

                  try {
                    await userService.addTeacher(teacher);
                    // Вчитель успішно доданий
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Успіх'),
                        content: const Text('Викладача успішно додано.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Navigator.of(context).pop();
                              Navigator.pushNamed(
                                  context, route.allUsersWithoutRoles);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } catch (error) {
                    // Обробка помилки при додаванні вчителя
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Помилка'),
                        content: const Text(
                            'Сталася помилка при додаванні викладача.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
              child: const Text(
                'Відправити',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
