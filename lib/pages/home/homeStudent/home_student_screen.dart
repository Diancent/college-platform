import 'package:college_platform_mobile/main.dart';
import 'package:college_platform_mobile/pages/home/homeStudent/sections/section_%20follow_up.dart';
import 'package:college_platform_mobile/pages/home/homeStudent/sections/section_study.dart';
import 'package:college_platform_mobile/pages/home/homeStudent/sections/section_toolbar.dart';
import 'package:college_platform_mobile/pages/home/homeStudent/sections/section_updated.dart';
import 'package:college_platform_mobile/pages/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:college_platform_mobile/services/auth_service.dart';
import 'dart:convert' show json, base64, ascii;
import 'package:http/http.dart' as http;
import 'package:college_platform_mobile/routs.dart' as routes;

class HomeStudentScreen extends StatelessWidget {
  final UserService userService;
  const HomeStudentScreen({Key? key, required this.userService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? role = userService.getRoleFromToken();
    print('Роль: $role');

    Widget sectionToolbar = SizedBox.shrink();
    if (role == 'Адміністратор') {
      sectionToolbar = Column(
        children: const [
          SectionToolbar(),
          SizedBox(height: 50),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('$role'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        backgroundColor: const Color.fromRGBO(30, 26, 82, 1),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, routes.setting);
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        children: [
          SectionStudy(
            userService: userService,
          ),
          const SizedBox(height: 50),
          const SectionUpdated(),
          const SizedBox(height: 50),
          sectionToolbar,
          const SectionFollowUp(),
        ],
      ),
    );
  }
}
