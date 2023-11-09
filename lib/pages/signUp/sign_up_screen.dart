import 'package:college_platform_mobile/pages/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:college_platform_mobile/pages/signUp/sign_up_form.dart';
import 'package:college_platform_mobile/routs.dart' as route;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
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
                // Navigator.popAndPushNamed(context, route.welcome);
                // Navigator.pushNamed(context, );
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    ModalRoute.withName(route.welcome));
              },
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(30, 26, 82, 1),
        elevation: 0,
        title: const Text(
          "Реєстрація",
        ),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 75,
              child: Image.asset('assets/images/HPK_herb-Logon.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              "Створити обліковий запис",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            const SignUpForm(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
