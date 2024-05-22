import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpapers_hub/views/home_page.dart';
import 'package:wallpapers_hub/views/sign_up_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailTEC = TextEditingController();
  final passwordTEC = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailTEC.dispose();
    passwordTEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpView(),
                          ),
                        );
                      },
                      child: const Text('Sign Up'),
                    )
                  ],
                ),
                const SizedBox(height: 80),
                const Text(
                  'Sign Up Now',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 50),
                LottieBuilder.asset(
                  "assets/login_lottie.json",
                  width: MediaQuery.sizeOf(context).width - 100,
                  height: MediaQuery.sizeOf(context).height / 3,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailTEC,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: passwordTEC,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                await auth.signInWithEmailAndPassword(
                                  email: emailTEC.text,
                                  password: passwordTEC.text,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print(
                                      'Wrong password provided for that user.');
                                }
                              }
                            },
                            child: const Text('Login'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
