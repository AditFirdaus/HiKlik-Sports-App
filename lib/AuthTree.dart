import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sports/Pages/SignInPage.dart';
import 'package:sports/Pages/HomePage.dart';
import 'package:sports/main.dart';

class AuthTree extends StatelessWidget {
  const AuthTree();

  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const SignInPage();
        }
      },
    );
  }
}
