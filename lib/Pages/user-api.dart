import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sports/Pages/Classes/UserData.dart';
import 'package:sports/Pages/api/contents-api.dart';

class FireUser {
  static UserData currentUserData = UserData();

  static FirebaseAuth auth = FirebaseAuth.instance;
  static User? get user => auth.currentUser;

  static Future SyncIn() async {
    String? uid = user?.uid;
    currentUserData = await getUser(uid!);
    log("SyncIn Success");
  }

  static Future SyncUp() async {
    String? uid = user?.uid;
    if (uid != null) await setUser(uid!, currentUserData);
    log("SyncUp Success");
  }

  static Future setUser(String uid, UserData userData) async {
    return FireDatabase.setUserData(uid, userData);
  }

  static Future<UserData> getUser(String uid) async {
    return await FireDatabase.getUserData(uid);
  }

  static Future<UserCredential> SignIn(String _email, String _password) async {
    log("""Sign In using 
    email: $_email
    password: $_password""");

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      log("""Sign In successfull with credentials:
      ${userCredential.toString()}""");

      await FireUser.SyncIn();
      await FireUser.SyncUp();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      log('Sign In failed with error code: ${e.code}');
      log(e.message!);
      rethrow;
    }
  }

  static Future<UserCredential> SignUp(String _email, String _password) async {
    log("""Sign Up using 
    email: $_email
    password: $_password""");

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _email,
      );

      UserData userData = UserData();

      FireDatabase.setUserData(userCredential.user!.uid, userData);

      await FireUser.SyncUp();
      await FireUser.SyncIn();

      log("""Sign Up successfull with credentials:
      ${userCredential.toString()}""");
      return userCredential;
    } on FirebaseAuthException catch (e) {
      log('Sign Up failed with error code: ${e.code}');
      log(e.message!);
      rethrow;
    }
  }
}
