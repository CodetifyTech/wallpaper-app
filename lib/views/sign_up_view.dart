import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpapers_hub/views/login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
                            builder: (context) => const LoginView(),
                          ),
                        );
                      },
                      child: const Text('Login'),
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
                  "assets/signup_lottie.json",
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
                                await auth.createUserWithEmailAndPassword(
                                  email: emailTEC.text,
                                  password: passwordTEC.text,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginView(),
                                  ),
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  print('The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  print(
                                      'The account already exists for that email.');
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: const Text('Sign up'),
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
