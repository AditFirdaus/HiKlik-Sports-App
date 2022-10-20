
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sports/Pages/HomePage.dart';
import 'package:sports/Pages/SignInPage.dart';
import 'package:sports/Pages/VerificationPage.dart';
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              );

  Future SignUp() async {

    final String _username = _controllerUsername.text;
    final String _email =  _controllerEmail.text;
    final String _password =  _controllerPassword.text;
    final String _confirmPassword =  _controllerConfirmPassword.text;

    setState(() {
      _submitting = true;
    });

    try {
      if (_password != _confirmPassword) {
        throw FirebaseAuthException(
          code: "Password_Not_Match",
          message: "Password not match",
        );
      }
      await FireUser.SignUp(_email, _password);
      Navigator.of(context).pushReplacement(
        PageTransition(
          type: PageTransitionType.topToBottomJoined,
          curve: Curves.easeOutExpo,
          childCurrent: widget,
          child: const VerificationPage(),
          duration: const Duration(milliseconds: 500),
        )
      );
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message!;
    }

    setState(() {
      _submitting = false;
    });
  }

  void ToSignIn()
  {
    Navigator.of(context).pushReplacement(
      PageTransition(
        type: PageTransitionType.leftToRightJoined,
        curve: Curves.easeInOutQuart,
        childCurrent: widget,
        child: const SignInPage(),
        duration: const Duration(milliseconds: 750),
      )
    );
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
                      Icons.person_pin_rounded,
                      size: 128,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Setup an account",
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
                          const SizedBox(height: 16,),
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
                          const SizedBox(height: 16,),
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
                              if (value != null && !(value.length > 8)) {
                                return "Must 8 characters long.";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 16,),
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
                          const SizedBox(height: 16,),
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
                                    ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    : const Text('Register'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16,),
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
            ]),
          ),
        ),
      ),
    );
  }
}
