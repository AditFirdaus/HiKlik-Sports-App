import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sports/Pages/Classes/UserData.dart';
import 'package:sports/Pages/HomePages/HomeEvents.dart';
import 'package:sports/Pages/HomePages/HomeLocations.dart';
import 'package:sports/Pages/HomePages/HomeNews.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

FirebaseFirestore db = FirebaseFirestore.instance;

class FireDatabase {
  static Future setUserData(String uid, UserData userData) async {
    try {
      final data = userData.toJson();

      DocumentReference ref = db.collection("users").doc(uid);

      log("Set UserData Successfully with Data: ${ref.toString()}");

      await ref.set(data);
    } catch (e) {
      log("Set UserData Failed");
    }
  }

  static Future<UserData> getUserData(String uid) async {
    var data = UserData();

    DocumentReference ref = db.collection("users").doc(uid);

    try {
      DocumentSnapshot<Object?> snapshot = await ref.get();

      Map<String, dynamic> snapshotData =
          snapshot.data() as Map<String, dynamic>;

      log("Get UserData Successfully with Data: ${ref.toString()}");

      data = UserData.fromJson(snapshotData);
    } catch (e) {
      log("Get UserData Failed");
    }

    return data;
  }

  static Future<List<UserData>> getMembers({String category = ""}) async {
    List<UserData> users = [];

    QuerySnapshot<Map<String, dynamic>> productRef;

    if (category == "")
    {
      productRef = await db.collection("users").get();
    }
    else
    {
      productRef = await db.collection("users").where('sport', isEqualTo: category).get();
    }
    for (var doc in productRef.docs) {
      users.add(UserData.fromJson(doc.data()));
    }

    return users;
  }

  static Future<List<NewsData>> getNews({String category = ""}) async {
    List<NewsData> news = [];

    try {
      final response = await http.get(Uri.parse(
          'http://hiklik-sports.herokuapp.com/api/articles?category=$category'));

      String body = response.body;
      
      Map<String, dynamic> map = jsonDecode(body);

      for (var newsJson in map["data"]["data"]) {
        news.add(NewsData.fromJson(newsJson));
      }
    } catch (e) {
      log("Fetch news failed");
    }

    return news;
  }

  static Future<List<EventData>> getEvents({String category = ""}) async {
    List<EventData> news = [];

    try {
      final response = await http.get(Uri.parse(
          'http://hiklik-sports.herokuapp.com/api/events?category=$category'));

      String body = response.body;

      Map<String, dynamic> map = jsonDecode(body);

      for (var eventJson in map["data"]["data"]) {
        news.add(EventData.fromJson(eventJson));
      }
    } catch (e) {
      log("Fetch events failed");
    }

    return news;
  }

  static Future<List<LocationData>> getLocations({String category = ""}) async {
    List<LocationData> news = [];

    try {
      final response = await http.get(Uri.parse(
          'http://hiklik-sports.herokuapp.com/api/locations?category=$category'));

      String body = response.body;

      Map<String, dynamic> map = jsonDecode(body);

      for (var newsJson in map["data"]["data"]) {
        news.add(LocationData.fromJson(newsJson));
      }
    } catch (e) {
      log("Fetch locations failed");
    }

    return news;
  }
}
