import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sports/AuthTree.dart';
import 'package:sports/firebase_options.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HiKlik Sports App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const AuthTree(),
    );
  }
}
