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

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({super.key});

  @override
  State<RecoveryPage> createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  final _key = GlobalKey<FormState>();

  String errorMessage = "";
  bool _submitting = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final OutlineInputBorder _inputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  Future resetPassword() async {
    setState(() {
      _submitting = true;
    });
    
    await Future.delayed(const Duration(seconds: 3));

    try {
      await FireUser.auth.sendPasswordResetEmail(email: _controllerEmail.text);
      ToSignIn();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Recovery sent to ${_controllerEmail.text}")),
      );
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }

    
    setState(() {
      _submitting = false;
    });
  }

  void ToSignIn() {
    Navigator.of(context).push(PageTransition(
      type: PageTransitionType.leftToRightJoined,
      curve: Curves.easeInOutQuart,
      childCurrent: widget,
      child: const SignInPage(),
      duration: const Duration(milliseconds: 500),
    ));
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
                    Icons.lock_reset,
                    size: 128,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    "ACCOUNT RECOVERY",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Reset account password",
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
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(256, 64),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                              backgroundColor: const Color(0xFF2D3436),
                            ),
                            onPressed: resetPassword,
                            child: Center(
                              child: _submitting
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'Send Link',
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
                              "Continue Login",
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
