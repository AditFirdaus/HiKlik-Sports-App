import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sports/Pages/Classes/UserData.dart';
import 'package:sports/Pages/HomePage.dart';
import 'package:sports/Pages/SignInPage.dart';
import 'package:sports/Pages/VerificationPage.dart';
import 'package:sports/Pages/api/contents-api.dart';
import 'package:sports/Pages/user-api.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _key = GlobalKey<FormState>();

  String errorMessage = "";
  bool _submitting = false;

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();

  final OutlineInputBorder _inputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  Future SignUp() async {
    if (_key.currentState!.validate()) {
      final String username = _controllerUsername.text;
      final String email = _controllerEmail.text;
      final String password = _controllerPassword.text;
      final String confirmPassword = _controllerConfirmPassword.text;

      setState(() {
        _submitting = true;
      });

      log("""Sign Up using 
    email: $email
    password: $password""");

      try {
        if (password != confirmPassword) {
          throw FirebaseAuthException(
            code: "Password_Not_Match",
            message: "Password not match",
          );
        }

        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        UserData userData = UserData();
        userData.name = username;
        userData.uid = credential.user!.uid;
        FireDatabase.setUserData(userData.uid, userData);
        await FireUser.SyncUp();
        await FireUser.SyncIn();
        log("""Sign Up successfull with credentials: ${credential.toString()}""");
        log("""UserData: ${userData.toString()}""");
        try {
          credential.user!.sendEmailVerification();
          log("Email Verification has been sent to ${credential.user!.email}");
        } catch (e) {
          log("Sending email verification failed");
        }
        Navigator.of(context).pushReplacement(PageTransition(
          type: PageTransitionType.topToBottomJoined,
          curve: Curves.easeOutExpo,
          childCurrent: widget,
          child: const VerificationPage(),
          duration: const Duration(milliseconds: 500),
        ));
      } on FirebaseAuthException catch (e) {
        log('Sign Up failed with error code: ${e.code}');
        errorMessage = e.message!;
        log(errorMessage);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));
      }
      setState(() {
        _submitting = false;
      });
    }
  }

  void ToSignIn() {
    Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.leftToRightJoined,
        curve: Curves.easeInOutQuart,
        childCurrent: widget,
        child: const SignInPage(),
        duration: const Duration(milliseconds: 500),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            primary: false,
            clipBehavior: Clip.none,
            child: Padding(
              padding: const EdgeInsets.all(64.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_pin_rounded,
                    size: 128,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    "CREATE ACCOUNT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Setup an account",
                    textAlign: TextAlign.center,
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
                          controller: _controllerUsername,
                          decoration: InputDecoration(
                            hintText: 'Enter your Username',
                            labelText: 'Username *',
                            border: _inputBorder,
                          ),
                          onSaved: (String? value) {},
                          validator: (String? value) {
                            if (value == "") return "Must not be empty.";
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _controllerEmail,
                          decoration: InputDecoration(
                            hintText: 'Enter your Email',
                            labelText: 'Email *',
                            border: _inputBorder,
                          ),
                          onSaved: (String? value) {},
                          validator: (String? value) {
                            if (value == "") return "Must not be empty.";
                            if (value != null && !value.contains("@")) {
                              return "Must be an email.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _controllerPassword,
                          decoration: InputDecoration(
                            hintText: 'Enter your Password',
                            labelText: 'Password',
                            border: _inputBorder,
                          ),
                          obscureText: true,
                          onSaved: (String? value) {},
                          validator: (String? value) {
                            if (value == "") return "Must not be empty.";
                            if (value != null && !(value.length >= 6)) {
                              return "Must 6 characters long.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _controllerConfirmPassword,
                          decoration: InputDecoration(
                            hintText: 'Confirm your Password',
                            labelText: 'Confirm Password ',
                            border: _inputBorder,
                          ),
                          obscureText: true,
                          onSaved: (String? value) {},
                          validator: (String? value) {
                            if (value != _controllerPassword.text) {
                              return "Password not match.";
                            }
                            return null;
                          },
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
                            onPressed: SignUp,
                            child: Center(
                              child: _submitting
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'Register',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: TextButton(
                            onPressed: ToSignIn,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(256, 64),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                              foregroundColor: const Color(0xFF2D3436),
                            ),
                            child: const Text(
                              "I've already have an Account",
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
          ),
        ),
      ),
    );
  }
}
