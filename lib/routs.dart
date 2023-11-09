import 'package:college_platform_mobile/pages/settings/settings_screen.dart';
import 'package:college_platform_mobile/pages/studentAdditionalInfo/student_additional_info.dart';
import 'package:college_platform_mobile/services/auth_service.dart';
import 'package:college_platform_mobile/pages/addGroup/add_group_page.dart';
import 'package:college_platform_mobile/pages/allGroups/all_groups_screen.dart';
import 'package:college_platform_mobile/pages/allTeachers/all_teachers_screen.dart';
import 'package:college_platform_mobile/pages/allUsersWithoutRoles/all_users_without_roles_screen.dart';
import 'package:college_platform_mobile/pages/events/events_screen.dart';
import 'package:college_platform_mobile/pages/gradeJournal/grade_journal_page.dart';
import 'package:college_platform_mobile/pages/newsDetail/news_detail_screen.dart';
import 'package:college_platform_mobile/pages/newsFeed/news_feed_screen.dart';
import 'package:college_platform_mobile/pages/schedule/schedule_screen.dart';
import 'package:college_platform_mobile/pages/scheduleChange/schedule_change_page.dart';
import 'package:college_platform_mobile/pages/signIn/sign_in_screen.dart';
import 'package:college_platform_mobile/pages/signUp/sign_up_screen.dart';
import 'package:college_platform_mobile/pages/teacherDetail/teacher_detail_screen.dart';
import 'package:college_platform_mobile/pages/wait/wait_screen.dart';
import 'package:college_platform_mobile/pages/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'package:college_platform_mobile/pages/addStudent/add_student_screen.dart';
import 'package:college_platform_mobile/pages/addTeacher/add_teacher_screen.dart';
import 'package:college_platform_mobile/pages/groupList/group_list_screen.dart';
import 'package:college_platform_mobile/pages/home/homeStudent/home_student_screen.dart';
import 'package:college_platform_mobile/pages/student/student_screen.dart';

// Route Names
const String welcome = 'welcome';
const String signIn = 'signIn';
const String signUp = 'signUp';
const String wait = 'wait';
const String home = 'home';
const String studentAdditionalInfo = 'studentAdditionalInfo';
const String schedule = 'schedule';
const String gradeJournal = 'gradeJournal';
const String allGroups = 'allGroups';
const String groupList = 'groupList';
const String student = 'student';
const String teacherDetail = 'teacherDetail';
const String addStudent = 'addStudent';
const String addTeacher = 'addTeacher';
const String allTeachers = 'allTeachers';
const String events = 'events';
const String newsFeed = 'newsFeed';
const String newsDetail = 'newsDetail';
const String scheduleChange = 'scheduleChange';
const String allUsersWithoutRoles = 'allUsersWithoutRoles';
const String addGroup = 'addGroup';
const String setting = 'setting';

// Control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case welcome:
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());
    case signIn:
      return MaterialPageRoute(builder: (context) => const SignInScreen());
    case signUp:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case wait:
      return MaterialPageRoute(builder: (context) => const WaitScreen());
    case home:
      final authService = settings.arguments as UserService;
      return MaterialPageRoute(
          builder: (context) => HomeStudentScreen(userService: authService));
      // case home:
      //   return MaterialPageRoute(builder: (context) => const HomeStudentScreen());
      // case schedule:
      return MaterialPageRoute(builder: (contex) => const ScheduleScreen());
    case studentAdditionalInfo:
      return MaterialPageRoute(
          builder: (context) => const StudentAdditionalInfoScreen());
    case gradeJournal:
      return MaterialPageRoute(builder: (context) => const GradeJournalPage());
    case allGroups:
      return MaterialPageRoute(
          builder: (context) => AllGroupsScreen(
                key: UniqueKey(),
              ));
    // case groupList:
    //   return MaterialPageRoute(builder: (context) => const GroupListScreen());
    // case student:
    //   return MaterialPageRoute(builder: (context) => const StudentScreen(student: student));
    // case teacherDetail:
    //   return MaterialPageRoute(
    //       builder: (context) => const TeacherDetailScreen());
    case addStudent:
      final String email = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => AddStudentScreen(email: email));
    case addTeacher:
      final String email = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => AddTeacherScreen(email: email));
    case allTeachers:
      return MaterialPageRoute(builder: (context) => const AllTeachersScreen());
    case events:
      return MaterialPageRoute(builder: (context) => EventsPage());
    case newsFeed:
      return MaterialPageRoute(builder: (context) => const NewsFeedScreen());
    case newsDetail:
      return MaterialPageRoute(builder: (context) => const NewsDetailScreen());
    case scheduleChange:
      return MaterialPageRoute(
          builder: (context) => ScheduleChangePage(
                scheduleData:
                    ModalRoute.of(context)!.settings.arguments as List<String>,
              ));
    case allUsersWithoutRoles:
      return MaterialPageRoute(
          builder: (context) => const AllUserWithoutRoleScreen());
    case addGroup:
      return MaterialPageRoute(builder: (context) => const AddGroupPage());
    case schedule:
      return MaterialPageRoute(builder: (context) => const ScheduleScreen());
    case setting:
      return MaterialPageRoute(builder: (context) => const SettingsScreen());
    default:
      throw ('This route name does not exist');
  }
}
