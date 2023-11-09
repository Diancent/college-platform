import 'package:college_platform_mobile/services/auth_service.dart';
import 'package:college_platform_mobile/pages/wait/wait_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:college_platform_mobile/routs.dart' as route;
import 'dart:convert' show json, base64, ascii;
import 'package:http/http.dart' as http;

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final UserService userService = UserService();
  final _formfield = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obsurePassword = true;

  bool _isLoading = false;
  String _errorText = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formfield,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              labelText: 'Email',
              alignLabelWithHint: true,
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              fillColor: Colors.white,
            ),
            validator: (value) {
              bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value!);
              if (value.isEmpty) {
                return "Введіть Email";
              } else if (!emailValid) {
                return "Введіть дійсну адресу електронної пошти";
              }
              return null;
            },
          ),
          TextFormField(
            textAlign: TextAlign.left,
            controller: _passwordController,
            obscureText: _obsurePassword,
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              labelText: 'Пароль',
              alignLabelWithHint: true,
              labelStyle: const TextStyle(
                color: Colors.grey,
              ),
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              fillColor: Colors.white,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obsurePassword = !_obsurePassword;
                  });
                },
                child: Icon(
                    _obsurePassword ? Icons.visibility_off : Icons.visibility),
              ),
              suffixIconColor:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                if (states.contains(MaterialState.focused)) {
                  return const Color.fromRGBO(30, 26, 82, 1);
                }
                if (states.contains(MaterialState.error)) {
                  return const Color.fromARGB(255, 171, 23, 12);
                }
                return Colors.grey;
              }),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Введіть пароль";
              } else if (_passwordController.text.length < 8) {
                return "Довжина пароля має бути більше 8 символів";
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
          Center(
            child: ElevatedButton(
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
              onPressed: _isLoading
                  ? null
                  : () {
                      if (_formfield.currentState!.validate()) {
                        _login();
                      }
                    },
              child: _isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(30, 26, 82, 1),
                      ),
                    )
                  : const Text(
                      'Далі',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ще не маєш акаунта?',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    route.signUp,
                  );
                },
                child: const Text(
                  'Зареєструватися',
                  style: TextStyle(
                      color: Color.fromRGBO(30, 26, 82, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          if (_errorText.isNotEmpty)
            Text(
              _errorText,
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    setState(() {
      _isLoading = true;
      _errorText = '';
    });

    try {
      final response = await userService.login(email, password);

      setState(() {
        _isLoading = false;
      });

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        String? role = userService.getRoleFromToken();
        print('Роль: $role');
        if (role == 'Студент') {
          if (await userService.isStudentFilledAdditionalInfo()) {
            Navigator.pushReplacementNamed(context, route.home,
                arguments: userService);
          } else {
            Navigator.pushReplacementNamed(context, route.studentAdditionalInfo,
                arguments: userService);
          }
        } else {
          Navigator.pushReplacementNamed(context, route.home,
              arguments: userService);
        }
      } else {
        // Помилка реєстрації
        setState(() {
          _isLoading = false;
          _errorText = response.data['message'];
        });
      }
    } catch (error, stackTrace) {
      // Реєстрація не успішна
      setState(() {
        _isLoading = false;
        if (error is DioException && error.response?.statusCode == 403) {
          // Не верифікований користувач
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WaitScreen()),
          );
        } else if (error is DioException && error.response?.statusCode == 400) {
          // Неправильна пошта або пароль
          _errorText =
              error.response?.data['message'] ?? 'Неправильна пошта або пароль';
        } else {
          // Невідома помилка
          _errorText = 'Невідома помилка';
        }
      });
    }
  }
}
