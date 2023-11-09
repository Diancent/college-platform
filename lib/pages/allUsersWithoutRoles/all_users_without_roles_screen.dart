import 'package:college_platform_mobile/services/auth_service.dart';
import 'package:college_platform_mobile/services/unauthorized_user_service.dart';
import 'package:college_platform_mobile/models/unauthorized_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';

import 'package:college_platform_mobile/routs.dart' as route;

class AllUserWithoutRoleScreen extends StatefulWidget {
  const AllUserWithoutRoleScreen({Key? key}) : super(key: key);

  @override
  State<AllUserWithoutRoleScreen> createState() =>
      _AllUserWithoutRoleScreenState();
}

class _AllUserWithoutRoleScreenState extends State<AllUserWithoutRoleScreen> {
  List<UnauthorizedUser> unauthorizedUsers = [];
  int pageNumber = 1;
  int pageSize = 13;
  bool isLoading = false;
  final UserService userService = UserService();

  @override
  void initState() {
    super.initState();
    _fetchUnauthorizedUsers();
  }

  @override
  Widget build(BuildContext context) {
    // Сортування списку unauthorizedUsers за допомогою методу sort
    unauthorizedUsers.sort((a, b) => b.addedTime.compareTo(a.addedTime));

    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            const SizedBox(width: 8),
            IconButton(
              color: Colors.white,
              icon: const Icon(CupertinoIcons.chevron_back),
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.pushNamed(context, route.home,
                    arguments: userService);
              },
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(30, 26, 82, 1),
        elevation: 0,
        title: const Text(
          "Неавторизовані користувачі",
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (!isLoading &&
              notification is ScrollEndNotification &&
              notification.metrics.extentAfter == 0) {
            // Досягнуто кінця списку, завантаження наступної сторінки
            _loadMoreUnauthorizedUsers();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: unauthorizedUsers.length + 1,
          itemBuilder: (context, index) {
            if (index < unauthorizedUsers.length) {
              final user = unauthorizedUsers[index];
              return ListTile(
                title: Row(
                  children: [
                    Expanded(child: Text(user.email)),
                    Text(
                      _formatTimeAgo(user.addedTime),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                onTap: () {
                  _showMenu(context, user);
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

    /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          _fetchUnauthorizedUsers(); // Завантажити наступну сторінку неавторизованих користувачів
        },
        child: const Icon(Icons.refresh),
      ),
    );*/
  }

  Future<void> _fetchUnauthorizedUsers() async {
    try {
      setState(() {
        isLoading = true;
      });
      final users =
          await userService.getUnauthorizedUsers(pageNumber, pageSize);
      setState(() {
        unauthorizedUsers.addAll(users);
        // pageNumber++;
        isLoading = false;
      });
    } catch (error) {
      // Обробка помилок
      print('Error fetching unauthorized users: $error');
    }
  }

  Future<void> _loadMoreUnauthorizedUsers() async {
    try {
      setState(() {
        isLoading = true;
      });
      final users =
          await userService.getUnauthorizedUsers(pageNumber + 1, pageSize);
      setState(() {
        unauthorizedUsers.addAll(users);
        pageNumber++;
        isLoading = false;
      });
    } catch (error) {
      // Обробка помилок
      print('Error fetching unauthorized users: $error');
    }
  }

  String _formatTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Тільки що';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} хвилин тому';
    } else if (difference.inDays < 1) {
      if (difference.inHours == 1) {
        return '${difference.inHours} годину тому';
      } else {
        return '${difference.inHours} годин тому';
      }
    } else {
      return DateFormat('dd.MM.yyyy').format(time);
    }
  }

  void _showMenu(BuildContext context, UnauthorizedUser user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Створити студента'),
              onTap: () {
                Navigator.pop(context); // Закрити випадаюче меню
                Navigator.pushNamed(context, route.addStudent,
                    arguments: user.email);
              },
            ),
            ListTile(
              title: const Text('Створити викладача'),
              onTap: () {
                Navigator.pop(context); // Закрити випадаюче меню
                Navigator.pushNamed(context, route.addTeacher,
                    arguments: user.email);
              },
            ),
            Container(
              height: 30,
            )
          ],
        );
      },
    );
  }
}
