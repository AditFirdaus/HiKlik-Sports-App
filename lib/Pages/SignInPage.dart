import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String message = "";

  final TextEditingController _textEditingEmail = TextEditingController();
  final TextEditingController _textEditingPassword = TextEditingController();

  Future LogIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _textEditingEmail.text,
        password: _textEditingPassword.text,
      );
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
            Text(
              (_textEditingEmail.text == "123456@gmail.com").toString(),
            ),
            Text(
              (_textEditingPassword.text == "123456").toString(),
            ),
            TextField(
              controller: _textEditingEmail,
            ),
            TextField(
              controller: _textEditingPassword,
            ),
            ElevatedButton(
              onPressed: LogIn,
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
