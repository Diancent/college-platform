import 'dart:io';

import 'package:college_platform_mobile/pages/addGroup/add_group_page.dart';
import 'package:college_platform_mobile/pages/allUsersWithoutRoles/all_users_without_roles_screen.dart';
import 'package:college_platform_mobile/pages/home/homeStudent/home_student_screen.dart';
import 'package:college_platform_mobile/pages/newsDetail/news_detail_screen.dart';
import 'package:college_platform_mobile/pages/newsFeed/news_feed_screen.dart';
import 'package:college_platform_mobile/pages/schedule/schedule_screen.dart';
import 'package:college_platform_mobile/pages/scheduleChange/schedule_change_page.dart';
import 'package:college_platform_mobile/pages/test/group_input_page.dart';
import 'package:college_platform_mobile/pages/test/semester_page.dart';
import 'package:college_platform_mobile/pages/welcome/welcome_screen.dart';
import 'package:college_platform_mobile/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show json, base64, ascii;

import 'routs.dart' as route;

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // Future<String> get jwtOrEmpty async {
  //   var jwt = await storage.read(key: "jwt");
  //   if (jwt == null) return "";
  //   return jwt;
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'College Platform',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: route.controller,
      initialRoute: route.studentAdditionalInfo,
    );
  }
}
