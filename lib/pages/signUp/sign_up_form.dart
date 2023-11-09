import 'dart:io';

import 'package:college_platform_mobile/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:college_platform_mobile/models/user.dart';

import 'package:college_platform_mobile/routs.dart' as route;

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formfield = GlobalKey<FormState>();
  // var authService = UserService();
  var userService = UserService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
            decoration: InputDecoration(
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

              // isEmailAlreadyRegistered
              //     ? 'Email address is already registered'
              //     : null,
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
            textInputAction: TextInputAction.next,
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
          TextFormField(
            textAlign: TextAlign.left,
            controller: _confirmPasswordController,
            obscureText: _obsurePassword,
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              labelText: 'Підтвердити пароль',
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
                return "Введіть підтвердження пароля";
              } else if (_passwordController.text.length < 8) {
                return "Довжина пароля має бути більше 8 символів";
              } else if (value != _passwordController.text) {
                return 'Паролі не співпадають';
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
              onPressed: () async {
                if (_formfield.currentState!.validate()) {
                  setState(() {
                    _isLoading = true;
                    _errorText = '';
                  });
                  try {
                    User user = User(
                      email: _emailController.text,
                      password: _passwordController.text,
                      confirmPassword: _confirmPasswordController.text,
                    );
                    // Зареєструвати користувача
                    final response = await userService.register(
                        _emailController.text,
                        _passwordController.text,
                        _confirmPasswordController.text);

                    if (response.statusCode == 201) {
                      // Реєстрація успішна
                      // Перенаправлення на домашній екран
                      Navigator.of(context).pushReplacementNamed(route.wait);
                    } else {
                      // Помилка реєстрації
                      setState(() {
                        _isLoading = false;
                        _errorText = response.data['message'];
                      });
                    }
                  } catch (error, stackTrace) {
                    // Реєстрація не успішна
                    print(error);
                    setState(() {
                      _isLoading = false;
                      if (error is DioException &&
                          error.response?.statusCode == 400) {
                        // Така пошта вже існує
                        _errorText = error.response?.data['message'] ??
                            'Такий e-mail вже існує';
                      } else {
                        // Невідома помилка
                        _errorText = 'Помилка: ${error}';
                      }
                    });
                  }
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
                'Уже маєш акаунт?',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, route.signIn);
                },
                child: const Text(
                  'Увійти',
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
}
