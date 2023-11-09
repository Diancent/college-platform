import 'package:college_platform_mobile/services/auth_service.dart';
import 'package:college_platform_mobile/lists/group_info.dart';
import 'package:college_platform_mobile/models/student.dart';
import 'package:college_platform_mobile/widgets/dropdown_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college_platform_mobile/routs.dart' as route;

const List<Widget> isBudget = <Widget>[Text('Бюджет'), Text('Контракт')];

class AddStudentScreen extends StatefulWidget {
  final String email;
  const AddStudentScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  // final List<bool> _selectedIsBudget = <bool>[true, false];
  // bool _selectedIsBudget = false;
  //List<bool> _selectedIsBudget = List<bool>.filled(isBudget.length, false);
  int _selectedIsBudgetIndex = 0;
  List<bool> _selectedIsBudget = [false, false];
  final UserService userService = UserService();
  bool vertical = false;
  final _formfield = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _patronimController = TextEditingController();
  TextEditingController _groupNameController = TextEditingController();
  TextEditingController _studentCardNumberController = TextEditingController();
  TextEditingController _entryDateController = TextEditingController();
  TextEditingController _ukrainianLanguageScoreController =
      TextEditingController();
  TextEditingController _mathematicsScoreController = TextEditingController();
  TextEditingController _diplomaGradeController = TextEditingController();
  TextEditingController _competitiveScoreController = TextEditingController();
  RegExp get _emailRegex => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  RegExp get _nameRegex =>
      RegExp(r'^([А-ЩЬЮЯЇІЄҐ]{1}[а-щьюяїієґ]{1,23}|[A-Z]{1}[a-z]{1,23})$');
  RegExp get _dateRegex => RegExp(
      r'^\s*(3[01]|[12][0-9]|0?[1-9])\.(1[012]|0?[1-9])\.((?:19|20)\d{2})\s*$');

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
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
          "Додати нового студента",
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
              "Реєстрація \nстудента",
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
                labelText: "Ім'я студента",
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
                labelText: "Прізвище студента",
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
            const SizedBox(height: 30),
            const Text(
              "Тип фінансування",
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 5),
            ToggleButtons(
              direction: vertical ? Axis.vertical : Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < _selectedIsBudget.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      _selectedIsBudget[buttonIndex] =
                          !_selectedIsBudget[buttonIndex];
                    } else {
                      _selectedIsBudget[buttonIndex] = false;
                    }
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: const Color.fromRGBO(30, 26, 82, 1),
              selectedColor: Colors.white,
              fillColor: const Color.fromRGBO(30, 26, 82, 1),
              color: const Color.fromRGBO(30, 26, 82, 1),
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected:
                  _selectedIsBudget, // Використовуємо змінну _selectedIsBudgetIndex
              children: isBudget,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _groupNameController,
              decoration: const InputDecoration(
                labelText: "Група",
              ),
              // validator: (value) {
              //   if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
              //     return "Enter correct name";
              //   } else {
              //     return null;
              //   }
              // },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _studentCardNumberController,
              decoration: const InputDecoration(
                labelText: "Номер студентського",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Введіть номер студентського";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _entryDateController,
              decoration: const InputDecoration(
                  labelText: "Дата вступу",
                  hintText: "ДД.ММ.РРРР",
                  hintStyle: TextStyle(color: Colors.grey)),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Введіть дату вступу";
                } else if (!_dateRegex.hasMatch(value)) {
                  return "Неправильний формат";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _ukrainianLanguageScoreController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Вступний бал за українську мову",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Введіть бал за українську мову";
                } else if (!RegExp(r'^[0-9]+\.?[0-9]*$').hasMatch(value)) {
                  return "Ви ввели правильно бал за українську мову?";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _mathematicsScoreController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Вступний бал за математику",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Введіть бал за математику";
                } else if (!RegExp(r'^[0-9]+\.?[0-9]*$').hasMatch(value)) {
                  return "Ви ввели правильно бал за математику?";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _diplomaGradeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Вступний бал атестату",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Введіть бал атестату";
                } else if (!RegExp(r'^[0-9]+\.?[0-9]*$').hasMatch(value)) {
                  return "Ви ввели правильно бал атестату?";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _competitiveScoreController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Середній вступний бал",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Введіть середній вступний бал";
                } else if (!RegExp(r'^[0-9]+\.?[0-9]*$').hasMatch(value)) {
                  return "Ви ввели правильно середній вступний бал?";
                }
                return null;
              },
            ),
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
                  final splited = _entryDateController.text.split(".");
                  final dt = DateTime.utc(
                    int.parse(splited[2]),
                    int.parse(splited[1]),
                    int.parse(splited[0]),
                  );
                  final student = Student(
                    email: _emailController.text,
                    name: _nameController.text,
                    surname: _surnameController.text,
                    patronim: _patronimController.text,
                    isBudget: _selectedIsBudget[0],
                    // groupName: "КІ192",
                    groupName: _groupNameController.text,
                    studentCardNumber: _studentCardNumberController.text,
                    entryDate: dt.toIso8601String(),
                    ukrainianLanguageScore:
                        int.parse(_ukrainianLanguageScoreController.text),
                    mathematicsScore:
                        int.parse(_mathematicsScoreController.text),
                    diplomaGrade: int.parse(_diplomaGradeController.text),
                    competitiveScore:
                        int.parse(_competitiveScoreController.text),
                  );

                  try {
                    await userService.addStudent(student);

                    // Вчитель успішно доданий
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Успіх'),
                        content: const Text('Студента успішно додано.'),
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
                        content: Text(
                            'Сталася помилка при додаванні студента. ${error} '),
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
