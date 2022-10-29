import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sports/Pages/Classes/UserData.dart';
import 'package:sports/Pages/api/contents-api.dart';

class FireUser {
  static UserData currentUserData = UserData();

  static FirebaseAuth auth = FirebaseAuth.instance;
  static User? get user => auth.currentUser;

  static Future SyncIn  () async {
    String? uid = user?.uid;
    try
    {
      currentUserData = await getUser(uid!);
      log("SyncIn Success");
    }
    catch (e)
    {
      log("SyncIn Failed");
    }
    
  }

  static Future SyncUp() async {
    String? uid = user?.uid;
    try
    {
      if (uid != null) await setUser(uid, currentUserData);
      log("SyncUp Success");
    }
    catch (e)
    {
      log("SyncUp Failed");
    }
  }

  static Future setUser(String uid, UserData userData) async {
    try {
      return await FireDatabase.setUserData(uid, userData);
    } catch (e) {
      log("Failed to get UserData from uid: ${uid}");
    }
    return UserData();
  }

  static Future<UserData> getUser(String uid) async {
    try {
      return await FireDatabase.getUserData(uid);
    } catch (e) {
      log("Failed to get UserData from uid: ${uid}");
    }
    return UserData();
  }
}
