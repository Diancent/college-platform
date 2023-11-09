import 'package:college_platform_mobile/pages/signIn/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:college_platform_mobile/routs.dart' as route;

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/hpk2.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: const Color.fromRGBO(30, 26, 82, 0.85),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),
              Column(
                children: [
                  Center(
                    child: Container(
                      width: 140,
                      child: Image.asset('assets/images/HPK_herb-Logon.png'),
                    ),
                  ),
                  const Text(
                    'Welcome To',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const Text(
                    'College',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(241, 240, 244, 1),
                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            minimumSize: const Size.fromHeight(50),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, route.signUp);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Зареєструватись',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(30, 26, 82, 1),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                // const Color.fromRGBO(241, 240, 244, 1),
                                Colors.transparent,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            side: const BorderSide(
                              width: 1.0,
                              color: Color.fromRGBO(241, 240, 244, 1),
                            ),
                            minimumSize: const Size.fromHeight(50),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SignInScreen()));
                            Navigator.pushNamed(context, route.signIn);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Увійти',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(241, 240, 244, 1),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
