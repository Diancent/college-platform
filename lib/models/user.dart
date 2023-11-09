import 'dart:convert';

User accountFromJson(String str) => User.fromJson(json.decode(str));

class User {
  final String email;
  final String password;
  final String confirmPassword;

  const User({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        password: json['password'],
        confirmPassword: json['confirmPassword'],
      );
}
