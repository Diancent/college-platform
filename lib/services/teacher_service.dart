import 'dart:convert';
import 'package:college_platform_mobile/models/teacher.dart';
import 'package:dio/dio.dart';
import 'package:college_platform_mobile/services/auth_service.dart';

class TeacherService {
  static final TeacherService instance = TeacherService._();
  factory TeacherService() => instance;
  TeacherService._();

  final Dio _dio = Dio(); // Створюємо об'єкт Dio для виконання HTTP-запитів

  Future<Teacher?> submitData(Teacher teacher) async {
    /*try {
      final authService = AuthService(); // Створюємо екземпляр AuthService
      final accessToken = await authService
          .getAccessToken(); // Отримуємо токен доступу з AuthService
      final data = {
        'email': teacher.email,
        'name': teacher.name,
        'surname': teacher.surname,
        'patronim': teacher.patronim,
      };
      final options =
          Options(headers: {'Authorization': 'Bearer $accessToken'});

      final response = await _dio.post(
        'http://localhost:80/api/Teacher',
        data: data,
        options: options, // Додаємо опції з токеном до запиту
      );

      if (response.statusCode == 200) {
        // Успішно відправлено дані на сервер
        final responseData = response.data;
        // Декодуємо отримані дані та повертаємо об'єкт Teacher
        return Teacher.fromJson(responseData);
      } else {
        // Якщо сервер повернув інший код відповіді
        print('Помилка сервера: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      // Обробка помилки під час виконання HTTP-запиту
      print('Помилка під час відправки даних на сервер: $error');
      return null;
    }*/
  }
}
