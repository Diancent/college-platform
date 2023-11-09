import 'dart:io';

import 'package:college_platform_mobile/models/get_subject.dart';
import 'package:college_platform_mobile/models/get_teacher.dart';
import 'package:college_platform_mobile/models/group.dart';
import 'package:college_platform_mobile/models/page_group.dart';
import 'package:college_platform_mobile/models/semester.dart';
import 'package:college_platform_mobile/models/student.dart';
import 'package:college_platform_mobile/models/student_additional.dart';
import 'package:college_platform_mobile/models/student_group.dart';
import 'package:college_platform_mobile/models/student_info.dart';
import 'package:college_platform_mobile/models/subject.dart';
import 'package:college_platform_mobile/models/teacher.dart';
import 'package:college_platform_mobile/models/unauthorized_user.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../models/group_semesters.dart';

class UserService {
  final Dio _api = Dio();
  String? _accessToken;
  final _storage = const FlutterSecureStorage();

  UserService() {
    _api.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (!options.path.contains('http')) {
          options.path = 'http://localhost:80${options.path}';
          // options.path = 'https://192.168.88.83:443${options.path}';
        }
        options.headers['Authorization'] = 'Bearer $_accessToken';
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401 &&
            error.response?.data['message'] == 'Invalid JWT') {
          if (await _storage.containsKey(key: 'refreshToken')) {
            await _refreshToken();
            return handler.resolve(await _retry(error.requestOptions));
          }
        }
        return handler.next(error);
      },
    ));
  }

  Future<Response<dynamic>> login(String email, String password) async {
    final response = await _api.post('/api/Account/login',
        data: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      _accessToken = response.data['accessToken'];
      print("вміст JWT: $_accessToken");
      await _storage.write(key: 'accessToken', value: _accessToken!);
    } else if (response.statusCode == 403) {
      throw InvalidStatusCodeException(403);
    } else if (response.statusCode == 404) {
      throw InvalidStatusCodeException(404);
    } else if (response.statusCode == 500) {
      throw InvalidStatusCodeException(500);
    }

    return response;
  }

  Future<Response<dynamic>> register(
      String email, String password, String confirmPassword) async {
    final response = await _api.post(
      '/api/Account/register',
      data: {
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword
      },
    );

    return response;
  }

  Future<void> _refreshToken() async {
    final refreshToken = await _storage.read(key: 'refreshToken');
    final response = await _api.post(
      '/api/Account/refresh-token',
      data: {'refreshToken': refreshToken},
    );
    // 200 все добре
    // 400 - токен не валідний
    // 404 - це левий валідний токін
    if (response.statusCode == 200) {
      _accessToken = response.data['accessToken'];
      await _storage.write(key: 'accessToken', value: _accessToken!);
    } else {
      _accessToken = null;
      await _storage.deleteAll();
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _api.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<bool> isLoggedIn() async {
    _accessToken = await _storage.read(key: 'accessToken');
    return _accessToken != null;
  }

  Future<void> logout() async {
    _accessToken = null;
    await _storage.deleteAll();
  }

  Future<List<UnauthorizedUser>> getUnauthorizedUsers(
      int pageNumber, int pageSize) async {
    try {
      final accessToken = await getAccessToken();
      final options =
          Options(headers: {'Authorization': 'Bearer $accessToken'});
      final response = await _api.get(
        '/api/User/unverified-users',
        options: options,
        queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize},
      );

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        final List<UnauthorizedUser> users = data.map((item) {
          final email = item['email'] as String;
          final registrationTime =
              DateTime.parse(item['registrationTime'] as String);
          return UnauthorizedUser(email, registrationTime);
        }).toList();

        return users;
      } else {
        throw Exception(
            'Помилка отримання неавторизованих користувачів. Код стану: ${response.statusCode}');
      }
    } catch (error) {
      // Обробка помилок при отриманні даних з сервера
      throw Exception('Помилка отримання неавторизованих користувачів: $error');
    }
  }

  Future<List<GetTeacher>> getTeachers(int pageNumber, int pageSize) async {
    try {
      final accessToken = await getAccessToken();
      final options =
          Options(headers: {'Authorization': 'Bearer $accessToken'});
      final response = await _api.get(
        '/api/Teacher/page',
        options: options,
        queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize},
      );

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        final List<GetTeacher> users = data.map((item) {
          final id = item['id'] as String;
          final email = item['email'] as String;
          final name = item['name'] as String;
          final surname = item['surname'] as String;
          final patronim = item['patronim'] as String;
          final phoneNumber = item['phoneNumber'] as String;

          // final registrationTime =
          //     DateTime.parse(item['registrationTime'] as String);
          return GetTeacher(id, email, name, surname, patronim, phoneNumber);
        }).toList();

        return users;
      } else {
        throw Exception(
            'Помилка отримання викладачів. Код стану: ${response.statusCode}');
      }
    } catch (error) {
      // Обробка помилок при отриманні даних з сервера
      throw Exception('Помилка отримання викладачів: $error');
    }
  }

  Future<List<GroupPage>> getGroups(int pageNumber, int pageSize) async {
    try {
      final accessToken = await getAccessToken();
      final options =
          Options(headers: {'Authorization': 'Bearer $accessToken'});
      final response = await _api.get(
        '/api/Group/page',
        options: options,
        queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize},
      );
      if (response.statusCode == 200) {
        List<GroupPage> groups = [];
        for (var groupData in response.data) {
          GroupPage group = GroupPage(groupData['id'], groupData['name']);
          groups.add(group);
        }

        return groups;
      } else {
        throw Exception(
            'Помилка отримання . Код стану: ${response.statusCode}');
      }
    } catch (error) {
      // Обробка помилок при отриманні даних з сервера
      throw Exception('Помилка отримання неавторизованих користувачів: $error');
    }
  }

  Future<List<Map<String, dynamic>>> fetchSemesters(int groupId) async {
    try {
      final accessToken = await getAccessToken();
      final options =
          Options(headers: {'Authorization': 'Bearer $accessToken'});
      final response = await _api.get(
        '/api/Group/semesters',
        options: options,
        queryParameters: {'groupId': groupId},
      );
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      // Обробка помилки
      print('Помилка отримання семестрів: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchSubjects(int semesterId) async {
    try {
      final accessToken = await getAccessToken();
      final options =
          Options(headers: {'Authorization': 'Bearer $accessToken'});
      final response = await _api.get(
        '/api/Group/subjects',
        options: options,
        queryParameters: {'semesterId': semesterId},
      );
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      // Обробка помилки
      print('Помилка отримання предметів: $e');
      return [];
    }
  }

  String? getRoleFromToken() {
    final token = _accessToken;
    Map<String, dynamic> payloadData = JwtDecoder.decode(token!);

    print("вміст JWT payload: $payloadData");

    final roles = payloadData['role'] as List<dynamic>?;
    if (roles != null) {
      if (roles.contains('Administrator')) {
        return 'Адміністратор';
      } else if (roles.contains('Leader')) {
        return 'Лідер';
      } else if (roles.contains('Teacher')) {
        return 'Викладач';
      } else if (roles.contains('Student')) {
        return 'Студент';
      }

      return null; // Роль не знайдена
    }
    return null; // Немає доступного токену
  }

  Future<String?> getAccessToken() async {
    if (_accessToken != null) {
      return _accessToken;
    } else {
      _accessToken = await _storage.read(key: 'accessToken');
      return _accessToken;
    }
  }

  Future<void> addTeacher(Teacher teacher) async {
    try {
      final accessToken = await getAccessToken();
      final options =
          Options(headers: {'Authorization': 'Bearer $accessToken'});
      final response = await _api.post(
        '/api/Teacher',
        options: options,
        data: {
          'email': teacher.email,
          'name': teacher.name,
          'surname': teacher.surname,
          'patronim': teacher.patronim,
          'phoneNumber': teacher.phoneNumber,
          'university': teacher.university,
          'graduationDate': teacher.graduationDate,
          'position': teacher.position,
          'degree': teacher.degree,
          'experience': teacher.experience,
        },
      );

      if (response.statusCode == 201) {
        // Вчитель успішно доданий
        print("Вчителя успішно доданий");
        final responseData = response.data;
      } else {
        print('Помилка сервера: ${response.statusCode}');
        throw Exception(
            'Помилка додавання вчителя. Код стану: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Помилка додавання вчителя: $error');
    }
  }

  Future<void> addStudent(Student student) async {
    try {
      final accessToken = await getAccessToken();
      final options =
          Options(headers: {'Authorization': 'Bearer $accessToken'});
      final response = await _api.post(
        '/api/Student',
        options: options,
        data: {
          'email': student.email,
          'name': student.name,
          'surname': student.surname,
          'patronim': student.patronim,
          'isBudget': student.isBudget,
          'groupName': student.groupName,
          'studentCardNumber': student.studentCardNumber,
          'entryDate': student.entryDate,
          'ukrainianLanguageScore': student.ukrainianLanguageScore,
          'mathematicsScore': student.mathematicsScore,
          'diplomaGrade': student.diplomaGrade,
          'competitiveScore': student.competitiveScore,
        },
      );

      if (response.statusCode == 201) {
        // Студент успішно доданий
        print("Студент успішно доданий");
        final responseData = response.data;
      } else {
        print('Помилка сервера: ${response.statusCode}');
        throw Exception(
            'Помилка додавання студента. Код стану: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Помилка додавання студента: $error');
    }
  }

  Future<bool> isStudentFilledAdditionalInfo() async {
    try {
      final accessToken = await getAccessToken();
      final options =
          Options(headers: {'Authorization': 'Bearer $accessToken'});
      final response = await _api.get(
        '/api/Student/my-additional-info',
        options: options,
      );
      final data = response.data as Map<String, dynamic>;
      final phoneNumber = backPhone(data);
      // ignore: dead_code
      return true ? phoneNumber != null : false;
    } catch (e) {
      // Обробка помилки
      print('Помилка отримання предметів: $e');
      throw Exception('Помилка додавання студента: $e');
    }
  }

  String? backPhone(Map<String, dynamic> json) {
    return json['phoneNumber'];
  }

  Future<void> addAdditionallInfoStudent(
      StudentAdditional studentAdditional) async {
    try {
      final accessToken = await getAccessToken();
      final options =
          Options(headers: {'Authorization': 'Bearer $accessToken'});
      final response = await _api.put(
        '/api/Student/my-additional-info',
        options: options,
        data: {
          'phoneNumber': studentAdditional.phoneNumber,
          'birthday': studentAdditional.birthday,
          'city': studentAdditional.city,
          'street': studentAdditional.street,
          'houseNumber': studentAdditional.houseNumber,
          'apartmentNumber': studentAdditional.apartmentNumber,
          'fatherName': studentAdditional.fatherName,
          'fatherSurname': studentAdditional.fatherSurname,
          'fatherPatronim': studentAdditional.fatherPatronim,
          'fatherPhoneNumber': studentAdditional.fatherPhoneNumber,
          'fatherOrganization': studentAdditional.fatherOrganization,
          'fatherPosition': studentAdditional.fatherPosition,
          'motherName': studentAdditional.motherName,
          'motherSurname': studentAdditional.motherSurname,
          'motherPatronim': studentAdditional.motherPatronim,
          'motherPhoneNumber': studentAdditional.motherPhoneNumber,
          'motherOrganization': studentAdditional.motherOrganization,
          'motherPosition': studentAdditional.motherPosition,
          'isOrphan': studentAdditional.isOrphan,
          'areParentsDivorced': studentAdditional.areParentsDivorced,
          'isFromLowIncomeFamily': studentAdditional.isFromLowIncomeFamily,
          'isRaisedBySingleParent': studentAdditional.isRaisedBySingleParent,
          'isFromLargeFamily': studentAdditional.isFromLargeFamily,
          'isAffectedByChernobyl': studentAdditional.isAffectedByChernobyl,
          'areParentsCombatVeterans':
              studentAdditional.areParentsCombatVeterans,
          'isTemporarilyDisplaced': studentAdditional.isAffectedByChernobyl,
          'isDisabled': studentAdditional.areParentsCombatVeterans,
        },
      );

      if (response.statusCode == 200) {
        // Студент успішно додав про себе інформацію
        print("Студент успішно доданий");
        final responseData = response.data;
      } else {
        print('Помилка сервера: ${response.statusCode}');
        throw Exception(
            'Помилка додавання студента. Код стану: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Помилка додавання студента: $error');
    }
  }

  Future<void> addGroup(GroupSemesters group) async {
    try {
      final accessToken = await getAccessToken();
      final options =
          Options(headers: {'Authorization': 'Bearer $accessToken'});
      final response = await _api.post(
        '/api/Group',
        options: options,
        data: {
          'name': group.groupName,
          'semesters': group.semesters.map((semester) {
            return {
              'value': semester.semesterNumber,
              'subjects': semester.subjects.map((subject) {
                return {'name': subject.subjectName};
              }).toList(),
            };
          }).toList(),
        },
      );

      if (response.statusCode == 201) {
        // Група успішно додана
        print("Група успішно додана");
        final responseData = response.data;
      } else {
        print('Помилка сервера: ${response.statusCode}');
        throw Exception(
            'Помилка додавання групи. Код стану: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Помилка додавання групи: $error');
    }
  }

  Future<Map<String, dynamic>> getTeacherInfo(String teacherId) async {
    try {
      final accessToken = await getAccessToken();
      final options =
          Options(headers: {'Authorization': 'Bearer $accessToken'});
      final response = await _api.get(
        '/api/Teacher',
        options: options,
        queryParameters: {'id': teacherId},
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch teacher information');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<Group> getGroup(int id) async {
    try {
      final accessToken = await getAccessToken();
      final options =
          Options(headers: {'Authorization': 'Bearer $accessToken'});
      final response = await _api.get('/api/Group/$id', options: options);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;

        final List<dynamic> studentsData = data['students'] as List<dynamic>;
        final List<StudentGroup> students = studentsData.map((studentData) {
          return StudentGroup(
            id: studentData['id'] as String,
            email: studentData['email'] as String,
            name: studentData['name'] as String,
            surname: studentData['surname'] as String,
            patronim: studentData['patronim'] as String,
          );
        }).toList();

        final group = Group(
          name: data['name'] as String,
          curatorId:
              data['curatorId'] != null ? data['curatorId'] as int : null,
          curatorName:
              data['curatorName'] != null ? data['curatorName'] as String : '',
          curatorSurname: data['curatorSurname'] != null
              ? data['curatorSurname'] as String
              : '',
          curatorPatronim: data['curatorPatronim'] != null
              ? data['curatorPatronim'] as String
              : '',
          leaderId: data['leaderId'] != null ? data['leaderId'] as int : null,
          leaderName:
              data['leaderName'] != null ? data['leaderName'] as String : '',
          leaderSurname: data['leaderSurname'] != null
              ? data['leaderSurname'] as String
              : '',
          leaderPatronim: data['leaderPatronim'] != null
              ? data['leaderPatronim'] as String
              : '',
          students: students,
        );

        return group;
      } else {
        throw Exception('Помилка отримання даних про групу');
      }
    } catch (e) {
      throw Exception('Помилка під час виконання запиту: $e');
    }
  }

  Future<StudentInfo> getStudentInfo(String studentId) async {
    try {
      final accessToken = await getAccessToken();
      final options =
          Options(headers: {'Authorization': 'Bearer $accessToken'});
      final response = await _api
          .get('/api/Student/base-info', options: options, queryParameters: {
        'id': studentId,
      });

      final data = response.data as Map<String, dynamic>;
      return StudentInfo.fromJson(data);
    } catch (error) {
      // Обробка помилки при виконанні запиту
      throw Exception('Failed to get student information');
    }
  }

  Future<Map<String, dynamic>> getStudentAdditional(String studentId) async {
    try {
      final accessToken = await getAccessToken();
      final options =
          Options(headers: {'Authorization': 'Bearer $accessToken'});
      final response = await _api.get('/api/Student/additional-info',
          options: options,
          queryParameters: {
            'id': studentId,
          });

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        // Обробка помилки, якщо статус код не 200
        throw Exception('Помилка при отриманні інформації про студента');
      }
    } catch (e) {
      // Обробка інших помилок
      throw Exception('Помилка при виконанні запиту: $e');
    }
  }
}

class InvalidStatusCodeException implements Exception {
  final int statusCode;

  InvalidStatusCodeException(this.statusCode);
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
