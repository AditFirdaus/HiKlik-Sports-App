import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sports/Pages/HomePage.dart';
import 'package:sports/Pages/ProfileEditPage.dart';
import 'package:sports/Pages/SignUpPage.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      checkEmailVerified();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            "An email has been sent to ${user.email}, please verify",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    log("\t Checking verification ...");
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      log("\t Verification Complete");
      timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const HomePage())));
      Navigator.of(context).push(
          MaterialPageRoute(builder: ((context) => ProfileEditPage(true))));
    }
  }
}
