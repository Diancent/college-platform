import 'package:college_platform_mobile/models/student_additional.dart';
import 'package:college_platform_mobile/services/auth_service.dart';
import 'package:college_platform_mobile/lists/group_info.dart';
import 'package:college_platform_mobile/models/student.dart';
import 'package:college_platform_mobile/widgets/dropdown_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college_platform_mobile/routs.dart' as route;

import '../../widgets/separator.dart';

const List<Widget> isBudget = <Widget>[Text('Так'), Text('Ні')];

class StudentAdditionalInfoScreen extends StatefulWidget {
  const StudentAdditionalInfoScreen({Key? key}) : super(key: key);

  @override
  State<StudentAdditionalInfoScreen> createState() =>
      _StudentAdditionalInfoScreenState();
}

class _StudentAdditionalInfoScreenState
    extends State<StudentAdditionalInfoScreen>
    with AutomaticKeepAliveClientMixin {
  late String selectedValue;

  final int _selectedIsBudgetIndex = 0;

  final List<bool> _selectedIsOrphan = [false, true];
  final List<bool> _selectedAreParentsDivorced = [false, true];
  final List<bool> _selectedIsFromLowIncomeFamily = [false, true];
  final List<bool> _selectedIsRaisedBySingleParent = [false, true];
  final List<bool> _selectedIsFromLargeFamily = [false, true];
  final List<bool> _selectedIsAffectedByChernobyl = [false, true];
  final List<bool> _selectedAreParentsCombatVeterans = [false, true];
  final List<bool> _selectedIsTemporarilyDisplaced = [false, true];
  final List<bool> _selectedIsDisabled = [false, true];
  final UserService userService = UserService();
  bool vertical = false;
  bool _isLoading = false;

  late final _formfield = GlobalKey<FormState>();

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();
  final TextEditingController _apartmentNumberController =
      TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _fatherSurnameController =
      TextEditingController();
  final TextEditingController _fatherPatronimController =
      TextEditingController();
  final TextEditingController _fatherPhoneNumberController =
      TextEditingController();
  final TextEditingController _fatherOrganizationController =
      TextEditingController();
  final TextEditingController _fatherPositionController =
      TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _motherSurnameController =
      TextEditingController();
  final TextEditingController _motherPatronimController =
      TextEditingController();
  final TextEditingController _motherPhoneNumberController =
      TextEditingController();
  final TextEditingController _motherOrganizationController =
      TextEditingController();
  final TextEditingController _motherPositionController =
      TextEditingController();

  RegExp get _nameRegex =>
      RegExp(r'^([А-ЩЬЮЯЇІЄҐ]{1}[а-щьюяїієґ]{1,23}|[A-Z]{1}[a-z]{1,23})$');
  RegExp get _dateRegex => RegExp(
      r'^\s*(3[01]|[12][0-9]|0?[1-9])\.(1[012]|0?[1-9])\.((?:19|20)\d{2})\s*$');

  @override
  bool get wantKeepAlive => true;

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Успіх'),
        content: const Text('Ви додали додаткові параметри'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, route.home, arguments: userService);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, dynamic error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Помилка'),
        content: Text('Сталася помилка при додаванні студента. ${error}'),
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

  void _handleSubmit(BuildContext context) async {
    if (_birthdayController.text.isEmpty) {
      print("check");
      _formfield.currentState!.activate();
    }
    if (_formfield.currentState!.validate() &&
        _birthdayController.text.isNotEmpty) {
      final splited = _birthdayController.text.split(".");

      final dt = DateTime.utc(
        int.parse(splited[2]),
        int.parse(splited[1]),
        int.parse(splited[0]),
      );
      final student = StudentAdditional(
        phoneNumber: _phoneNumberController.text,
        birthday: dt.toIso8601String(),
        city: _cityController.text,
        street: _streetController.text,
        houseNumber: _houseNumberController.text,
        apartmentNumber: _apartmentNumberController.text,
        fatherName: _fatherNameController.text,
        fatherSurname: _fatherSurnameController.text,
        fatherPatronim: _fatherPatronimController.text,
        fatherPhoneNumber: _fatherPhoneNumberController.text,
        fatherOrganization: _fatherOrganizationController.text,
        fatherPosition: _fatherPositionController.text,
        motherName: _fatherNameController.text,
        motherSurname: _fatherSurnameController.text,
        motherPatronim: _fatherPatronimController.text,
        motherPhoneNumber: _fatherPhoneNumberController.text,
        motherOrganization: _fatherOrganizationController.text,
        motherPosition: _fatherPositionController.text,
        isOrphan: _selectedIsOrphan[0],
        areParentsDivorced: _selectedAreParentsDivorced[0],
        isFromLowIncomeFamily: _selectedIsFromLowIncomeFamily[0],
        isRaisedBySingleParent: _selectedIsRaisedBySingleParent[0],
        isFromLargeFamily: _selectedIsFromLargeFamily[0],
        isAffectedByChernobyl: _selectedIsAffectedByChernobyl[0],
        areParentsCombatVeterans: _selectedAreParentsCombatVeterans[0],
        isTemporarilyDisplaced: _selectedIsTemporarilyDisplaced[0],
        isDisabled: _selectedIsDisabled[0],
      );

      try {
        await userService.addAdditionallInfoStudent(student);
        _showSuccessDialog(context);
      } catch (error) {
        _showErrorDialog(context, error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          "Анкета",
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => Form(
          key: _formfield,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 28),
                const Text(
                  "Заповнення \nанкети",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 30),
                const MySeparator(
                  height: 1.0,
                  color: Colors.grey,
                ),
                const SizedBox(height: 30),
                const Text(
                  "Персональна інформація",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                _buildPhoneNumber(),
                const SizedBox(height: 20),
                _buildBirthday(),
                const SizedBox(height: 20),
                _buildCity(),
                const SizedBox(height: 20),
                _buildStreet(),
                const SizedBox(height: 20),
                _buildHouseNumber(),
                const SizedBox(height: 20),
                _buildApartmentNumber(),
                const SizedBox(height: 40),
                _buildSeparator(),
                const SizedBox(height: 40),
                const Text(
                  "Батько",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                _buildFatherName(),
                const SizedBox(height: 20),
                _buildFatherSurname(),
                const SizedBox(height: 20),
                _buildFatherPatronim(),
                const SizedBox(height: 20),
                _buildFatherPhoneNumber(),
                const SizedBox(height: 20),
                _buildFatherPosition(),
                const SizedBox(height: 20),
                _buildFatherOrganization(),
                const SizedBox(height: 50),
                _buildSeparator(),
                const SizedBox(height: 50),
                const Text(
                  "Матір",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                _buildMotherName(),
                const SizedBox(height: 20),
                _buildMotherSurname(),
                const SizedBox(height: 20),
                _buildMotherPatronim(),
                const SizedBox(height: 20),
                _buildMotherPhoneNumber(),
                const SizedBox(height: 20),
                _buildMotherPosition(),
                const SizedBox(height: 20),
                _buildMotherOrganization(),
                const SizedBox(height: 40),
                _buildSeparator(),
                const SizedBox(height: 30),
                _buildToggleButtons(
                  title: 'Сирота',
                  isSelected: _selectedIsOrphan,
                  children: isBudget,
                ),
                _buildToggleButtons(
                  title: 'Розведені батьки',
                  isSelected: _selectedAreParentsDivorced,
                  children: isBudget,
                ),
                _buildToggleButtons(
                  title: 'Малодітна сім\'я',
                  isSelected: _selectedIsFromLowIncomeFamily,
                  children: isBudget,
                ),
                _buildToggleButtons(
                  title: 'Виховується одним із батьків',
                  isSelected: _selectedIsRaisedBySingleParent,
                  children: isBudget,
                ),
                _buildToggleButtons(
                  title: 'З багатодітної сім\'ї',
                  isSelected: _selectedIsFromLargeFamily,
                  children: isBudget,
                ),
                _buildToggleButtons(
                  title: 'Чорнобилець',
                  isSelected: _selectedIsAffectedByChernobyl,
                  children: isBudget,
                ),
                _buildToggleButtons(
                  title: 'Батьки УБД',
                  isSelected: _selectedAreParentsCombatVeterans,
                  children: isBudget,
                ),
                _buildToggleButtons(
                  title: 'Тимчасово переміщений',
                  isSelected: _selectedIsTemporarilyDisplaced,
                  children: isBudget,
                ),
                _buildToggleButtons(
                  title: 'Інвалід',
                  isSelected: _selectedIsDisabled,
                  children: isBudget,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: const Color.fromRGBO(30, 26, 82, 1),
                    minimumSize: const Size.fromHeight(45),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () async {
                    _handleSubmit(context);
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  MySeparator _buildSeparator() {
    return const MySeparator(
      height: 1.0,
      color: Colors.grey,
    );
  }

  TextFormField _buildMotherOrganization() {
    return TextFormField(
      controller: _motherOrganizationController,
      decoration: const InputDecoration(
        labelText: "Місце роботи",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Введіть місце роботи";
        } else if (!_nameRegex.hasMatch(value)) {
          return "Ви ввели правильне місце роботи?";
        }
        return null;
      },
    );
  }

  TextFormField _buildMotherPosition() {
    return TextFormField(
      controller: _motherPositionController,
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
    );
  }

  TextFormField _buildMotherPhoneNumber() {
    return TextFormField(
      controller: _motherPhoneNumberController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Номер телефону",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Введіть номер телефону";
        }
        return null;
      },
    );
  }

  TextFormField _buildMotherPatronim() {
    return TextFormField(
      controller: _motherPatronimController,
      decoration: const InputDecoration(
        labelText: "Ім'я по батькові",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Введіть ім'я по батькові";
        } else if (!_nameRegex.hasMatch(value)) {
          return "Ви ввели правильне ім'я по батькові?";
        }
        return null;
      },
    );
  }

  TextFormField _buildMotherSurname() {
    return TextFormField(
      controller: _motherSurnameController,
      decoration: const InputDecoration(
        labelText: "Прізвище",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Введіть прізвище";
        } else if (!_nameRegex.hasMatch(value)) {
          return "Ви ввели правильне прізвище";
        }
        return null;
      },
    );
  }

  TextFormField _buildMotherName() {
    return TextFormField(
      controller: _motherNameController,
      decoration: const InputDecoration(
        labelText: "Ім'я",
        hintStyle: TextStyle(color: Colors.grey),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Введіть ім'я";
        } else if (!_nameRegex.hasMatch(value)) {
          return "Ви ввели правильне ім'я?";
        }
        return null;
      },
    );
  }

  TextFormField _buildFatherOrganization() {
    return TextFormField(
      controller: _fatherOrganizationController,
      decoration: const InputDecoration(
        labelText: "Місце роботи",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Введіть місце роботи";
        } else if (!_nameRegex.hasMatch(value)) {
          return "Ви ввели правильне місце роботи?";
        }
        return null;
      },
    );
  }

  TextFormField _buildFatherPosition() {
    return TextFormField(
      controller: _fatherPositionController,
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
    );
  }

  TextFormField _buildFatherPhoneNumber() {
    return TextFormField(
      controller: _fatherPhoneNumberController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Номер телефону",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Введіть номер телефону";
        }
        return null;
      },
    );
  }

  TextFormField _buildFatherPatronim() {
    return TextFormField(
      controller: _fatherPatronimController,
      decoration: const InputDecoration(
        labelText: "Ім'я по батькові",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Введіть ім'я по батькові";
        } else if (!_nameRegex.hasMatch(value)) {
          return "Ви ввели правильне ім'я по батькові?";
        }
        return null;
      },
    );
  }

  TextFormField _buildFatherSurname() {
    return TextFormField(
      controller: _fatherSurnameController,
      decoration: const InputDecoration(
        labelText: "Прізвище",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Введіть прізвище";
        } else if (!_nameRegex.hasMatch(value)) {
          return "Ви ввели правильне прізвище";
        }
        return null;
      },
    );
  }

  TextFormField _buildFatherName() {
    return TextFormField(
      controller: _fatherNameController,
      decoration: const InputDecoration(
        labelText: "Ім'я",
        hintStyle: TextStyle(color: Colors.grey),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Введіть ім'я";
        } else if (!_nameRegex.hasMatch(value)) {
          return "Ви ввели правильне ім'я?";
        }
        return null;
      },
    );
  }

  TextFormField _buildApartmentNumber() {
    return TextFormField(
      controller: _apartmentNumberController,
      decoration: const InputDecoration(
        labelText: "Номер квартири",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Введіть номер квартири";
        }
        return null;
      },
    );
  }

  TextFormField _buildHouseNumber() {
    return TextFormField(
      controller: _houseNumberController,
      decoration: const InputDecoration(
        labelText: "Номер будинку",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Введіть номер будинку";
        } else {
          return null;
        }
      },
    );
  }

  TextFormField _buildStreet() {
    return TextFormField(
      controller: _streetController,
      decoration: const InputDecoration(
        labelText: "Вулиця",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Введіть вулицю";
        } else if (!_nameRegex.hasMatch(value)) {
          return "Ви ввели правильно вулицю?";
        }
        return null;
      },
    );
  }

  TextFormField _buildCity() {
    return TextFormField(
      controller: _cityController,
      decoration: const InputDecoration(
        labelText: "Місто",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Введіть місто";
        } else if (!_nameRegex.hasMatch(value)) {
          return "Ви ввели правильне місто?";
        }
        return null;
      },
    );
  }

  TextFormField _buildBirthday() {
    return TextFormField(
      controller: _birthdayController,
      decoration: const InputDecoration(
          labelText: "Дата народження",
          hintText: "ДД.ММ.РРРР",
          hintStyle: TextStyle(color: Colors.grey)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Введіть дату народження";
        } else if (!_dateRegex.hasMatch(value)) {
          return "Неправильний формат";
        }
        return null;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      controller: _phoneNumberController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Номер телефону",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Введіть номер телефону";
        }
        return null;
      },
    );
  }

  Widget _buildToggleButtons({
    required String title,
    required List<bool> isSelected,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 5),
        ToggleButtons(
          direction: vertical ? Axis.vertical : Axis.horizontal,
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0;
                  buttonIndex < isSelected.length;
                  buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = !isSelected[buttonIndex];
                } else {
                  isSelected[buttonIndex] = false;
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
          isSelected: isSelected,
          children: children,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
