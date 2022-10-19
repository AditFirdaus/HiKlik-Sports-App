import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String message = "";

  final TextEditingController _textEditingEmail = TextEditingController();
  final TextEditingController _textEditingPassword = TextEditingController();

  Future LogIn() async {
    try {
      final String inputEmail = _textEditingEmail.text;
      final String inputPassword = _textEditingPassword.text;

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: inputEmail,
        password: inputPassword,
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
