import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sports/Pages/Classes/UserData.dart';
import 'package:sports/Pages/HomePages/HomeEvents.dart';
import 'package:sports/Pages/HomePages/HomeLocations.dart';
import 'package:sports/Pages/HomePages/HomeNews.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

FirebaseFirestore db = FirebaseFirestore.instance;
String category = "all";

class FireDatabase {
  static void setUserData(String uid, UserData userData) async {
    final data = userData.toJson();

    DocumentReference ref = db.collection("users").doc(uid);

    log(ref.toString());

    await ref.set(data);
  }

  static Future<UserData> getUserData(String uid) async {
    DocumentReference ref = db.collection("users").doc(uid);
    try {
      
    } catch (e) {
      
    }
    DocumentSnapshot<Object?> snapshot = await ref.get();

    Map<String, dynamic> snapshotData = snapshot.data() as Map<String, dynamic>;

    log(snapshotData.toString());

    var data = UserData.fromJson(snapshotData);

    return data;
  }

  static Future<List<UserData>> getMembers() async {
    List<UserData> users = [];

    QuerySnapshot<Map<String, dynamic>> productRef =
        await db.collection("users").get();
    for (var doc in productRef.docs) {
      users.add(UserData.fromJson(doc.data()));
    }
    return users;
  }

  static Future<List<NewsData>> getNews() async {
    List<NewsData> news = [];

    try {
      final response = await http
          .get(Uri.parse('http://hiklik-sports.herokuapp.com/api/articles'));

      String body = response.body;

      Map<String, dynamic> map = jsonDecode(body);

      for (var newsJson in map["data"]) {
        news.add(NewsData.fromJson(newsJson));
      }
    } catch (e) {}

    return news;
  }

  static Future<List<EventData>> getEvents() async {
    List<EventData> news = [];

    try {
      final response = await http
          .get(Uri.parse('http://hiklik-sports.herokuapp.com/api/events'));

      String body = response.body;

      Map<String, dynamic> map = jsonDecode(body);

      for (var eventJson in map["data"]) {
        news.add(EventData.fromJson(eventJson));
      }
    } catch (e) {}

    return news;
  }

  static Future<List<LocationData>> getLocations() async {
    List<LocationData> news = [];

    try {
      final response = await http
          .get(Uri.parse('http://hiklik-sports.herokuapp.com/api/locations'));

      String body = response.body;

      Map<String, dynamic> map = jsonDecode(body);

      for (var newsJson in map["data"]) {
        news.add(LocationData.fromJson(newsJson));
      }
    } catch (e) {}

    return news;
  }
}
