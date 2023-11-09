import 'package:college_platform_mobile/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college_platform_mobile/routs.dart' as route;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserService userService = UserService();
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
          "Налаштування",
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      ),
      body: ListView(
        children: [
          // const SizedBox(height: 30),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 7),
                ],
              ),
            ],
          ),
          const SizedBox(height: 35),
          divider(),
          section("Legal"),
          settingsCell("Terms of Use"),
          divider(),
          settingsCell("Privacy Policy"),
          divider(),
          section("Особисті"),
          settingsCell("Повідомити про помилку"),
          divider(),
          settingsLogoutCell("Вийти", () {
            userService.logout();
            Navigator.pushReplacementNamed(context, route.welcome);
          }),
          divider(),
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
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  CupertinoButton settingsLogoutCell(String label, VoidCallback onPressed) {
    return CupertinoButton(
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      onPressed: onPressed, // Використовуйте переданий параметр onPressed
      alignment: Alignment.centerLeft,
    );
  }

  CupertinoButton settingsCell(String label) {
    return CupertinoButton(
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          // "Edit Profile",
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      onPressed: () {},
      alignment: Alignment.centerLeft,
    );
  }

  Divider divider() {
    return const Divider(
      color: Colors.grey,
      height: 1,
    );
  }
}
