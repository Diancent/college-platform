import 'package:college_platform_mobile/models/unauthorized_user.dart';
import 'package:dio/dio.dart';

class UnauthorizedUserService {
  final Dio _dio = Dio();

  Future<List<UnauthorizedUser>> getUnauthorizedUsers(
      String accessToken) async {
    try {
      final options =
          Options(headers: {'Authorization': 'Bearer $accessToken'});
      final response = await _dio.get(
        'http://localhost:80/api/User/unverified-user',
        options: options,
      );
      final data = response.data as List<dynamic>;
      final List<UnauthorizedUser> users = data.map((item) {
        final email = item['email'] as String;
        final addedTime = DateTime.parse(item['addedTime'] as String);
        return UnauthorizedUser(email, addedTime);
      }).toList();

      return users;
    } catch (error) {
      // Обробка помилок при отриманні даних з сервера
      throw Exception('Error fetching unauthorized users: $error');
    }
  }
}
