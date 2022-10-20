import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String message = "";

  final TextEditingController _textEditingUsername = TextEditingController();
  final TextEditingController _textEditingEmail = TextEditingController();
  final TextEditingController _textEditingPassword = TextEditingController();
  final TextEditingController _textEditingConfirmPassword =
      TextEditingController();

  Future SignIn() async {
    try {
      UserCredential data =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _textEditingEmail.text,
        password: _textEditingPassword.text,
      );

      User? user = data.user;

      if (user != null) {
        user.updateDisplayName(_textEditingUsername.text);
      }
    } catch (e) {
      message = e.toString();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'This Is Auth:',
            ),
            TextField(
              controller: _textEditingUsername,
            ),
            TextField(
              controller: _textEditingEmail,
            ),
            TextField(
              controller: _textEditingPassword,
            ),
            TextField(
              controller: _textEditingConfirmPassword,
            ),
            ElevatedButton(
              onPressed: SignIn,
              child: const Text("Log In"),
            ),
            Text(
              message,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
