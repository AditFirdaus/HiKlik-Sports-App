import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String message = "";

  Future updateData() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    setState(() {
      message = snapshot.data().toString();
    });
  }

  Future LogOut() async {
    FirebaseAuth.instance.signOut();
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
              'This Is Home',
            ),
            Text(
              '$message',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: LogOut,
              child: Text("Log Out"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: updateData,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
