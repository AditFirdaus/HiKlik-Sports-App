import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sports/Pages/HomePage.dart';
import 'package:sports/Pages/SignUpPage.dart';
import 'package:sports/Pages/user-api.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _key = GlobalKey<FormState>();

  String errorMessage = "";
  bool _submitting = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  final OutlineInputBorder _inputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  Future SignIn() async {
    setState(() {
      _submitting = true;
    });

    // final String email = _controllerEmail.text;
    // final String password = _controllerPassword.text;
    
    final String _email = "aditfirdaus.dml@gmail.com";
    final String _password = "123456";

    try {
      await FireUser.SignIn(_email, _password);
      Navigator.of(context).pushReplacement(PageTransition(
        type: PageTransitionType.topToBottomJoined,
        curve: Curves.easeOutExpo,
        childCurrent: widget,
        child: const HomePage(),
        duration: const Duration(seconds: 1),
      ));
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message!;
    }

    setState(() {
      _submitting = false;
    });
  }

  void ToSignUp() {
    Navigator.of(context).pushReplacement(PageTransition(
      type: PageTransitionType.rightToLeftJoined,
      curve: Curves.easeInOutQuart,
      childCurrent: widget,
      child: const SignUpPage(),
      duration: const Duration(milliseconds: 750),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRect(
        child: Scaffold(
          body: Center(
            child: ListView(shrinkWrap: true, children: [
              Padding(
                padding: const EdgeInsets.all(64.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.sports_soccer,
                      size: 192,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Login to continue",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _controllerEmail,
                            decoration: InputDecoration(
                              hintText: 'Enter your Email',
                              labelText: 'Email',
                              border: _inputBorder,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _controllerPassword,
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                              labelText: 'Password',
                              border: _inputBorder,
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(256, 64),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                backgroundColor: const Color(0xFF2D3436),
                              ),
                              onPressed: SignIn,
                              child: Center(
                                child: _submitting
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text('Login'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: TextButton(
                              onPressed: ToSignUp,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(256, 64),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                foregroundColor: const Color(0xFF2D3436),
                              ),
                              child: const Text(
                                "Create an account",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              errorMessage,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
