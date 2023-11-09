import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:college_platform_mobile/pages/signIn/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(30, 26, 82, 1),
        elevation: 0,
        title: const Text(
          "Увійти",
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
              "Увійти в наявний обліковий запис",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            const SignInForm(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
